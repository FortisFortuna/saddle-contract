import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleMnbmUSDPool = await getOrNull("SaddleMnbmFraxUsdc")
  if (saddleMnbmUSDPool) {
    log(`reusing "SaddleMnbmFraxUsdc" at ${saddleMnbmUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0x322E86852e492a7Ee17f28a78c663da38FB33bfb", // FRAX
      "0x8f552a71EFE5eeFc207Bf75485b356A0b3f01eC9", // USDC
    ]
    const TOKEN_DECIMALS = [18, 6]
    const LP_TOKEN_NAME = "Saddle FRAX/USDC"
    const LP_TOKEN_SYMBOL = "SaddleMnbmFraxUsdc"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("SaddleMnbmFraxUsdc", {
      from: deployer,
      log: true,
      contract: "SwapFlashLoan",
      libraries: {
        SwapUtils: (await get("SwapUtils")).address,
        AmplificationUtils: (await get("AmplificationUtils")).address,
      },
      skipIfAlreadyDeployed: true,
    })

    await execute(
      "SaddleMnbmFraxUsdc",
      { from: deployer, log: true },
      "initialize",
      TOKEN_ADDRESSES,
      TOKEN_DECIMALS,
      LP_TOKEN_NAME,
      LP_TOKEN_SYMBOL,
      INITIAL_A,
      SWAP_FEE,
      ADMIN_FEE,
      (
        await get("LPToken")
      ).address,
    )
  }

  const lpTokenAddress = (await read("SaddleMnbmFraxUsdc", "swapStorage"))
    .lpToken
  log(`Saddle MNBM USD Pool LP Token at ${lpTokenAddress}`)

  await save("SaddleMnbmFraxUsdcLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })
}
export default func
func.tags = ["SaddleMnbmFraxUsdc"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
