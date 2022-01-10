import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleOptiUSDPool = await getOrNull("SaddleOptiFraxUsdc")
  if (saddleOptiUSDPool) {
    log(`reusing "SaddleOptiFraxUsdc" at ${saddleOptiUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0x2E3D870790dC77A83DD1d18184Acc7439A53f475", // FRAX
      "0x7F5c764cBc14f9669B88837ca1490cCa17c31607", // USDC
    ]
    const TOKEN_DECIMALS = [18, 6]
    const LP_TOKEN_NAME = "Saddle FRAX/USDC"
    const LP_TOKEN_SYMBOL = "saddleOptiUSD"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("SaddleOptiFraxUsdc", {
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
      "SaddleOptiFraxUsdc",
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

  const lpTokenAddress = (await read("SaddleOptiFraxUsdc", "swapStorage"))
    .lpToken
  log(`Saddle BSC USD Pool LP Token at ${lpTokenAddress}`)

  await save("SaddleOptiFraxUsdcLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })
}
export default func
func.tags = ["SaddleOptiFraxUsdc"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
