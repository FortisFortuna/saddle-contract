import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts, getChainId } = hre
  const { deploy, get } = deployments
  const { libraryDeployer } = await getNamedAccounts()

  await deploy("ComboOracle_UniV2_UniV3", {
    from: libraryDeployer,
    log: true,
    libraries: {
      // SwapUtils: (await get("SwapUtils")).address,
      // AmplificationUtils: (await get("AmplificationUtils")).address,
    },
    skipIfAlreadyDeployed: true,
    args: [
      "0xEEF54910b5200F94e91e4A9A891ca95797B6fbf8",
      [
        "0x7562F525106F5d54E891e005867Bf489B5988CD9",
        "0xae8871A949F255B12704A98c00C2293354a36013",
        "0x354bfCF61fF58289C31205d840dDCaf86f15e966",
        "0x17C83E2B96ACfb5190d63F5E46d93c107eC0b514", // IUniswapV2Router02
        "0x0000000000000000000000000000000000000000", // IUniswapV3Factory
        "0x0000000000000000000000000000000000000000", // INonfungiblePositionManager
        "0x0000000000000000000000000000000000000000" // ISwapRouter
      ]
    ]
  })
}
export default func
func.tags = ["ComboOracle_UniV2_UniV3"]
// func.dependencies = ["AmplificationUtils", "SwapUtils"]
