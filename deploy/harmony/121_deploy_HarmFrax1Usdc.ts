import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleBobaUSDPool = await getOrNull("SaddleHarmFrax1USDC")
  if (saddleBobaUSDPool) {
    log(`reusing "SaddleHarmFrax1USDC" at ${saddleBobaUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0xFa7191D292d5633f702B0bd7E3E3BcCC0e633200", // FRAX
      "0x985458e523db3d53125813ed68c274899e9dfab4", // 1USDC
    ]
    const TOKEN_DECIMALS = [18, 6]
    const LP_TOKEN_NAME = "Saddle FRAX/1USDC"
    const LP_TOKEN_SYMBOL = "SaddleHarmFrax1USDC"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("SaddleHarmFrax1USDC", {
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
      "SaddleHarmFrax1USDC",
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

  const lpTokenAddress = (await read("SaddleHarmFrax1USDC", "swapStorage"))
    .lpToken
  log(`Saddle HARM USD Pool LP Token at ${lpTokenAddress}`)

  await save("SaddleHarmFrax1USDCLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })

  // Save for later
  // await execute(
  //   "SaddleHarmFrax1USDC",
  //   { from: deployer, log: true },
  //   "transferOwnership",
  //   BSC_MULTISIG_ADDRESS,
  // )
}
export default func
func.tags = ["SaddleHarmFrax1USDC"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
