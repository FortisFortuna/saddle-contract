pragma solidity >=0.8.0;

library Math {
    
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }
    
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
    
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
    }
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}
interface IAnyswapV4ERC20 {
  function DOMAIN_SEPARATOR() external view returns(bytes32);
  function PERMIT_TYPEHASH() external view returns(bytes32);
  function Swapin(bytes32 txhash, address account, uint256 amount) external returns(bool);
  function Swapout(uint256 amount, address bindaddr) external returns(bool);
  function TRANSFER_TYPEHASH() external view returns(bytes32);
  function allowance(address, address) external view returns(uint256);
  function applyMinter() external;
  function applyVault() external;
  function approve(address spender, uint256 value) external returns(bool);
  function approveAndCall(address spender, uint256 value, bytes calldata data) external returns(bool);
  function balanceOf(address) external view returns(uint256);
  function burn(address from, uint256 amount) external returns(bool);
  function changeMPCOwner(address newVault) external returns(bool);
  function changeVault(address newVault) external returns(bool);
  function decimals() external view returns(uint8);
  function delay() external view returns(uint256);
  function delayDelay() external view returns(uint256);
  function delayMinter() external view returns(uint256);
  function delayVault() external view returns(uint256);
  function deposit(uint256 amount, address to) external returns(uint256);
  function deposit(uint256 amount) external returns(uint256);
  function deposit() external returns(uint256);
  function depositVault(uint256 amount, address to) external returns(uint256);
  function depositWithPermit(address target, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s, address to) external returns(uint256);
  function depositWithTransferPermit(address target, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s, address to) external returns(uint256);
  function getAllMinters() external view returns(address[] memory);
  function initVault(address _vault) external;
  function isMinter(address) external view returns(bool);
  function mint(address to, uint256 amount) external returns(bool);
  function minters(uint256) external view returns(address);
  function mpc() external view returns(address);
  function name() external view returns(string memory);
  function nonces(address) external view returns(uint256);
  function owner() external view returns(address);
  function pendingDelay() external view returns(uint256);
  function pendingMinter() external view returns(address);
  function pendingVault() external view returns(address);
  function permit(address target, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
  function revokeMinter(address _auth) external;
  function setMinter(address _auth) external;
  function setVault(address _vault) external;
  function setVaultOnly(bool enabled) external;
  function symbol() external view returns(string memory);
  function totalSupply() external view returns(uint256);
  function transfer(address to, uint256 value) external returns(bool);
  function transferAndCall(address to, uint256 value, bytes calldata data) external returns(bool);
  function transferFrom(address from, address to, uint256 value) external returns(bool);
  function transferWithPermit(address target, address to, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external returns(bool);
  function underlying() external view returns(address);
  function vault() external view returns(address);
  function withdraw(uint256 amount, address to) external returns(uint256);
  function withdraw(uint256 amount) external returns(uint256);
  function withdraw() external returns(uint256);
  function withdrawVault(address from, uint256 amount, address to) external returns(uint256);
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }
    function _msgData() internal view virtual returns (bytes memory) {
        this;
        return msg.data;
    }
}

library SafeMath {
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
    
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
        return c;
    }
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
    
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }
    
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }
    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }
    
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

interface IERC20 {
    
    function totalSupply() external view returns (uint256);
    
    function balanceOf(address account) external view returns (uint256);
    
    function transfer(address recipient, uint256 amount) external returns (bool);
    
    function allowance(address owner, address spender) external view returns (uint256);
    
    function approve(address spender, uint256 amount) external returns (bool);
    
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library Address {
    
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(account) }
        return size > 0;
    }
    
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
    
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }
    
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }
    
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }
    
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }
    
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }
    
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }
    
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }
    
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }
    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

 
contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    
    constructor (string memory __name, string memory __symbol) public {
        _name = __name;
        _symbol = __symbol;
        _decimals = 18;
    }
    
    function name() public view returns (string memory) {
        return _name;
    }
    
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
    
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
    
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }
    
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }
    
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }
    
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }
    
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }
    
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }
    
    function burnFrom(address account, uint256 amount) public virtual {
        uint256 decreasedAllowance = allowance(account, _msgSender()).sub(amount, "ERC20: burn amount exceeds allowance");
        _approve(account, _msgSender(), decreasedAllowance);
        _burn(account, amount);
    }
    
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");
        _beforeTokenTransfer(account, address(0), amount);
        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
    
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    
    function _burnFrom(address account, uint256 amount) internal virtual {
        _burn(account, amount);
        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

interface IERC20Permit {
    
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
    
    function nonces(address owner) external view returns (uint256);
    
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

library ECDSA {
    enum RecoverError {
        NoError,
        InvalidSignature,
        InvalidSignatureLength,
        InvalidSignatureS,
        InvalidSignatureV
    }
    function _throwError(RecoverError error) private pure {
        if (error == RecoverError.NoError) {
            return;
        } else if (error == RecoverError.InvalidSignature) {
            revert("ECDSA: invalid signature");
        } else if (error == RecoverError.InvalidSignatureLength) {
            revert("ECDSA: invalid signature length");
        } else if (error == RecoverError.InvalidSignatureS) {
            revert("ECDSA: invalid signature 's' value");
        } else if (error == RecoverError.InvalidSignatureV) {
            revert("ECDSA: invalid signature 'v' value");
        }
    }
    
    function tryRecover(bytes32 hash, bytes memory signature) internal pure returns (address, RecoverError) {
        if (signature.length == 65) {
            bytes32 r;
            bytes32 s;
            uint8 v;
            assembly {
                r := mload(add(signature, 0x20))
                s := mload(add(signature, 0x40))
                v := byte(0, mload(add(signature, 0x60)))
            }
            return tryRecover(hash, v, r, s);
        } else if (signature.length == 64) {
            bytes32 r;
            bytes32 vs;
            assembly {
                r := mload(add(signature, 0x20))
                vs := mload(add(signature, 0x40))
            }
            return tryRecover(hash, r, vs);
        } else {
            return (address(0), RecoverError.InvalidSignatureLength);
        }
    }
    
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, signature);
        _throwError(error);
        return recovered;
    }
    
    function tryRecover(
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal pure returns (address, RecoverError) {
        bytes32 s;
        uint8 v;
        assembly {
            s := and(vs, 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            v := add(shr(255, vs), 27)
        }
        return tryRecover(hash, v, r, s);
    }
    
    function recover(
        bytes32 hash,
        bytes32 r,
        bytes32 vs
    ) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, r, vs);
        _throwError(error);
        return recovered;
    }
    
    function tryRecover(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal pure returns (address, RecoverError) {
        if (uint256(s) > 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0) {
            return (address(0), RecoverError.InvalidSignatureS);
        }
        if (v != 27 && v != 28) {
            return (address(0), RecoverError.InvalidSignatureV);
        }
        address signer = ecrecover(hash, v, r, s);
        if (signer == address(0)) {
            return (address(0), RecoverError.InvalidSignature);
        }
        return (signer, RecoverError.NoError);
    }
    
    function recover(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal pure returns (address) {
        (address recovered, RecoverError error) = tryRecover(hash, v, r, s);
        _throwError(error);
        return recovered;
    }
    
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
    
    function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
    }
}

abstract contract EIP712 {
    
    bytes32 private immutable _CACHED_DOMAIN_SEPARATOR;
    uint256 private immutable _CACHED_CHAIN_ID;
    bytes32 private immutable _HASHED_NAME;
    bytes32 private immutable _HASHED_VERSION;
    bytes32 private immutable _TYPE_HASH;
    
    
    constructor(string memory name, string memory version) {
        bytes32 hashedName = keccak256(bytes(name));
        bytes32 hashedVersion = keccak256(bytes(version));
        bytes32 typeHash = keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );
        _HASHED_NAME = hashedName;
        _HASHED_VERSION = hashedVersion;
        _CACHED_CHAIN_ID = block.chainid;
        _CACHED_DOMAIN_SEPARATOR = _buildDomainSeparator(typeHash, hashedName, hashedVersion);
        _TYPE_HASH = typeHash;
    }
    
    function _domainSeparatorV4() internal view returns (bytes32) {
        if (block.chainid == _CACHED_CHAIN_ID) {
            return _CACHED_DOMAIN_SEPARATOR;
        } else {
            return _buildDomainSeparator(_TYPE_HASH, _HASHED_NAME, _HASHED_VERSION);
        }
    }
    function _buildDomainSeparator(
        bytes32 typeHash,
        bytes32 nameHash,
        bytes32 versionHash
    ) private view returns (bytes32) {
        return keccak256(abi.encode(typeHash, nameHash, versionHash, block.chainid, address(this)));
    }
    
    function _hashTypedDataV4(bytes32 structHash) internal view virtual returns (bytes32) {
        return ECDSA.toTypedDataHash(_domainSeparatorV4(), structHash);
    }
}

library Counters {
    struct Counter {
        uint256 _value;
    }
    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }
    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }
    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }
    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}

abstract contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
    using Counters for Counters.Counter;
    mapping(address => Counters.Counter) private _nonces;
    bytes32 private immutable _PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    
    constructor(string memory name) EIP712(name, "1") {}
    
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual override {
        require(block.timestamp <= deadline, "ERC20Permit: expired deadline");
        bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, owner, spender, value, _useNonce(owner), deadline));
        bytes32 hash = _hashTypedDataV4(structHash);
        address signer = ECDSA.recover(hash, v, r, s);
        require(signer == owner, "ERC20Permit: invalid signature");
        _approve(owner, spender, value);
    }
    
    function nonces(address owner) public view virtual override returns (uint256) {
        return _nonces[owner].current();
    }
    
    function DOMAIN_SEPARATOR() external view override returns (bytes32) {
        return _domainSeparatorV4();
    }
    function PERMIT_TYPEHASH() external view returns (bytes32) {
        return _PERMIT_TYPEHASH;
    }
    
    function _useNonce(address owner) internal virtual returns (uint256 current) {
        Counters.Counter storage nonce = _nonces[owner];
        current = nonce.current();
        nonce.increment();
    }
}
library TransferHelper {
    function safeApprove(address token, address to, uint value) internal {
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }
    function safeTransfer(address token, address to, uint value) internal {
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }
    function safeTransferFrom(address token, address from, address to, uint value) internal {
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }
    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}
contract Owned {
    address public owner;
    address public nominatedOwner;
    constructor (address _owner) public {
        require(_owner != address(0), "Owner address cannot be 0");
        owner = _owner;
        emit OwnerChanged(address(0), _owner);
    }
    function nominateNewOwner(address _owner) external onlyOwner {
        nominatedOwner = _owner;
        emit OwnerNominated(_owner);
    }
    function acceptOwnership() external {
        require(msg.sender == nominatedOwner, "You must be nominated before you can accept ownership");
        emit OwnerChanged(owner, nominatedOwner);
        owner = nominatedOwner;
        nominatedOwner = address(0);
    }
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner may perform this action");
        _;
    }
    event OwnerNominated(address newOwner);
    event OwnerChanged(address oldOwner, address newOwner);
}

abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status;
    constructor () internal {
        _status = _NOT_ENTERED;
    }
    
    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }
}
contract CrossChainCanonical is ERC20Permit, Owned, ReentrancyGuard {
    using SafeMath for uint256;
    
    address public timelock_address;
    address public custodian_address; 
    uint256 public mint_cap;
    mapping(address => uint256[2]) public swap_fees;
    mapping(address => bool) public fee_exempt_list;
    address[] public bridge_tokens_array;
    mapping(address => bool) public bridge_tokens;
    address[] public minters_array;
    mapping(address => bool) public minters;
    uint256 private constant PRICE_PRECISION = 1e6;
    bool public exchangesPaused;
    mapping(address => bool) public canSwap;
    
    modifier onlyByOwnGov() {
        require(msg.sender == timelock_address || msg.sender == owner, "Not owner or timelock");
        _;
    }
    modifier onlyByOwnGovCust() {
        require(msg.sender == timelock_address || msg.sender == owner || msg.sender == custodian_address, "Not owner, tlck, or custd");
        _;
    }
    modifier onlyMinters() {
       require(minters[msg.sender], "Not a minter");
        _;
    } 
    modifier onlyMintersOwnGov() {
       require(_isMinterOwnGov(msg.sender), "Not minter, owner, or tlck");
        _;
    } 
    modifier validBridgeToken(address token_address) {
       require(bridge_tokens[token_address], "Invalid old token");
        _;
    } 
    
    constructor (
        string memory _name,
        string memory _symbol,
        address _creator_address,
        uint256 _initial_mint_amt,
        address _custodian_address,
        address[] memory _bridge_tokens
    ) ERC20(_name, _symbol) ERC20Permit(_name) Owned(_creator_address) {
        custodian_address = _custodian_address;
        for (uint256 i = 0; i < _bridge_tokens.length; i++){ 
            bridge_tokens[_bridge_tokens[i]] = true;
            bridge_tokens_array.push(_bridge_tokens[i]);
            swap_fees[_bridge_tokens[i]] = [400, 400];
            canSwap[_bridge_tokens[i]] = true;
        }
        mint_cap = _initial_mint_amt;
        super._mint(_creator_address, _initial_mint_amt);
    }
    
    function allBridgeTokens() external view returns (address[] memory) {
        return bridge_tokens_array;
    }
    function _isMinterOwnGov(address the_address) internal view returns (bool) {
        return (the_address == timelock_address || the_address == owner || minters[the_address]);
    }
    function _isFeeExempt(address the_address) internal view returns (bool) {
        return (_isMinterOwnGov(the_address) || fee_exempt_list[the_address]);
    }
    
    function _mint_capped(address account, uint256 amount) internal {
        require(totalSupply() + amount <= mint_cap, "Mint cap");
        super._mint(account, amount);
    }
    
    function exchangeOldForCanonical(address bridge_token_address, uint256 token_amount) external nonReentrant validBridgeToken(bridge_token_address) returns (uint256 canonical_tokens_out) {
        require(!exchangesPaused && canSwap[bridge_token_address], "Exchanges paused");
        TransferHelper.safeTransferFrom(bridge_token_address, msg.sender, address(this), token_amount);
        canonical_tokens_out = token_amount;
        if (!_isFeeExempt(msg.sender)) {
            canonical_tokens_out -= ((canonical_tokens_out * swap_fees[bridge_token_address][0]) / PRICE_PRECISION);
        }
        _mint_capped(msg.sender, canonical_tokens_out);
    }
    function exchangeCanonicalForOld(address bridge_token_address, uint256 token_amount) external nonReentrant validBridgeToken(bridge_token_address) returns (uint256 bridge_tokens_out) {
        require(!exchangesPaused && canSwap[bridge_token_address], "Exchanges paused");
        
        super._burn(msg.sender, token_amount);
        bridge_tokens_out = token_amount;
        if (!_isFeeExempt(msg.sender)) {
            bridge_tokens_out -= ((bridge_tokens_out * swap_fees[bridge_token_address][1]) / PRICE_PRECISION);
        }
        TransferHelper.safeTransfer(bridge_token_address, msg.sender, bridge_tokens_out);
    }
    
    function withdrawBridgeTokens(address bridge_token_address, uint256 bridge_token_amount) external onlyMintersOwnGov validBridgeToken(bridge_token_address) {
        TransferHelper.safeTransfer(bridge_token_address, msg.sender, bridge_token_amount);
    }
    
    function minter_mint(address m_address, uint256 m_amount) external onlyMinters {
        _mint_capped(m_address, m_amount);
        emit TokenMinted(msg.sender, m_address, m_amount);
    }
    function minter_burn(uint256 amount) external onlyMinters {
        super._burn(msg.sender, amount);
        emit TokenBurned(msg.sender, amount);
    }
    
    function toggleExchanges() external onlyByOwnGovCust {
        exchangesPaused = !exchangesPaused;
    }
    
    function addBridgeToken(address bridge_token_address, uint256 _brdg_to_can_fee, uint256 _can_to_brdg_fee) external onlyByOwnGov {
        for (uint i = 0; i < bridge_tokens_array.length; i++){ 
            if (bridge_tokens_array[i] == bridge_token_address){
                revert("Token already present");
            }
        }
        bridge_tokens[bridge_token_address] = true;
        bridge_tokens_array.push(bridge_token_address);
        canSwap[bridge_token_address] = true;
        swap_fees[bridge_token_address][0] = _brdg_to_can_fee;
        swap_fees[bridge_token_address][1] = _can_to_brdg_fee;
        emit BridgeTokenAdded(bridge_token_address);
    }
    function toggleBridgeToken(address bridge_token_address) external onlyByOwnGov {
        bool bridge_tkn_found;
        for (uint i = 0; i < bridge_tokens_array.length; i++){ 
            if (bridge_tokens_array[i] == bridge_token_address){
                bridge_tkn_found = true;
                break;
            }
        }
        require(bridge_tkn_found, "Bridge tkn not in array");
        bridge_tokens[bridge_token_address] = !bridge_tokens[bridge_token_address];
        canSwap[bridge_token_address] = !canSwap[bridge_token_address];
        emit BridgeTokenToggled(bridge_token_address, !bridge_tokens[bridge_token_address]);
    }
    function addMinter(address minter_address) external onlyByOwnGov {
        require(minter_address != address(0), "Zero address detected");
        require(minters[minter_address] == false, "Address already exists");
        minters[minter_address] = true; 
        minters_array.push(minter_address);
        emit MinterAdded(minter_address);
    }
    function removeMinter(address minter_address) external onlyByOwnGov {
        require(minter_address != address(0), "Zero address detected");
        require(minters[minter_address] == true, "Address nonexistant");
        
        delete minters[minter_address];
        for (uint i = 0; i < minters_array.length; i++){ 
            if (minters_array[i] == minter_address) {
                minters_array[i] = address(0);
                break;
            }
        }
        emit MinterRemoved(minter_address);
    }
    function setMintCap(uint256 _mint_cap) external onlyByOwnGov {
        mint_cap = _mint_cap;
        emit MintCapSet(_mint_cap);
    }
    function setSwapFees(address bridge_token_address, uint256 _bridge_to_canonical, uint256 _canonical_to_old) external onlyByOwnGov {
        swap_fees[bridge_token_address] = [_bridge_to_canonical, _canonical_to_old];
    }
    function toggleFeesForAddress(address the_address) external onlyByOwnGov {
        fee_exempt_list[the_address] = !fee_exempt_list[the_address];
    }
    function setTimelock(address new_timelock) external onlyByOwnGov {
        require(new_timelock != address(0), "Zero address detected");
        timelock_address = new_timelock;
        emit TimelockSet(new_timelock);
    }
    function setCustodian(address _custodian_address) external onlyByOwnGov {
        require(_custodian_address != address(0), "Zero address detected");
        custodian_address = _custodian_address;
        emit CustodianSet(_custodian_address);
    }
    function recoverERC20(address tokenAddress, uint256 tokenAmount) external onlyByOwnGov {
        require(!bridge_tokens[tokenAddress], "Cannot withdraw bridge tokens");
        require(tokenAddress != address(this), "Cannot withdraw these tokens");
        TransferHelper.safeTransfer(address(tokenAddress), msg.sender, tokenAmount);
    }
    
    event TokenBurned(address indexed from, uint256 amount);
    event TokenMinted(address indexed from, address indexed to, uint256 amount);
    event BridgeTokenAdded(address indexed bridge_token_address);
    event BridgeTokenToggled(address indexed bridge_token_address, bool state);
    event MinterAdded(address pool_address);
    event MinterRemoved(address pool_address);
    event MintCapSet(uint256 new_mint_cap);
    event TimelockSet(address new_timelock);
    event CustodianSet(address custodian_address);
}
interface IFrax {
  function COLLATERAL_RATIO_PAUSER() external view returns (bytes32);
  function DEFAULT_ADMIN_ADDRESS() external view returns (address);
  function DEFAULT_ADMIN_ROLE() external view returns (bytes32);
  function addPool(address pool_address ) external;
  function allowance(address owner, address spender ) external view returns (uint256);
  function approve(address spender, uint256 amount ) external returns (bool);
  function balanceOf(address account ) external view returns (uint256);
  function burn(uint256 amount ) external;
  function burnFrom(address account, uint256 amount ) external;
  function collateral_ratio_paused() external view returns (bool);
  function controller_address() external view returns (address);
  function creator_address() external view returns (address);
  function decimals() external view returns (uint8);
  function decreaseAllowance(address spender, uint256 subtractedValue ) external returns (bool);
  function eth_usd_consumer_address() external view returns (address);
  function eth_usd_price() external view returns (uint256);
  function frax_eth_oracle_address() external view returns (address);
  function frax_info() external view returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256);
  function frax_pools(address ) external view returns (bool);
  function frax_pools_array(uint256 ) external view returns (address);
  function frax_price() external view returns (uint256);
  function frax_step() external view returns (uint256);
  function fxs_address() external view returns (address);
  function fxs_eth_oracle_address() external view returns (address);
  function fxs_price() external view returns (uint256);
  function genesis_supply() external view returns (uint256);
  function getRoleAdmin(bytes32 role ) external view returns (bytes32);
  function getRoleMember(bytes32 role, uint256 index ) external view returns (address);
  function getRoleMemberCount(bytes32 role ) external view returns (uint256);
  function globalCollateralValue() external view returns (uint256);
  function global_collateral_ratio() external view returns (uint256);
  function grantRole(bytes32 role, address account ) external;
  function hasRole(bytes32 role, address account ) external view returns (bool);
  function increaseAllowance(address spender, uint256 addedValue ) external returns (bool);
  function last_call_time() external view returns (uint256);
  function minting_fee() external view returns (uint256);
  function name() external view returns (string memory);
  function owner_address() external view returns (address);
  function pool_burn_from(address b_address, uint256 b_amount ) external;
  function pool_mint(address m_address, uint256 m_amount ) external;
  function price_band() external view returns (uint256);
  function price_target() external view returns (uint256);
  function redemption_fee() external view returns (uint256);
  function refreshCollateralRatio() external;
  function refresh_cooldown() external view returns (uint256);
  function removePool(address pool_address ) external;
  function renounceRole(bytes32 role, address account ) external;
  function revokeRole(bytes32 role, address account ) external;
  function setController(address _controller_address ) external;
  function setETHUSDOracle(address _eth_usd_consumer_address ) external;
  function setFRAXEthOracle(address _frax_oracle_addr, address _weth_address ) external;
  function setFXSAddress(address _fxs_address ) external;
  function setFXSEthOracle(address _fxs_oracle_addr, address _weth_address ) external;
  function setFraxStep(uint256 _new_step ) external;
  function setMintingFee(uint256 min_fee ) external;
  function setOwner(address _owner_address ) external;
  function setPriceBand(uint256 _price_band ) external;
  function setPriceTarget(uint256 _new_price_target ) external;
  function setRedemptionFee(uint256 red_fee ) external;
  function setRefreshCooldown(uint256 _new_cooldown ) external;
  function setTimelock(address new_timelock ) external;
  function symbol() external view returns (string memory);
  function timelock_address() external view returns (address);
  function toggleCollateralRatio() external;
  function totalSupply() external view returns (uint256);
  function transfer(address recipient, uint256 amount ) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount ) external returns (bool);
  function weth_address() external view returns (address);
}
interface IFxs {
  function DEFAULT_ADMIN_ROLE() external view returns(bytes32);
  function FRAXStablecoinAdd() external view returns(address);
  function FXS_DAO_min() external view returns(uint256);
  function allowance(address owner, address spender) external view returns(uint256);
  function approve(address spender, uint256 amount) external returns(bool);
  function balanceOf(address account) external view returns(uint256);
  function burn(uint256 amount) external;
  function burnFrom(address account, uint256 amount) external;
  function checkpoints(address, uint32) external view returns(uint32 fromBlock, uint96 votes);
  function decimals() external view returns(uint8);
  function decreaseAllowance(address spender, uint256 subtractedValue) external returns(bool);
  function genesis_supply() external view returns(uint256);
  function getCurrentVotes(address account) external view returns(uint96);
  function getPriorVotes(address account, uint256 blockNumber) external view returns(uint96);
  function getRoleAdmin(bytes32 role) external view returns(bytes32);
  function getRoleMember(bytes32 role, uint256 index) external view returns(address);
  function getRoleMemberCount(bytes32 role) external view returns(uint256);
  function grantRole(bytes32 role, address account) external;
  function hasRole(bytes32 role, address account) external view returns(bool);
  function increaseAllowance(address spender, uint256 addedValue) external returns(bool);
  function mint(address to, uint256 amount) external;
  function name() external view returns(string memory);
  function numCheckpoints(address) external view returns(uint32);
  function oracle_address() external view returns(address);
  function owner_address() external view returns(address);
  function pool_burn_from(address b_address, uint256 b_amount) external;
  function pool_mint(address m_address, uint256 m_amount) external;
  function renounceRole(bytes32 role, address account) external;
  function revokeRole(bytes32 role, address account) external;
  function setFRAXAddress(address frax_contract_address) external;
  function setFXSMinDAO(uint256 min_FXS) external;
  function setOracle(address new_oracle) external;
  function setOwner(address _owner_address) external;
  function setTimelock(address new_timelock) external;
  function symbol() external view returns(string memory);
  function timelock_address() external view returns(address);
  function toggleVotes() external;
  function totalSupply() external view returns(uint256);
  function trackingVotes() external view returns(bool);
  function transfer(address recipient, uint256 amount) external returns(bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns(bool);
}
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);
  function description() external view returns (string memory);
  function version() external view returns (uint256);
  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}
interface IFraxAMOMinter {
  function FRAX() external view returns(address);
  function FXS() external view returns(address);
  function acceptOwnership() external;
  function addAMO(address amo_address, bool sync_too) external;
  function allAMOAddresses() external view returns(address[] memory);
  function allAMOsLength() external view returns(uint256);
  function amos(address) external view returns(bool);
  function amos_array(uint256) external view returns(address);
  function burnFraxFromAMO(uint256 frax_amount) external;
  function burnFxsFromAMO(uint256 fxs_amount) external;
  function col_idx() external view returns(uint256);
  function collatDollarBalance() external view returns(uint256);
  function collatDollarBalanceStored() external view returns(uint256);
  function collat_borrow_cap() external view returns(int256);
  function collat_borrowed_balances(address) external view returns(int256);
  function collat_borrowed_sum() external view returns(int256);
  function collateral_address() external view returns(address);
  function collateral_token() external view returns(address);
  function correction_offsets_amos(address, uint256) external view returns(int256);
  function custodian_address() external view returns(address);
  function dollarBalances() external view returns(uint256 frax_val_e18, uint256 collat_val_e18);
  function fraxDollarBalanceStored() external view returns(uint256);
  function fraxTrackedAMO(address amo_address) external view returns(int256);
  function fraxTrackedGlobal() external view returns(int256);
  function frax_mint_balances(address) external view returns(int256);
  function frax_mint_cap() external view returns(int256);
  function frax_mint_sum() external view returns(int256);
  function fxs_mint_balances(address) external view returns(int256);
  function fxs_mint_cap() external view returns(int256);
  function fxs_mint_sum() external view returns(int256);
  function giveCollatToAMO(address destination_amo, uint256 collat_amount) external;
  function min_cr() external view returns(uint256);
  function mintFraxForAMO(address destination_amo, uint256 frax_amount) external;
  function mintFxsForAMO(address destination_amo, uint256 fxs_amount) external;
  function missing_decimals() external view returns(uint256);
  function nominateNewOwner(address _owner) external;
  function nominatedOwner() external view returns(address);
  function oldPoolCollectAndGive(address destination_amo) external;
  function oldPoolRedeem(uint256 frax_amount) external;
  function old_pool() external view returns(address);
  function owner() external view returns(address);
  function pool() external view returns(address);
  function receiveCollatFromAMO(uint256 usdc_amount) external;
  function recoverERC20(address tokenAddress, uint256 tokenAmount) external;
  function removeAMO(address amo_address, bool sync_too) external;
  function setAMOCorrectionOffsets(address amo_address, int256 frax_e18_correction, int256 collat_e18_correction) external;
  function setCollatBorrowCap(uint256 _collat_borrow_cap) external;
  function setCustodian(address _custodian_address) external;
  function setFraxMintCap(uint256 _frax_mint_cap) external;
  function setFraxPool(address _pool_address) external;
  function setFxsMintCap(uint256 _fxs_mint_cap) external;
  function setMinimumCollateralRatio(uint256 _min_cr) external;
  function setTimelock(address new_timelock) external;
  function syncDollarBalances() external;
  function timelock_address() external view returns(address);
}
contract FraxPoolV3 is Owned {
    using SafeMath for uint256;
    
    address public timelock_address;
    address public custodian_address;
    IFrax private FRAX = IFrax(0x853d955aCEf822Db058eb8505911ED77F175b99e);
    IFxs private FXS = IFxs(0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0);
    mapping(address => bool) public amo_minter_addresses;
    AggregatorV3Interface public priceFeedFRAXUSD = AggregatorV3Interface(0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD);
    AggregatorV3Interface public priceFeedFXSUSD = AggregatorV3Interface(0x6Ebc52C8C1089be9eB3945C4350B68B8E4C2233f);
    uint256 private chainlink_frax_usd_decimals;
    uint256 private chainlink_fxs_usd_decimals;
    address[] public collateral_addresses;
    string[] public collateral_symbols;
    uint256[] public missing_decimals;
    uint256[] public pool_ceilings;
    uint256[] public collateral_prices;
    mapping(address => uint256) public collateralAddrToIdx;
    mapping(address => bool) public enabled_collaterals;
    
    mapping (address => uint256) public redeemFXSBalances;
    mapping (address => mapping(uint256 => uint256)) public redeemCollateralBalances;
    uint256[] public unclaimedPoolCollateral;
    uint256 public unclaimedPoolFXS;
    mapping (address => uint256) public lastRedeemed;
    uint256 public redemption_delay = 2;
    uint256 public redeem_price_threshold = 990000;
    uint256 public mint_price_threshold = 1010000;
    
    mapping(uint256 => uint256) public bbkHourlyCum;
    uint256 public bbkMaxColE18OutPerHour = 1000e18;
    mapping(uint256 => uint256) public rctHourlyCum;
    uint256 public rctMaxFxsOutPerHour = 1000e18;
    uint256[] private minting_fee;
    uint256[] private redemption_fee;
    uint256[] private buyback_fee;
    uint256[] private recollat_fee;
    uint256 public bonus_rate;
    
    uint256 private constant PRICE_PRECISION = 1e6;
    bool[] private mintPaused;
    bool[] private redeemPaused;
    bool[] private recollateralizePaused;
    bool[] private buyBackPaused;
    bool[] private borrowingPaused;
    
    modifier onlyByOwnGov() {
        require(msg.sender == timelock_address || msg.sender == owner, "Not owner or timelock");
        _;
    }
    modifier onlyByOwnGovCust() {
        require(msg.sender == timelock_address || msg.sender == owner || msg.sender == custodian_address, "Not owner, tlck, or custd");
        _;
    }
    modifier onlyAMOMinters() {
        require(amo_minter_addresses[msg.sender], "Not an AMO Minter");
        _;
    }
    modifier collateralEnabled(uint256 col_idx) {
        require(enabled_collaterals[collateral_addresses[col_idx]], "Collateral disabled");
        _;
    }
 
    
    
    constructor (
        address _pool_manager_address,
        address _custodian_address,
        address _timelock_address,
        address[] memory _collateral_addresses,
        uint256[] memory _pool_ceilings,
        uint256[] memory _initial_fees
    ) Owned(_pool_manager_address){
        timelock_address = _timelock_address;
        custodian_address = _custodian_address;
        collateral_addresses = _collateral_addresses;
        for (uint256 i = 0; i < _collateral_addresses.length; i++){ 
            collateralAddrToIdx[_collateral_addresses[i]] = i;
            enabled_collaterals[_collateral_addresses[i]] = false;
            missing_decimals.push(uint256(18).sub(ERC20(_collateral_addresses[i]).decimals()));
            collateral_symbols.push(ERC20(_collateral_addresses[i]).symbol());
            unclaimedPoolCollateral.push(0);
            collateral_prices.push(PRICE_PRECISION);
            minting_fee.push(_initial_fees[0]);
            redemption_fee.push(_initial_fees[1]);
            buyback_fee.push(_initial_fees[2]);
            recollat_fee.push(_initial_fees[3]);
            mintPaused.push(false);
            redeemPaused.push(false);
            recollateralizePaused.push(false);
            buyBackPaused.push(false);
            borrowingPaused.push(false);
        }
        pool_ceilings = _pool_ceilings;
        chainlink_frax_usd_decimals = priceFeedFRAXUSD.decimals();
        chainlink_fxs_usd_decimals = priceFeedFXSUSD.decimals();
    }
    
    
    struct CollateralInformation {
        uint256 index;
        string symbol;
        address col_addr;
        bool is_enabled;
        uint256 missing_decs;
        uint256 price;
        uint256 pool_ceiling;
        bool mint_paused;
        bool redeem_paused;
        bool recollat_paused;
        bool buyback_paused;
        bool borrowing_paused;
        uint256 minting_fee;
        uint256 redemption_fee;
        uint256 buyback_fee;
        uint256 recollat_fee;
    }
    
    function collateral_information(address collat_address) external view returns (CollateralInformation memory return_data){
        require(enabled_collaterals[collat_address], "Invalid collateral");
        uint256 idx = collateralAddrToIdx[collat_address];
        
        return_data = CollateralInformation(
            idx,
            collateral_symbols[idx],
            collat_address,
            enabled_collaterals[collat_address],
            missing_decimals[idx],
            collateral_prices[idx],
            pool_ceilings[idx],
            mintPaused[idx],
            redeemPaused[idx],
            recollateralizePaused[idx],
            buyBackPaused[idx],
            borrowingPaused[idx],
            minting_fee[idx],
            redemption_fee[idx],
            buyback_fee[idx],
            recollat_fee[idx]
        );
    }
    function allCollaterals() external view returns (address[] memory) {
        return collateral_addresses;
    }
    function getFRAXPrice() public view returns (uint256) {
        (uint80 roundID, int price, , uint256 updatedAt, uint80 answeredInRound) = priceFeedFRAXUSD.latestRoundData();
        require(price >= 0 && updatedAt!= 0 && answeredInRound >= roundID, "Invalid chainlink price");
        return uint256(price).mul(PRICE_PRECISION).div(10 ** chainlink_frax_usd_decimals);
    }
    function getFXSPrice() public view returns (uint256) {
        (uint80 roundID, int price, , uint256 updatedAt, uint80 answeredInRound) = priceFeedFXSUSD.latestRoundData();
        require(price >= 0 && updatedAt!= 0 && answeredInRound >= roundID, "Invalid chainlink price");
        return uint256(price).mul(PRICE_PRECISION).div(10 ** chainlink_fxs_usd_decimals);
    }
    function getFRAXInCollateral(uint256 col_idx, uint256 frax_amount) public view returns (uint256) {
        return frax_amount.mul(PRICE_PRECISION).div(10 ** missing_decimals[col_idx]).div(collateral_prices[col_idx]);
    }
    function freeCollatBalance(uint256 col_idx) public view returns (uint256) {
        return ERC20(collateral_addresses[col_idx]).balanceOf(address(this)).sub(unclaimedPoolCollateral[col_idx]);
    }
    function collatDollarBalance() external view returns (uint256 balance_tally) {
        balance_tally = 0;
        for (uint256 i = 0; i < collateral_addresses.length; i++){ 
            balance_tally += freeCollatBalance(i).mul(10 ** missing_decimals[i]).mul(collateral_prices[i]).div(PRICE_PRECISION);
        }
    }
    function comboCalcBbkRct(uint256 cur, uint256 max, uint256 theo) internal pure returns (uint256) {
        if (cur >= max) {
            return 0;
        }
        else {
            uint256 available = max.sub(cur);
            if (theo >= available) {
                return available;
            }
            else {
                return theo;
            }
        } 
    }
    function buybackAvailableCollat() public view returns (uint256) {
        uint256 total_supply = FRAX.totalSupply();
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();
        uint256 global_collat_value = FRAX.globalCollateralValue();
        if (global_collateral_ratio > PRICE_PRECISION) global_collateral_ratio = PRICE_PRECISION;
        uint256 required_collat_dollar_value_d18 = (total_supply.mul(global_collateral_ratio)).div(PRICE_PRECISION);
        
        if (global_collat_value > required_collat_dollar_value_d18) {
            uint256 theoretical_bbk_amt = global_collat_value.sub(required_collat_dollar_value_d18);
            uint256 current_hr_bbk = bbkHourlyCum[curEpochHr()];
            return comboCalcBbkRct(current_hr_bbk, bbkMaxColE18OutPerHour, theoretical_bbk_amt);
        }
        else return 0;
    }
    function recollatTheoColAvailableE18() public view returns (uint256) {
        uint256 frax_total_supply = FRAX.totalSupply();
        uint256 effective_collateral_ratio = FRAX.globalCollateralValue().mul(PRICE_PRECISION).div(frax_total_supply);
        
        uint256 desired_collat_e24 = (FRAX.global_collateral_ratio()).mul(frax_total_supply);
        uint256 effective_collat_e24 = effective_collateral_ratio.mul(frax_total_supply);
        if (effective_collat_e24 >= desired_collat_e24) return 0;
        else {
            return (desired_collat_e24.sub(effective_collat_e24)).div(PRICE_PRECISION);
        }
    }
    function recollatAvailableFxs() public view returns (uint256) {
        uint256 fxs_price = getFXSPrice();
        uint256 recollat_theo_available_e18 = recollatTheoColAvailableE18();
        uint256 fxs_theo_out = recollat_theo_available_e18.mul(PRICE_PRECISION).div(fxs_price);
        uint256 current_hr_rct = rctHourlyCum[curEpochHr()];
        return comboCalcBbkRct(current_hr_rct, rctMaxFxsOutPerHour, fxs_theo_out);
    }
    function curEpochHr() public view returns (uint256) {
        return (block.timestamp / 3600);
    }
    
     function mintFrax(
        uint256 col_idx, 
        uint256 frax_amt,
        uint256 frax_out_min,
        uint256 max_collat_in,
        uint256 max_fxs_in,
        bool one_to_one_override
    ) external collateralEnabled(col_idx) returns (
        uint256 total_frax_mint, 
        uint256 collat_needed, 
        uint256 fxs_needed
    ) {
        require(mintPaused[col_idx] == false, "Minting is paused");
        require(getFRAXPrice() >= mint_price_threshold, "Frax price too low");
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();
        if (one_to_one_override || global_collateral_ratio >= PRICE_PRECISION) { 
            collat_needed = getFRAXInCollateral(col_idx, frax_amt);
            fxs_needed = 0;
        } else if (global_collateral_ratio == 0) { 
            collat_needed = 0;
            fxs_needed = frax_amt.mul(PRICE_PRECISION).div(getFXSPrice());
        } else { 
            uint256 frax_for_collat = frax_amt.mul(global_collateral_ratio).div(PRICE_PRECISION);
            uint256 frax_for_fxs = frax_amt.sub(frax_for_collat);
            collat_needed = getFRAXInCollateral(col_idx, frax_for_collat);
            fxs_needed = frax_for_fxs.mul(PRICE_PRECISION).div(getFXSPrice());
        }
        total_frax_mint = (frax_amt.mul(PRICE_PRECISION.sub(minting_fee[col_idx]))).div(PRICE_PRECISION);
        require((total_frax_mint >= frax_out_min), "FRAX slippage");
        require((collat_needed <= max_collat_in), "Collat slippage");
        require((fxs_needed <= max_fxs_in), "FXS slippage");
        require(freeCollatBalance(col_idx).add(collat_needed) <= pool_ceilings[col_idx], "Pool ceiling");
        FXS.pool_burn_from(msg.sender, fxs_needed);
        TransferHelper.safeTransferFrom(collateral_addresses[col_idx], msg.sender, address(this), collat_needed);
        FRAX.pool_mint(msg.sender, total_frax_mint);
    }
    function redeemFrax(
        uint256 col_idx, 
        uint256 frax_amount, 
        uint256 fxs_out_min, 
        uint256 col_out_min
    ) external collateralEnabled(col_idx) returns (
        uint256 collat_out, 
        uint256 fxs_out
    ) {
        require(redeemPaused[col_idx] == false, "Redeeming is paused");
        require(getFRAXPrice() <= redeem_price_threshold, "Frax price too high");
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();
        uint256 frax_after_fee = (frax_amount.mul(PRICE_PRECISION.sub(redemption_fee[col_idx]))).div(PRICE_PRECISION);
        if(global_collateral_ratio >= PRICE_PRECISION) { 
            collat_out = getFRAXInCollateral(col_idx, frax_after_fee);
            fxs_out = 0;
        } else if (global_collateral_ratio == 0) { 
            fxs_out = frax_after_fee
                            .mul(PRICE_PRECISION)
                            .div(getFXSPrice());
            collat_out = 0;
        } else { 
            collat_out = getFRAXInCollateral(col_idx, frax_after_fee)
                            .mul(global_collateral_ratio)
                            .div(PRICE_PRECISION);
            fxs_out = frax_after_fee
                            .mul(PRICE_PRECISION.sub(global_collateral_ratio))
                            .div(getFXSPrice());
        }
        require(collat_out <= (ERC20(collateral_addresses[col_idx])).balanceOf(address(this)).sub(unclaimedPoolCollateral[col_idx]), "Insufficient pool collateral");
        require(collat_out >= col_out_min, "Collateral slippage");
        require(fxs_out >= fxs_out_min, "FXS slippage");
        redeemCollateralBalances[msg.sender][col_idx] = redeemCollateralBalances[msg.sender][col_idx].add(collat_out);
        unclaimedPoolCollateral[col_idx] = unclaimedPoolCollateral[col_idx].add(collat_out);
        redeemFXSBalances[msg.sender] = redeemFXSBalances[msg.sender].add(fxs_out);
        unclaimedPoolFXS = unclaimedPoolFXS.add(fxs_out);
        lastRedeemed[msg.sender] = block.number;
        FRAX.pool_burn_from(msg.sender, frax_amount);
        FXS.pool_mint(address(this), fxs_out);
    }
    function collectRedemption(uint256 col_idx) external returns (uint256 fxs_amount, uint256 collateral_amount) {
        require(redeemPaused[col_idx] == false, "Redeeming is paused");
        require((lastRedeemed[msg.sender].add(redemption_delay)) <= block.number, "Too soon");
        bool sendFXS = false;
        bool sendCollateral = false;
        if(redeemFXSBalances[msg.sender] > 0){
            fxs_amount = redeemFXSBalances[msg.sender];
            redeemFXSBalances[msg.sender] = 0;
            unclaimedPoolFXS = unclaimedPoolFXS.sub(fxs_amount);
            sendFXS = true;
        }
        
        if(redeemCollateralBalances[msg.sender][col_idx] > 0){
            collateral_amount = redeemCollateralBalances[msg.sender][col_idx];
            redeemCollateralBalances[msg.sender][col_idx] = 0;
            unclaimedPoolCollateral[col_idx] = unclaimedPoolCollateral[col_idx].sub(collateral_amount);
            sendCollateral = true;
        }
        if(sendFXS){
            TransferHelper.safeTransfer(address(FXS), msg.sender, fxs_amount);
        }
        if(sendCollateral){
            TransferHelper.safeTransfer(collateral_addresses[col_idx], msg.sender, collateral_amount);
        }
    }
    function buyBackFxs(uint256 col_idx, uint256 fxs_amount, uint256 col_out_min) external collateralEnabled(col_idx) returns (uint256 col_out) {
        require(buyBackPaused[col_idx] == false, "Buyback is paused");
        uint256 fxs_price = getFXSPrice();
        uint256 available_excess_collat_dv = buybackAvailableCollat();
        require(available_excess_collat_dv > 0, "Insuf Collat Avail For BBK");
        uint256 fxs_dollar_value_d18 = fxs_amount.mul(fxs_price).div(PRICE_PRECISION);
        require(fxs_dollar_value_d18 <= available_excess_collat_dv, "Insuf Collat Avail For BBK");
        uint256 collateral_equivalent_d18 = fxs_dollar_value_d18.mul(PRICE_PRECISION).div(collateral_prices[col_idx]);
        col_out = collateral_equivalent_d18.div(10 ** missing_decimals[col_idx]);
        col_out = (col_out.mul(PRICE_PRECISION.sub(buyback_fee[col_idx]))).div(PRICE_PRECISION);
        require(col_out >= col_out_min, "Collateral slippage");
        FXS.pool_burn_from(msg.sender, fxs_amount);
        TransferHelper.safeTransfer(collateral_addresses[col_idx], msg.sender, col_out);
        bbkHourlyCum[curEpochHr()] += collateral_equivalent_d18;
    }
    function recollateralize(uint256 col_idx, uint256 collateral_amount, uint256 fxs_out_min) external collateralEnabled(col_idx) returns (uint256 fxs_out) {
        require(recollateralizePaused[col_idx] == false, "Recollat is paused");
        uint256 collateral_amount_d18 = collateral_amount * (10 ** missing_decimals[col_idx]);
        uint256 fxs_price = getFXSPrice();
        uint256 fxs_actually_available = recollatAvailableFxs();
        fxs_out = collateral_amount_d18.mul(PRICE_PRECISION.add(bonus_rate).sub(recollat_fee[col_idx])).div(fxs_price);
        require(fxs_out <= fxs_actually_available, "Insuf FXS Avail For RCT");
        require(fxs_out >= fxs_out_min, "FXS slippage");
        require(freeCollatBalance(col_idx).add(collateral_amount) <= pool_ceilings[col_idx], "Pool ceiling");
        TransferHelper.safeTransferFrom(collateral_addresses[col_idx], msg.sender, address(this), collateral_amount);
        FXS.pool_mint(msg.sender, fxs_out);
        rctHourlyCum[curEpochHr()] += fxs_out;
    }
    function amoMinterBorrow(uint256 collateral_amount) external onlyAMOMinters {
        uint256 minter_col_idx = IFraxAMOMinter(msg.sender).col_idx();
        require(borrowingPaused[minter_col_idx] == false, "Borrowing is paused");
        require(enabled_collaterals[collateral_addresses[minter_col_idx]], "Collateral disabled");
        TransferHelper.safeTransfer(collateral_addresses[minter_col_idx], msg.sender, collateral_amount);
    }
    
    function toggleMRBR(uint256 col_idx, uint8 tog_idx) external onlyByOwnGovCust {
        if (tog_idx == 0) mintPaused[col_idx] = !mintPaused[col_idx];
        else if (tog_idx == 1) redeemPaused[col_idx] = !redeemPaused[col_idx];
        else if (tog_idx == 2) buyBackPaused[col_idx] = !buyBackPaused[col_idx];
        else if (tog_idx == 3) recollateralizePaused[col_idx] = !recollateralizePaused[col_idx];
        else if (tog_idx == 4) borrowingPaused[col_idx] = !borrowingPaused[col_idx];
        emit MRBRToggled(col_idx, tog_idx);
    }
    
    function addAMOMinter(address amo_minter_addr) external onlyByOwnGov {
        require(amo_minter_addr != address(0), "Zero address detected");
        uint256 collat_val_e18 = IFraxAMOMinter(amo_minter_addr).collatDollarBalance();
        require(collat_val_e18 >= 0, "Invalid AMO");
        amo_minter_addresses[amo_minter_addr] = true;
        emit AMOMinterAdded(amo_minter_addr);
    }
    function removeAMOMinter(address amo_minter_addr) external onlyByOwnGov {
        amo_minter_addresses[amo_minter_addr] = false;
        
        emit AMOMinterRemoved(amo_minter_addr);
    }
    function setCollateralPrice(uint256 col_idx, uint256 _new_price) external onlyByOwnGov {
        collateral_prices[col_idx] = _new_price;
        emit CollateralPriceSet(col_idx, _new_price);
    }
    function toggleCollateral(uint256 col_idx) external onlyByOwnGov {
        address col_address = collateral_addresses[col_idx];
        enabled_collaterals[col_address] = !enabled_collaterals[col_address];
        emit CollateralToggled(col_idx, enabled_collaterals[col_address]);
    }
    function setPoolCeiling(uint256 col_idx, uint256 new_ceiling) external onlyByOwnGov {
        pool_ceilings[col_idx] = new_ceiling;
        emit PoolCeilingSet(col_idx, new_ceiling);
    }
    function setFees(uint256 col_idx, uint256 new_mint_fee, uint256 new_redeem_fee, uint256 new_buyback_fee, uint256 new_recollat_fee) external onlyByOwnGov {
        minting_fee[col_idx] = new_mint_fee;
        redemption_fee[col_idx] = new_redeem_fee;
        buyback_fee[col_idx] = new_buyback_fee;
        recollat_fee[col_idx] = new_recollat_fee;
        emit FeesSet(col_idx, new_mint_fee, new_redeem_fee, new_buyback_fee, new_recollat_fee);
    }
    function setPoolParameters(uint256 new_bonus_rate, uint256 new_redemption_delay) external onlyByOwnGov {
        bonus_rate = new_bonus_rate;
        redemption_delay = new_redemption_delay;
        emit PoolParametersSet(new_bonus_rate, new_redemption_delay);
    }
    function setPriceThresholds(uint256 new_mint_price_threshold, uint256 new_redeem_price_threshold) external onlyByOwnGov {
        mint_price_threshold = new_mint_price_threshold;
        redeem_price_threshold = new_redeem_price_threshold;
        emit PriceThresholdsSet(new_mint_price_threshold, new_redeem_price_threshold);
    }
    function setBbkRctPerHour(uint256 _bbkMaxColE18OutPerHour, uint256 _rctMaxFxsOutPerHour) external onlyByOwnGov {
        bbkMaxColE18OutPerHour = _bbkMaxColE18OutPerHour;
        rctMaxFxsOutPerHour = _rctMaxFxsOutPerHour;
        emit BbkRctPerHourSet(_bbkMaxColE18OutPerHour, _rctMaxFxsOutPerHour);
    }
    function setOracles(address _frax_usd_chainlink_addr, address _fxs_usd_chainlink_addr) external onlyByOwnGov {
        priceFeedFRAXUSD = AggregatorV3Interface(_frax_usd_chainlink_addr);
        priceFeedFXSUSD = AggregatorV3Interface(_fxs_usd_chainlink_addr);
        chainlink_frax_usd_decimals = priceFeedFRAXUSD.decimals();
        chainlink_fxs_usd_decimals = priceFeedFXSUSD.decimals();
        
        emit OraclesSet(_frax_usd_chainlink_addr, _fxs_usd_chainlink_addr);
    }
    function setCustodian(address new_custodian) external onlyByOwnGov {
        custodian_address = new_custodian;
        emit CustodianSet(new_custodian);
    }
    function setTimelock(address new_timelock) external onlyByOwnGov {
        timelock_address = new_timelock;
        emit TimelockSet(new_timelock);
    }
    
    event CollateralToggled(uint256 col_idx, bool new_state);
    event PoolCeilingSet(uint256 col_idx, uint256 new_ceiling);
    event FeesSet(uint256 col_idx, uint256 new_mint_fee, uint256 new_redeem_fee, uint256 new_buyback_fee, uint256 new_recollat_fee);
    event PoolParametersSet(uint256 new_bonus_rate, uint256 new_redemption_delay);
    event PriceThresholdsSet(uint256 new_bonus_rate, uint256 new_redemption_delay);
    event BbkRctPerHourSet(uint256 bbkMaxColE18OutPerHour, uint256 rctMaxFxsOutPerHour);
    event AMOMinterAdded(address amo_minter_addr);
    event AMOMinterRemoved(address amo_minter_addr);
    event OraclesSet(address frax_usd_chainlink_addr, address fxs_usd_chainlink_addr);
    event CustodianSet(address new_custodian);
    event TimelockSet(address new_timelock);
    event MRBRToggled(uint256 col_idx, uint8 tog_idx);
    event CollateralPriceSet(uint256 col_idx, uint256 new_price);
}
interface IFraxPool {
    function minting_fee() external returns (uint256);
    function redeemCollateralBalances(address addr) external returns (uint256);
    function redemption_fee() external returns (uint256);
    function buyback_fee() external returns (uint256);
    function recollat_fee() external returns (uint256);
    function collatDollarBalance() external returns (uint256);
    function availableExcessCollatDV() external returns (uint256);
    function getCollateralPrice() external returns (uint256);
    function setCollatETHOracle(address _collateral_weth_oracle_address, address _weth_address) external;
    function mint1t1FRAX(uint256 collateral_amount, uint256 FRAX_out_min) external;
    function mintAlgorithmicFRAX(uint256 fxs_amount_d18, uint256 FRAX_out_min) external;
    function mintFractionalFRAX(uint256 collateral_amount, uint256 fxs_amount, uint256 FRAX_out_min) external;
    function redeem1t1FRAX(uint256 FRAX_amount, uint256 COLLATERAL_out_min) external;
    function redeemFractionalFRAX(uint256 FRAX_amount, uint256 FXS_out_min, uint256 COLLATERAL_out_min) external;
    function redeemAlgorithmicFRAX(uint256 FRAX_amount, uint256 FXS_out_min) external;
    function collectRedemption() external;
    function recollateralizeFRAX(uint256 collateral_amount, uint256 FXS_out_min) external;
    function buyBackFXS(uint256 FXS_amount, uint256 COLLATERAL_out_min) external;
    function toggleMinting() external;
    function toggleRedeeming() external;
    function toggleRecollateralize() external;
    function toggleBuyBack() external;
    function toggleCollateralPrice(uint256 _new_price) external;
    function setPoolParameters(uint256 new_ceiling, uint256 new_bonus_rate, uint256 new_redemption_delay, uint256 new_mint_fee, uint256 new_redeem_fee, uint256 new_buyback_fee, uint256 new_recollat_fee) external;
    function setTimelock(address new_timelock) external;
    function setOwner(address _owner_address) external;
}
pragma experimental ABIEncoderV2;
interface IAMO {
    function dollarBalances() external view returns (uint256 frax_val_e18, uint256 collat_val_e18);
}
contract FraxAMOMinter is Owned {
    
    IFrax public FRAX = IFrax(0x853d955aCEf822Db058eb8505911ED77F175b99e);
    IFxs public FXS = IFxs(0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0);
    ERC20 public collateral_token;
    FraxPoolV3 public pool = FraxPoolV3(0x2fE065e6FFEf9ac95ab39E5042744d695F560729);
    IFraxPool public old_pool = IFraxPool(0x1864Ca3d47AaB98Ee78D11fc9DCC5E7bADdA1c0d);
    address public timelock_address;
    address public custodian_address;
    address public collateral_address;
    uint256 public col_idx;
    address[] public amos_array;
    mapping(address => bool) public amos;
    uint256 private constant PRICE_PRECISION = 1e6;
    int256 public collat_borrow_cap = int256(10000000e6);
    int256 public frax_mint_cap = int256(100000000e18);
    int256 public fxs_mint_cap = int256(100000000e18);
    uint256 public min_cr = 810000;
    mapping(address => int256) public frax_mint_balances;
    int256 public frax_mint_sum = 0;
    mapping(address => int256) public fxs_mint_balances;
    int256 public fxs_mint_sum = 0;
    mapping(address => int256) public collat_borrowed_balances;
    int256 public collat_borrowed_sum = 0;
    uint256 public fraxDollarBalanceStored = 0;
    uint256 public missing_decimals;
    uint256 public collatDollarBalanceStored = 0;
    mapping(address => int256[2]) public correction_offsets_amos;
    
    
    constructor (
        address _owner_address,
        address _custodian_address,
        address _timelock_address,
        address _collateral_address,
        address _pool_address
    ) Owned(_owner_address) {
        custodian_address = _custodian_address;
        timelock_address = _timelock_address;
        pool = FraxPoolV3(_pool_address);
        collateral_address = _collateral_address;
        col_idx = pool.collateralAddrToIdx(_collateral_address);
        collateral_token = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
        missing_decimals = uint(18) - collateral_token.decimals();
    }
    
    modifier onlyByOwnGov() {
        require(msg.sender == timelock_address || msg.sender == owner, "Not owner or timelock");
        _;
    }
    modifier validAMO(address amo_address) {
        require(amos[amo_address], "Invalid AMO");
        _;
    }
    
    function collatDollarBalance() external view returns (uint256) {
        (, uint256 collat_val_e18) = dollarBalances();
        return collat_val_e18;
    }
    function dollarBalances() public view returns (uint256 frax_val_e18, uint256 collat_val_e18) {
        frax_val_e18 = fraxDollarBalanceStored;
        collat_val_e18 = collatDollarBalanceStored;
    }
    function allAMOAddresses() external view returns (address[] memory) {
        return amos_array;
    }
    function allAMOsLength() external view returns (uint256) {
        return amos_array.length;
    }
    function fraxTrackedGlobal() external view returns (int256) {
        return int256(fraxDollarBalanceStored) - frax_mint_sum - (collat_borrowed_sum * int256(10 ** missing_decimals));
    }
    function fraxTrackedAMO(address amo_address) external view returns (int256) {
        (uint256 frax_val_e18, ) = IAMO(amo_address).dollarBalances();
        int256 frax_val_e18_corrected = int256(frax_val_e18) + correction_offsets_amos[amo_address][0];
        return frax_val_e18_corrected - frax_mint_balances[amo_address] - ((collat_borrowed_balances[amo_address]) * int256(10 ** missing_decimals));
    }
    
    function syncDollarBalances() public {
        uint256 total_frax_value_d18 = 0;
        uint256 total_collateral_value_d18 = 0; 
        for (uint i = 0; i < amos_array.length; i++){ 
            address amo_address = amos_array[i];
            if (amo_address != address(0)){
                (uint256 frax_val_e18, uint256 collat_val_e18) = IAMO(amo_address).dollarBalances();
                total_frax_value_d18 += uint256(int256(frax_val_e18) + correction_offsets_amos[amo_address][0]);
                total_collateral_value_d18 += uint256(int256(collat_val_e18) + correction_offsets_amos[amo_address][1]);
            }
        }
        fraxDollarBalanceStored = total_frax_value_d18;
        collatDollarBalanceStored = total_collateral_value_d18;
    }
    
    function oldPoolRedeem(uint256 frax_amount) external onlyByOwnGov {
        uint256 redemption_fee = old_pool.redemption_fee();
        uint256 col_price_usd = old_pool.getCollateralPrice();
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();
        uint256 redeem_amount_E6 = ((frax_amount * (uint256(1e6) - redemption_fee)) / 1e6) / (10 ** missing_decimals);
        uint256 expected_collat_amount = (redeem_amount_E6 * global_collateral_ratio) / 1e6;
        expected_collat_amount = (expected_collat_amount * 1e6) / col_price_usd;
        require((collat_borrowed_sum + int256(expected_collat_amount)) <= collat_borrow_cap, "Borrow cap");
        collat_borrowed_sum += int256(expected_collat_amount);
        FRAX.pool_mint(address(this), frax_amount);
        FRAX.approve(address(old_pool), frax_amount);
        old_pool.redeemFractionalFRAX(frax_amount, 0, 0);
    }
    function oldPoolCollectAndGive(address destination_amo) external onlyByOwnGov validAMO(destination_amo) {
        uint256 collat_amount = old_pool.redeemCollateralBalances(address(this));
        
        old_pool.collectRedemption();
        collat_borrowed_balances[destination_amo] += int256(collat_amount);
        TransferHelper.safeTransfer(collateral_address, destination_amo, collat_amount);
        syncDollarBalances();
    }
    
    function mintFraxForAMO(address destination_amo, uint256 frax_amount) external onlyByOwnGov validAMO(destination_amo) {
        int256 frax_amt_i256 = int256(frax_amount);
        require((frax_mint_sum + frax_amt_i256) <= frax_mint_cap, "Mint cap reached");
        frax_mint_balances[destination_amo] += frax_amt_i256;
        frax_mint_sum += frax_amt_i256;
        uint256 current_collateral_E18 = FRAX.globalCollateralValue();
        uint256 cur_frax_supply = FRAX.totalSupply();
        uint256 new_frax_supply = cur_frax_supply + frax_amount;
        uint256 new_cr = (current_collateral_E18 * PRICE_PRECISION) / new_frax_supply;
        require(new_cr >= min_cr, "CR would be too low");
        FRAX.pool_mint(destination_amo, frax_amount);
        syncDollarBalances();
    }
    function burnFraxFromAMO(uint256 frax_amount) external validAMO(msg.sender) {
        int256 frax_amt_i256 = int256(frax_amount);
        FRAX.pool_burn_from(msg.sender, frax_amount);
        frax_mint_balances[msg.sender] -= frax_amt_i256;
        frax_mint_sum -= frax_amt_i256;
        syncDollarBalances();
    }
    function mintFxsForAMO(address destination_amo, uint256 fxs_amount) external onlyByOwnGov validAMO(destination_amo) {
        int256 fxs_amt_i256 = int256(fxs_amount);
        require((fxs_mint_sum + fxs_amt_i256) <= fxs_mint_cap, "Mint cap reached");
        fxs_mint_balances[destination_amo] += fxs_amt_i256;
        fxs_mint_sum += fxs_amt_i256;
        FXS.pool_mint(destination_amo, fxs_amount);
        syncDollarBalances();
    }
    function burnFxsFromAMO(uint256 fxs_amount) external validAMO(msg.sender) {
        int256 fxs_amt_i256 = int256(fxs_amount);
        FXS.pool_burn_from(msg.sender, fxs_amount);
        fxs_mint_balances[msg.sender] -= fxs_amt_i256;
        fxs_mint_sum -= fxs_amt_i256;
        syncDollarBalances();
    }
    function giveCollatToAMO(
        address destination_amo,
        uint256 collat_amount
    ) external onlyByOwnGov validAMO(destination_amo) {
        int256 collat_amount_i256 = int256(collat_amount);
        require((collat_borrowed_sum + collat_amount_i256) <= collat_borrow_cap, "Borrow cap");
        collat_borrowed_balances[destination_amo] += collat_amount_i256;
        collat_borrowed_sum += collat_amount_i256;
        pool.amoMinterBorrow(collat_amount);
        TransferHelper.safeTransfer(collateral_address, destination_amo, collat_amount);
        syncDollarBalances();
    }
    function receiveCollatFromAMO(uint256 usdc_amount) external validAMO(msg.sender) {
        int256 collat_amt_i256 = int256(usdc_amount);
        TransferHelper.safeTransferFrom(collateral_address, msg.sender, address(pool), usdc_amount);
        collat_borrowed_balances[msg.sender] -= collat_amt_i256;
        collat_borrowed_sum -= collat_amt_i256;
        syncDollarBalances();
    }
    
    function addAMO(address amo_address, bool sync_too) public onlyByOwnGov {
        require(amo_address != address(0), "Zero address detected");
        (uint256 frax_val_e18, uint256 collat_val_e18) = IAMO(amo_address).dollarBalances();
        require(frax_val_e18 >= 0 && collat_val_e18 >= 0, "Invalid AMO");
        require(amos[amo_address] == false, "Address already exists");
        amos[amo_address] = true; 
        amos_array.push(amo_address);
        frax_mint_balances[amo_address] = 0;
        fxs_mint_balances[amo_address] = 0;
        collat_borrowed_balances[amo_address] = 0;
        correction_offsets_amos[amo_address][0] = 0;
        correction_offsets_amos[amo_address][1] = 0;
        if (sync_too) syncDollarBalances();
        emit AMOAdded(amo_address);
    }
    function removeAMO(address amo_address, bool sync_too) public onlyByOwnGov {
        require(amo_address != address(0), "Zero address detected");
        require(amos[amo_address] == true, "Address nonexistant");
        
        delete amos[amo_address];
        for (uint i = 0; i < amos_array.length; i++){ 
            if (amos_array[i] == amo_address) {
                amos_array[i] = address(0);
                break;
            }
        }
        if (sync_too) syncDollarBalances();
        emit AMORemoved(amo_address);
    }
    function setTimelock(address new_timelock) external onlyByOwnGov {
        require(new_timelock != address(0), "Timelock address cannot be 0");
        timelock_address = new_timelock;
    }
    function setCustodian(address _custodian_address) external onlyByOwnGov {
        require(_custodian_address != address(0), "Custodian address cannot be 0");        
        custodian_address = _custodian_address;
    }
    function setFraxMintCap(uint256 _frax_mint_cap) external onlyByOwnGov {
        frax_mint_cap = int256(_frax_mint_cap);
    }
    function setFxsMintCap(uint256 _fxs_mint_cap) external onlyByOwnGov {
        fxs_mint_cap = int256(_fxs_mint_cap);
    }
    function setCollatBorrowCap(uint256 _collat_borrow_cap) external onlyByOwnGov {
        collat_borrow_cap = int256(_collat_borrow_cap);
    }
    function setMinimumCollateralRatio(uint256 _min_cr) external onlyByOwnGov {
        min_cr = _min_cr;
    }
    function setAMOCorrectionOffsets(address amo_address, int256 frax_e18_correction, int256 collat_e18_correction) external onlyByOwnGov {
        correction_offsets_amos[amo_address][0] = frax_e18_correction;
        correction_offsets_amos[amo_address][1] = collat_e18_correction;
        syncDollarBalances();
    }
    function setFraxPool(address _pool_address) external onlyByOwnGov {
        pool = FraxPoolV3(_pool_address);
        require(pool.collateralAddrToIdx(collateral_address) == col_idx, "col_idx mismatch");
    }
    function recoverERC20(address tokenAddress, uint256 tokenAmount) external onlyByOwnGov {
        TransferHelper.safeTransfer(tokenAddress, owner, tokenAmount);
        
        emit Recovered(tokenAddress, tokenAmount);
    }
    function execute(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external onlyByOwnGov returns (bool, bytes memory) {
        (bool success, bytes memory result) = _to.call{value:_value}(_data);
        return (success, result);
    }
    
    event AMOAdded(address amo_address);
    event AMORemoved(address amo_address);
    event Recovered(address token, uint256 amount);
}

library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }
    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }
    
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }
    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }
    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }
    
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}
interface ICrossChainOracle {
    function getPrice(address token_address) external view returns (uint256 token_price);
}
interface ICrossChainAMO {
    function allDollarBalances() external view returns (uint256 frax_val_e18, uint256 fxs_val_e18, uint256 collat_val_e18, uint256 total_val_e18);
}
contract CrossChainBridgeBacker is Owned {
    using SafeERC20 for ERC20;
    
    IAnyswapV4ERC20 public anyFRAX;
    CrossChainCanonical public canFRAX;
    IAnyswapV4ERC20 public anyFXS;
    CrossChainCanonical public canFXS;
    ERC20 public collateral_token;
    ICrossChainOracle public cross_chain_oracle;
    address public timelock_address;
    address[] public amos_array;
    mapping(address => bool) public eoa_amos;
    mapping(address => bool) public amos;
    
    string public name;
    uint256 private constant PRICE_PRECISION = 1e6;
    address[3] public bridge_addresses;
    address public destination_address_override;
    string public non_evm_destination_address;
    mapping(address => uint256) public frax_lent_balances;
    uint256 public frax_lent_sum = 0;
    uint256 public frax_bridged_back_sum = 0;
    mapping(address => uint256) public fxs_lent_balances;
    uint256 public fxs_lent_sum = 0;
    uint256 public fxs_bridged_back_sum = 0;
    mapping(address => uint256) public collat_lent_balances;
    uint256 public collat_lent_sum = 0;
    uint256 public collat_bridged_back_sum = 0;
    uint256 public missing_decimals;
    
    modifier onlyByOwnGov() {
        require(msg.sender == owner || msg.sender == timelock_address, "Not owner or timelock");
        _;
    }
    modifier validAMO(address amo_address) {
        require(amos[amo_address], "Invalid AMO");
        _;
    }
    modifier validCanonicalToken(address token_address) {
        require (
                token_address == address(canFRAX) || 
                token_address == address(canFXS) ||
                token_address == address(collateral_token), "Invalid canonical token"
            );
        _;
    }
    
    constructor (
        address _owner,
        address _timelock_address,
        address _cross_chain_oracle_address,
        address[5] memory _token_addresses,
        address[3] memory _bridge_addresses,
        address _destination_address_override,
        string memory _non_evm_destination_address,
        string memory _name
    ) Owned(_owner) {
        timelock_address = _timelock_address;
        cross_chain_oracle = ICrossChainOracle(_cross_chain_oracle_address);
        anyFRAX = IAnyswapV4ERC20(_token_addresses[0]);
        canFRAX = CrossChainCanonical(_token_addresses[1]);
        anyFXS = IAnyswapV4ERC20(_token_addresses[2]);
        canFXS = CrossChainCanonical(_token_addresses[3]);
        collateral_token = ERC20(_token_addresses[4]);
        missing_decimals = uint(18) - collateral_token.decimals();
        bridge_addresses = _bridge_addresses;
        destination_address_override = _destination_address_override;
        non_evm_destination_address = _non_evm_destination_address;
        name = _name;
        amos[address(this)] = true; 
        amos_array.push(address(this));
        frax_lent_balances[address(this)] = 0;
        fxs_lent_balances[address(this)] = 0;
        collat_lent_balances[address(this)] = 0;
    }
    
    function allAMOAddresses() external view returns (address[] memory) {
        return amos_array;
    }
    function allAMOsLength() external view returns (uint256) {
        return amos_array.length;
    }
    function getTokenType(address token_address) public view returns (uint256) {
        if (token_address == address(anyFRAX) || token_address == address(canFRAX)) return 0;
        else if (token_address == address(anyFXS) || token_address == address(canFXS)) return 1;
        else if (token_address == address(collateral_token)) return 2;
        revert("getTokenType: Invalid token");
    }
    function showTokenBalances() public view returns (uint256[5] memory tkn_bals) {
        tkn_bals[0] = anyFRAX.balanceOf(address(this));
        tkn_bals[1] = canFRAX.balanceOf(address(this));
        tkn_bals[2] = anyFXS.balanceOf(address(this));
        tkn_bals[3] = canFXS.balanceOf(address(this));
        tkn_bals[4] = collateral_token.balanceOf(address(this));
    }
    function showAllocations() public view returns (uint256[12] memory allocations) {
        uint256[5] memory tkn_bals = showTokenBalances();
        allocations[0] = tkn_bals[0] + tkn_bals[1];
        allocations[1] = frax_lent_sum;
        allocations[2] = allocations[0] + allocations[1];
        allocations[3] = tkn_bals[2] + tkn_bals[3];
        allocations[4] = fxs_lent_sum;
        allocations[5] = allocations[3] + allocations[4];
        allocations[6] = (allocations[5] * (cross_chain_oracle.getPrice(address(canFXS)))) / PRICE_PRECISION;
        allocations[7] = tkn_bals[4];
        allocations[8] = collat_lent_sum;
        allocations[9] = allocations[7] + allocations[8];
        allocations[10] = allocations[9] * (10 ** missing_decimals);
    
        allocations[11] = allocations[2] + allocations[6] + allocations[10];
    }
    function allBalances() public view returns (
        uint256 frax_ttl, 
        uint256 fxs_ttl,
        uint256 col_ttl,
        uint256 ttl_val_usd_e18
    ) {
        uint256[12] memory allocations = showAllocations();
        frax_ttl = allocations[2];
        fxs_ttl = allocations[5];
        col_ttl = allocations[9];
        ttl_val_usd_e18 = allocations[11];
        for (uint i = 1; i < amos_array.length; i++){ 
            if (amos_array[i] != address(0) && !eoa_amos[amos_array[i]]){
                (
                    uint256 frax_bal, 
                    uint256 fxs_bal, 
                    uint256 collat_bal,
                    uint256 total_val_e18
                ) = ICrossChainAMO(amos_array[i]).allDollarBalances();
                frax_ttl += frax_bal;
                fxs_ttl += fxs_bal;
                col_ttl += collat_bal;
                ttl_val_usd_e18 += total_val_e18;
            }
        }
    }
    
    function selfBridge(uint256 token_type, uint256 token_amount, bool do_swap) external onlyByOwnGov {
        require(token_type == 0 || token_type == 1 || token_type == 2, 'Invalid token type');
        _receiveBack(address(this), token_type, token_amount, true, do_swap);
    }
    function receiveBackViaAMO(address canonical_token_address, uint256 token_amount, bool do_bridging) external validCanonicalToken(canonical_token_address) validAMO(msg.sender) {
        TransferHelper.safeTransferFrom(canonical_token_address, msg.sender, address(this), token_amount);
        uint256 token_type = getTokenType(canonical_token_address); 
        _receiveBack(msg.sender, token_type, token_amount, do_bridging, true);
    }
    function _receiveBack(address from_address, uint256 token_type, uint256 token_amount, bool do_bridging, bool do_swap) internal {
        if (do_bridging) {
            if (token_type == 0) {
                if (do_swap) _swapCanonicalForAny(0, token_amount);
            }
            else if (token_type == 1){
                if (do_swap) _swapCanonicalForAny(1, token_amount);
            }
            address address_to_send_to = address(this);
            if (destination_address_override != address(0)) address_to_send_to = destination_address_override;
            _bridgingLogic(token_type, address_to_send_to, token_amount);
        }
        if (token_type == 0){
            if (token_amount >= frax_lent_balances[from_address]) frax_lent_balances[from_address] = 0;
            else frax_lent_balances[from_address] -= token_amount;
            if (token_amount >= frax_lent_sum) frax_lent_sum = 0;
            else frax_lent_sum -= token_amount;
            if (do_bridging) frax_bridged_back_sum += token_amount;
        }
        else if (token_type == 1){
            if (token_amount >= fxs_lent_balances[from_address]) fxs_lent_balances[from_address] = 0;
            else fxs_lent_balances[from_address] -= token_amount;
            if (token_amount >= fxs_lent_sum) fxs_lent_sum = 0;
            else fxs_lent_sum -= token_amount;
            if (do_bridging) fxs_bridged_back_sum += token_amount;
        }
        else {
            if (token_amount >= collat_lent_balances[from_address]) collat_lent_balances[from_address] = 0;
            else collat_lent_balances[from_address] -= token_amount;
            if (token_amount >= collat_lent_sum) collat_lent_sum = 0;
            else collat_lent_sum -= token_amount;
            if (do_bridging) collat_bridged_back_sum += token_amount;
        }
    }
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal virtual {
        revert("Need bridging logic");
    }
    
    function lendFraxToAMO(address destination_amo, uint256 frax_amount) external onlyByOwnGov validAMO(destination_amo) {
        frax_lent_balances[destination_amo] += frax_amount;
        frax_lent_sum += frax_amount;
        TransferHelper.safeTransfer(address(canFRAX), destination_amo, frax_amount);
    }
    function lendFxsToAMO(address destination_amo, uint256 fxs_amount) external onlyByOwnGov validAMO(destination_amo) {
        fxs_lent_balances[destination_amo] += fxs_amount;
        fxs_lent_sum += fxs_amount;
        TransferHelper.safeTransfer(address(canFXS), destination_amo, fxs_amount);
    }
    function lendCollatToAMO(address destination_amo, uint256 collat_amount) external onlyByOwnGov validAMO(destination_amo) {
        collat_lent_balances[destination_amo] += collat_amount;
        collat_lent_sum += collat_amount;
        TransferHelper.safeTransfer(address(collateral_token), destination_amo, collat_amount);
    }
    
    
    function swapAnyForCanonical(uint256 token_type, uint256 token_amount) external onlyByOwnGov {
        _swapAnyForCanonical(token_type, token_amount);
    }
    function _swapAnyForCanonical(uint256 token_type, uint256 token_amount) internal {
        if (token_type == 0) {
            anyFRAX.approve(address(canFRAX), token_amount);
            canFRAX.exchangeOldForCanonical(address(anyFRAX), token_amount);
        }
        else {
            anyFXS.approve(address(canFXS), token_amount);
            canFXS.exchangeOldForCanonical(address(anyFXS), token_amount);
        }
    }
    function swapCanonicalForAny(uint256 token_type, uint256 token_amount) external onlyByOwnGov {
        _swapCanonicalForAny(token_type, token_amount);
    }
    function _swapCanonicalForAny(uint256 token_type, uint256 token_amount) internal {
        if (token_type == 0) {
            canFRAX.approve(address(canFRAX), token_amount);
            canFRAX.exchangeCanonicalForOld(address(anyFRAX), token_amount);
        }
        else {
            canFXS.approve(address(canFXS), token_amount);
            canFXS.exchangeCanonicalForOld(address(anyFXS), token_amount);
        }
    }
    function giveAnyToCan(uint256 token_type, uint256 token_amount) external onlyByOwnGov {
        if (token_type == 0) {
            TransferHelper.safeTransfer(address(anyFRAX), address(canFRAX), token_amount);
        }
        else {
            TransferHelper.safeTransfer(address(anyFXS), address(canFXS), token_amount);
        }
    }
    function mintCanonicalFrax(uint256 frax_amount) external onlyByOwnGov {
        canFRAX.minter_mint(address(this), frax_amount);
    }
    function burnCanonicalFrax(uint256 frax_amount) external onlyByOwnGov {
        canFRAX.minter_burn(frax_amount);
    }
    function mintCanonicalFxs(uint256 fxs_amount) external onlyByOwnGov {
        canFXS.minter_mint(address(this), fxs_amount);
    }
    function burnCanonicalFxs(uint256 fxs_amount) external onlyByOwnGov {
        canFXS.minter_burn(fxs_amount);
    }
    
    function collectBridgeTokens(uint256 token_type, address bridge_token_address, uint256 token_amount) external onlyByOwnGov {
        if (token_type == 0) {
            canFRAX.withdrawBridgeTokens(bridge_token_address, token_amount);
        }
        else if (token_type == 1) {
            canFXS.withdrawBridgeTokens(bridge_token_address, token_amount);
        }
        else {
            revert("Invalid token_type");
        }
    }
    
    function addAMO(address amo_address, bool is_eoa) external onlyByOwnGov {
        require(amo_address != address(0), "Zero address detected");
        if (is_eoa) {
            eoa_amos[amo_address] = true;
        }
        else {
            (uint256 frax_val_e18, uint256 fxs_val_e18, uint256 collat_val_e18, uint256 total_val_e18) = ICrossChainAMO(amo_address).allDollarBalances();
            require(frax_val_e18 >= 0 && fxs_val_e18 >= 0 && collat_val_e18 >= 0 && total_val_e18 >= 0, "Invalid AMO");
        }
        require(amos[amo_address] == false, "Address already exists");
        amos[amo_address] = true; 
        amos_array.push(amo_address);
        frax_lent_balances[amo_address] = 0;
        fxs_lent_balances[amo_address] = 0;
        collat_lent_balances[amo_address] = 0;
        emit AMOAdded(amo_address);
    }
    function removeAMO(address amo_address) external onlyByOwnGov {
        require(amo_address != address(0), "Zero address detected");
        require(amos[amo_address] == true, "Address nonexistant");
        
        delete amos[amo_address];
        for (uint i = 0; i < amos_array.length; i++){ 
            if (amos_array[i] == amo_address) {
                amos_array[i] = address(0);
                break;
            }
        }
        emit AMORemoved(amo_address);
    }
    
    function recoverERC20(address tokenAddress, uint256 tokenAmount) external onlyByOwnGov {
        TransferHelper.safeTransfer(tokenAddress, owner, tokenAmount);
        emit RecoveredERC20(tokenAddress, tokenAmount);
    }
    function setOracleAddress(address _new_cc_oracle_address) external onlyByOwnGov {
        cross_chain_oracle = ICrossChainOracle(_new_cc_oracle_address);
    }
    function setTimelock(address _new_timelock) external onlyByOwnGov {
        timelock_address = _new_timelock;
    }
    function setBridgeInfo(
        address _frax_bridge_address, 
        address _fxs_bridge_address, 
        address _collateral_bridge_address, 
        address _destination_address_override, 
        string memory _non_evm_destination_address
    ) external onlyByOwnGov {
        require(
            _frax_bridge_address != address(0) && 
            _fxs_bridge_address != address(0) &&
            _collateral_bridge_address != address(0)
        , "Invalid bridge address");
        bridge_addresses = [_frax_bridge_address, _fxs_bridge_address, _collateral_bridge_address];
        
        destination_address_override = _destination_address_override;
        non_evm_destination_address = _non_evm_destination_address;
        
        emit BridgeInfoChanged(_frax_bridge_address, _fxs_bridge_address, _collateral_bridge_address, _destination_address_override, _non_evm_destination_address);
    }
    function execute(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external onlyByOwnGov returns (bool, bytes memory) {
        (bool success, bytes memory result) = _to.call{value:_value}(_data);
        return (success, result);
    }
    
    event AMOAdded(address amo_address);
    event AMORemoved(address amo_address);
    event RecoveredERC20(address token, uint256 amount);
    event BridgeInfoChanged(address frax_bridge_address, address fxs_bridge_address, address collateral_bridge_address, address destination_address_override, string non_evm_destination_address);
}
interface IBridgeRouter {
  function PRE_FILL_FEE_DENOMINATOR() external view returns (uint256);
  function PRE_FILL_FEE_NUMERATOR() external view returns (uint256);
  function VERSION() external view returns (uint8);
  function enrollCustom(uint32 _domain, bytes32 _id, address _custom) external;
  function enrollRemoteRouter(uint32 _domain, bytes32 _router) external;
  function handle(uint32 _origin, uint32 _nonce, bytes32 _sender, bytes memory _message) external;
  function initialize(address _tokenRegistry, address _xAppConnectionManager) external;
  function liquidityProvider(bytes32) external view returns (address);
  function migrate(address _oldRepr) external;
  function owner() external view returns (address);
  function preFill(uint32 _origin, uint32 _nonce, bytes memory _message) external;
  function remotes(uint32) external view returns (bytes32);
  function renounceOwnership() external;
  function send(address _token, uint256 _amount, uint32 _destination, bytes32 _recipient, bool _enableFast) external;
  function setXAppConnectionManager(address _xAppConnectionManager) external;
  function tokenRegistry() external view returns (address);
  function transferOwnership(address newOwner) external;
  function xAppConnectionManager() external view returns (address);
}
contract CrossChainBridgeBacker_EVMOS_Nomad is CrossChainBridgeBacker {
    uint32 public destination = 6648936;
    bytes32 public recipient;
    constructor (
        address _owner,
        address _timelock_address,
        address _cross_chain_oracle_address,
        address[5] memory _token_addresses,
        address[3] memory _bridge_addresses,
        address _destination_address_override,
        string memory _non_evm_destination_address,
        string memory _name
    ) 
    CrossChainBridgeBacker(_owner, _timelock_address, _cross_chain_oracle_address, _token_addresses, _bridge_addresses, _destination_address_override, _non_evm_destination_address, _name)
    {}
    function setDestination(uint32 _destination) external onlyByOwnGov {
        destination = _destination;
    }
    function setRecipient(bytes32 _recipient) external onlyByOwnGov {
        recipient = _recipient;
    }
    function _bridgingLogic(uint256 token_type, address address_to_send_to, uint256 token_amount) internal override {
        if (token_type == 0){
            anyFRAX.approve(bridge_addresses[token_type], token_amount);
            IBridgeRouter(bridge_addresses[token_type]).send(address(anyFRAX), token_amount, destination, recipient, false);
        }
        else if (token_type == 1) {
            anyFRAX.approve(bridge_addresses[token_type], token_amount);
            IBridgeRouter(bridge_addresses[token_type]).send(address(anyFXS), token_amount, destination, recipient, false);
        }
        else {
            anyFRAX.approve(bridge_addresses[token_type], token_amount);
            IBridgeRouter(bridge_addresses[token_type]).send(address(collateral_token), token_amount, destination, recipient, false);
        }
    }
}

