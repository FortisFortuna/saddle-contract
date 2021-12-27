import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"
import { BSC_MULTISIG_ADDRESS } from "../../utils/accounts"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { execute, get, getOrNull, log, read, save, deploy } = deployments
  const { deployer } = await getNamedAccounts()

  // Manually check if the pool is already deployed
  const saddleBobaUSDPool = await getOrNull("SaddleBobaFraxUsdc")
  if (saddleBobaUSDPool) {
    log(`reusing "SaddleBobaFraxUsdc" at ${saddleBobaUSDPool.address}`)
  } else {
    // Constructor arguments
    const TOKEN_ADDRESSES = [
      "0x7562F525106F5d54E891e005867Bf489B5988CD9", // FRAX
      "0x66a2A913e447d6b4BF33EFbec43aAeF87890FBbc", // USDC
    ]
    const TOKEN_DECIMALS = [18, 6]
    const LP_TOKEN_NAME = "Saddle FRAX/USDC"
    const LP_TOKEN_SYMBOL = "SaddleBobaFraxUsdc"
    const INITIAL_A = 2500
    const SWAP_FEE = 4e6 // 4bps
    const ADMIN_FEE = 0

    await deploy("SaddleBobaFraxUsdc", {
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
      "SaddleBobaFraxUsdc",
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

  const lpTokenAddress = (await read("SaddleBobaFraxUsdc", "swapStorage"))
    .lpToken
  log(`Saddle BOBA USD Pool LP Token at ${lpTokenAddress}`)

  await save("SaddleBobaFraxUsdcLPToken", {
    abi: (await get("LPToken")).abi, // LPToken ABI
    address: lpTokenAddress,
  })

  // Save for later
  // await execute(
  //   "SaddleBobaFraxUsdc",
  //   { from: deployer, log: true },
  //   "transferOwnership",
  //   BSC_MULTISIG_ADDRESS,
  // )
}
export default func
func.tags = ["SaddleBobaFraxUsdc"]
func.dependencies = ["SwapUtils", "SwapFlashLoan"]
