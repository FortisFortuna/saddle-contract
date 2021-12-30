import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleBscUSDPool = await getOrNull("SaddleBscFraxBusd")
  if (saddleBscUSDPool) {
    log(`reusing "SaddleBscFraxBusd" at ${saddleBscUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0x90C97F71E18723b0Cf0dfa30ee176Ab653E89F40", // FRAX
      "0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56", // BUSD
    ]
    const TOKEN_DECIMALS = [18, 18]
    const LP_TOKEN_NAME = "Saddle FRAX/BUSD"
    const LP_TOKEN_SYMBOL = "saddleBscUSD"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("SaddleBscFraxBusd", {
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
      "SaddleBscFraxBusd",
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

  const lpTokenAddress = (await read("SaddleBscFraxBusd", "swapStorage"))
    .lpToken
  log(`Saddle BSC USD Pool LP Token at ${lpTokenAddress}`)

  await save("SaddleBscFraxBusdLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })
}
export default func
func.tags = ["SaddleBscFraxBusd"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
