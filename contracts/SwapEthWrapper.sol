// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "./Swap.sol";

contract SwapEthWrapper {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    Swap public immutable swap;
    LPToken public immutable lpToken;
    address public immutable weth;
    IERC20[] public pooledTokens;
    uint256 public immutable wethIndex;

    uint8 private constant MAX_UINT8 = 2**8 - 1;
    uint256 private constant MAX_UINT256 = 2**256 - 1;

    constructor(address wethAddress, Swap swapAddress) public {
        swap = swapAddress;
        lpToken = swap.swapStorage().lpToken;
        wethIndex = MAX_UINT8;

        for (uint8 = 0; i < 32; i++) {
            try swap.getToken(i) returns (IERC20 token) {
                pooledTokens.push(token);
                if (token == wethAddress) {
                    wethIndex = i;
                }
                // Approve pooled tokens to be used by Swap
                token.approve(swap, MAX_UINT256);
            } catch {
                break;
            }
        }
        require(wethIndex != MAX_UINT8, "WETH was not found in the swap pool");
        // Approve LPToken to be used by Swap
        lpToken.approve(swap, MAX_UINT256);
    }

    function addLiquidity(
        uint256[] memory amounts,
        uint256 minToMint,
        uint256 deadline
    ) external payable returns (uint256) {
        // If using ETH, deposit them to WETH.
        if (msg.value > 0) {
            IWETH9(weth).deposit{value: msg.value}();
        }
        // If using WETH, transfer them to this contract.
        if (amounts[wethIndex] > 0) {
            IWETH9(weth).transferFrom(msg.sender, address(this), amount);
        }
        // Sum up the ETH and WETH amount.
        amounts[wethIndex] = amounts[wethIndex].add(msg.value);
        // Go through amounts array and transfer respective tokens to this contract.
        for (uint256 i = 0; i < amounts.length; i++) {
            uint256 amount = amounts[i];
            if (i != wethIndex && amount > 0) {
                pooledTokens[i].safeTransferFrom(
                    msg.sender,
                    address(this),
                    amount
                );
            }
        }
        // Add the assets to the pool
        uint256 lpTokenAmount = swap.addLiquidity(amounts, minToMint, deadline);
        // Send the LPToken to msg.sender
        IERC20(lpToken).safeTransfer(msg.sender, lpTokenAmount);
        return lpTokenAmount;
    }

    function removeLiquidity(
        uint256 amount,
        uint256[] calldata minAmounts,
        uint256 deadline
    ) external returns (uint256[] memory) {
        // Transfer LPToken from msg.sender to this contract.
        IERC20(lpToken).safeTransferFrom(msg.sender, address(this), amount);
        // Remove liquidity
        uint256[] memory amounts =
            swap.removeLiquidity(amount, minAmounts, deadline);
        // Send the tokens back to the user
        for (uint256 i = 0; i < amounts.length; i++) {
            if (i != wethIndex) {
                pooledTokens[i].safeTransfer(msg.sender, amounts[i]);
            } else {
                IWETH9(weth).withdraw(amounts[i]);
                (bool success, ) = msg.sender.call{value: amounts[i]}("");
                require(success, "ETH_TRANSFER_FAILED");
            }
        }
        return amounts;
    }

    function removeLiquidityOneToken(
        uint256 tokenAmount,
        uint8 tokenIndex,
        uint256 minAmount,
        uint256 deadline
    ) external returns (uint256) {
        // Transfer LPToken from msg.sender to this contract.
        IERC20(lpToken).safeTransferFrom(
            msg.sender,
            address(this),
            tokenAmount
        );
        // Withdraw via single token
        uint256 amount =
            swap.removeLiquidityOneToken(
                tokenAmount,
                tokenIndex,
                minAmount,
                deadline
            );
        // Transfer the token to msg.sender accordingly
        if (tokenIndex != wethIndex) {
            pooledTokens[i].safeTransfer(msg.sender, amount);
        } else {
            IWETH9(weth).withdraw(amount);
            (bool success, ) = msg.sender.call{value: amount}("");
            require(success, "ETH_TRANSFER_FAILED");
        }
        return amount;
    }

    function removeLiquidityImbalance(
        uint256[] calldata amounts,
        uint256 maxBurnAmount,
        uint256 deadline
    ) external returns (uint256) {
        // Transfer LPToken from msg.sender to this contract.
        IERC20(lpToken).safeTransferFrom(
            msg.sender,
            address(this),
            tokenAmount
        );
        // Withdraw in imbalanced ratio
        uint256 burnedLpTokenAmount =
            swap.removeLiquidityImbalance(amounts, maxBurnAmount, deadline);
        // Send the tokens back to the user
        for (uint256 i = 0; i < amounts.length; i++) {
            if (i != wethIndex) {
                pooledTokens[i].safeTransfer(msg.sender, amounts[i]);
            } else {
                IWETH9(weth).withdraw(amounts[i]);
                (bool success, ) = msg.sender.call{value: amounts[i]}("");
                require(success, "ETH_TRANSFER_FAILED");
            }
        }
        return burnedLpTokenAmount;
    }

    function swap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline
    ) external returns (uint256) {
        // Transfer tokens from msg.sender to this contract
        if (tokenIndexFrom != wethIndex) {
            IERC20(pooledTokens[tokenIndexFrom]).safeTransferFrom(
                msg.sender,
                address(this),
                dx
            );
        } else {
            IWETH9(weth).deposit{value: msg.value}();
        }
        // Execute swap
        uint256 dy =
            swap.swap(tokenIndexFrom, tokenIndexTo, dx, minDy, deadline);
        // Transfer the swapped tokens to msg.sender
        if (tokenIndexTo != wethIndex) {
            IERC20(pooledTokens[tokenIndexTo]).safeTransfer(msg.sender, dy);
        } else {
            IWETH9(weth).withdraw(amounts[i]);
            (bool success, ) = msg.sender.call{value: amounts[i]}("");
            require(success, "ETH_TRANSFER_FAILED");
        }
        return dy;
    }

    function skim() external {
        IERC20[] memory tokens = pooledTokens;
        for (uint256 i = 0; i < tokens.length; i++) {
            tokens[i].safeTransfer(
                msg.sender,
                tokens[i].balanceOf(address(this))
            );
        }
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "ETH_TRANSFER_FAILED");
    }

    receive() external payable {}
}