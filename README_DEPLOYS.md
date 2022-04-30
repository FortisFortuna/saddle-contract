1) Change chain in hardhat config
2) npx hardhat deploy
3a (Etherscan & clones) npx hardhat --network moonbeam verify 0x71173Eb21b84d6b028fb46baFC77FeFC0FF6888E (will auto verify on Etherscan)
3b (Blockscout 1) npx hardhat --network moonbeam sourcify (will auto verify on Blockscout)
3c (Blockscout 2) npx hardhat --network evmos sourcify --contract-name CrossChainBridgeBacker_EVMOS_Nomad --write-failing-metadata


FLATTEN [WILL PROBABLY NOT WORK DUE TO CYCLIC DEPENDENCIES]
npx hardhat flatten ./contracts/SwapFlashLoan.sol > ./flattened.sol