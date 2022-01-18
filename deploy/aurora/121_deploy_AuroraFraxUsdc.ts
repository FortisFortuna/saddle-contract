import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleAurUSDPool = await getOrNull("AuroraFraxUsdc")
  if (saddleAurUSDPool) {
    log(`reusing "AuroraFraxUsdc" at ${saddleAurUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0xE4B9e004389d91e4134a28F19BD833cBA1d994B6", // FRAX
      "0xB12BFcA5A55806AaF64E99521918A4bf0fC40802", // USDC
    ]
    const TOKEN_DECIMALS = [18, 6]
    const LP_TOKEN_NAME = "Saddle FRAX/USDC"
    const LP_TOKEN_SYMBOL = "AuroraFraxUsdc"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("AuroraFraxUsdc", {
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
      "AuroraFraxUsdc",
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

  const lpTokenAddress = (await read("AuroraFraxUsdc", "swapStorage"))
    .lpToken
  log(`Saddle FRAX USD Pool LP Token at ${lpTokenAddress}`)

  await save("AuroraFraxUsdcLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })
}
export default func
func.tags = ["AuroraFraxUsdc"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
