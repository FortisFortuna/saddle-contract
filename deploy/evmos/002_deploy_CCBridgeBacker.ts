import { HardhatRuntimeEnvironment } from "hardhat/types"
import { DeployFunction } from "hardhat-deploy/types"
import { isTestNetwork } from "../../utils/network"

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts, getChainId } = hre
  const { deploy, execute, getOrNull, log } = deployments
  const { libraryDeployer } = await getNamedAccounts()

  const ccBridgeBacker_EVMOS_Nomad = await getOrNull("CrossChainBridgeBacker_EVMOS_Nomad")
  if (ccBridgeBacker_EVMOS_Nomad) {
    log(`reusing "ccBridgeBacker_EVMOS_Nomad" at ${ccBridgeBacker_EVMOS_Nomad.address}`)
  } else {
    await deploy("CrossChainBridgeBacker_EVMOS_Nomad", {
      from: libraryDeployer,
      log: true,
      args: [
        "0x29fAF425F898F1af8fbA07654C83CD9D19f8e270",
        "0x8412ebf45bAC1B340BbE8F318b928C466c4E39CA",
        "0x7a6DF5e183f4DA46a323c525b32f226d24dBa08F",
        [
          "0x28eC4B29657959F4A5052B41079fe32919Ec3Bd3",
          "0xE03494D0033687543a80c9B1ca7D6237F2EA8BD8",
          "0xd0ec216A38F199B0229AE668a96c3Cd9F9f118A6",
          "0xd8176865DD0D672c6Ab4A427572f80A72b4B4A9C",
          "0x51e44FfaD5C2B122C8b635671FCC8139dc636E82"
        ],
        [
          "0x28eC4B29657959F4A5052B41079fe32919Ec3Bd3",
          "0xd0ec216A38F199B0229AE668a96c3Cd9F9f118A6",
          "0x51e44FfaD5C2B122C8b635671FCC8139dc636E82"
        ],
        "0x0000000000000000000000000000000000000000",
        "",
        "FRAX Evmos Nomad CrossChainBridgeBacker"
      ],
      skipIfAlreadyDeployed: true,
    })

    // await execute(
    //   "LPToken",
    //   { from: libraryDeployer, log: true },
    //   "initialize",
    //   "Saddle LP Token (Target)",
    //   "saddleLPTokenTarget",
    // )
  }
}
export default func
func.tags = ["LPToken"]
