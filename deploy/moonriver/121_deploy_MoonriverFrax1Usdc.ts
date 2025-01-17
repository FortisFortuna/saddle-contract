import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleMoonUSDPool = await getOrNull("SaddleMoonFraxUsdc")
  if (saddleMoonUSDPool) {
    log(`reusing "SaddleMoonFraxUsdc" at ${saddleMoonUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0x1A93B23281CC1CDE4C4741353F3064709A16197d", // FRAX
      "0xE3F5a90F9cb311505cd691a46596599aA1A0AD7D", // USDC
    ]
    const TOKEN_DECIMALS = [18, 6]
    const LP_TOKEN_NAME = "Saddle FRAX/USDC"
    const LP_TOKEN_SYMBOL = "SaddleMoonFraxUsdc"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("SaddleMoonFraxUsdc", {
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
      "SaddleMoonFraxUsdc",
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

  const lpTokenAddress = (await read("SaddleMoonFraxUsdc", "swapStorage"))
    .lpToken
  log(`Saddle MOON USD Pool LP Token at ${lpTokenAddress}`)

  await save("SaddleMoonFraxUsdcLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })
}
export default func
func.tags = ["SaddleMoonFraxUsdc"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
