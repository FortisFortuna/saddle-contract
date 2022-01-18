import "@nomiclabs/hardhat-ethers"
import "@nomiclabs/hardhat-waffle"
import "@nomiclabs/hardhat-web3"
import "@nomiclabs/hardhat-etherscan"
import "@typechain/hardhat"
import "hardhat-gas-reporter"
import "solidity-coverage"
import "hardhat-deploy"
import "hardhat-spdx-license-identifier"

import { HardhatUserConfig } from "hardhat/config"
import dotenv from "dotenv"
import { ethers } from "ethers"

dotenv.config()

let config: HardhatUserConfig = {
  defaultNetwork: "aurora",
  networks: {
    hardhat: {
      deploy: ["./deploy/mainnet/"],
    },
    mainnet: {
      url: process.env.ALCHEMY_API,
      gasPrice: 100 * 1000000000,
      deploy: ["./deploy/mainnet/"],
    },
    arbitrum_mainnet: {
      url: "https://arb1.arbitrum.io/rpc",
      gasPrice: ethers.utils.parseUnits("2", "gwei").toNumber(),
      deploy: ["./deploy/arbitrum/"],
    },
    aurora: {
			url: process.env.AURORA_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.AURORA_MNEMONIC_PHRASE
			},
			chainId: 1313161554,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("4", "gwei").toNumber(), // 4 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/aurora/"],
		},
    boba: {
			url: process.env.BOBA_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.BOBA_MNEMONIC_PHRASE
			},
			chainId: 288,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("10", "gwei").toNumber(), // 10 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/boba/"],
		},
    bsc: {
			url: process.env.BSC_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.BSC_MNEMONIC_PHRASE
			},
			chainId: 56,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("10", "gwei").toNumber(), // 10 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/bsc/"],
		},
    harmony: {
			url: process.env.HARMONY_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.HARMONY_MNEMONIC_PHRASE
			},
			chainId: 1666600000,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("10", "gwei").toNumber(), // 10 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/harmony/"],
		},
    moonbeam: {
			url: process.env.MOONBEAM_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.MOONBEAM_MNEMONIC_PHRASE
			},
			chainId: 1284,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("150", "gwei").toNumber(), // 101 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/moonbeam/"],
		},
    moonriver: {
			url: process.env.MOONRIVER_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.MOONRIVER_MNEMONIC_PHRASE
			},
			chainId: 1285,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("3", "gwei").toNumber(), // 3 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/moonriver/"],
		},
    optimism: {
			url: process.env.OPTIMISM_NETWORK_ENDPOINT,
			accounts: {
				mnemonic: process.env.OPTIMISM_MNEMONIC_PHRASE
			},
			chainId: 10,
			gas: "auto",
			gasPrice: ethers.utils.parseUnits("1", "gwei").toNumber(), // 1 Gwei
			gasMultiplier: 1.2,
      deploy: ["./deploy/optimism/"],
		},
  },
  paths: {
    sources: "./contracts",
    artifacts: "./build/artifacts",
    cache: "./build/cache",
  },
  solidity: {
    compilers: [
      {
        version: "0.5.16",
      },
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 100000,
          },
        },
      },
      {
        version: "0.8.10",
        settings: {
          optimizer: {
            enabled: true,
            runs: 100000,
          },
        },
      },
    ],
  },
  typechain: {
    outDir: "./build/typechain/",
    target: "ethers-v5",
  },
  gasReporter: {
    currency: "USD",
    gasPrice: 21,
  },
  mocha: {
    timeout: 200000,
  },
  namedAccounts: {
    deployer: {
      default: 0, // here this will by default take the first account as deployer
      1: 0, // similarly on mainnet it will take the first account as deployer. Note though that depending on how hardhat network are configured, the account 0 on one network can be different than on another
      42161: 0,
    },
    libraryDeployer: {
      default: 1, // use a different account for deploying libraries on the hardhat network
      1: 0, // use the same address as the main deployer on mainnet
      42161: 0, // use the same address on arbitrum mainnet
    },
  },
  spdxLicenseIdentifier: {
    overwrite: false,
    runOnCompile: true,
  },
  etherscan: {
		// apiKey: process.env.BSCSCAN_API_KEY // BSC
		// apiKey: process.env.ETHERSCAN_API_KEY, // ETH Mainnet
		// apiKey: process.env.FTMSCAN_API_KEY // Fantom
    apiKey: process.env.MOONBEAM_API_KEY // Moonbeam
    // apiKey: process.env.MOONRIVER_API_KEY // Moonriver
    // apiKey: process.env.OPTIMISM_API_KEY // Optimism
		// apiKey: process.env.POLYGONSCAN_API_KEY // Polygon
	},
}



if (process.env.ACCOUNT_PRIVATE_KEYS) {
  config.networks = {
    ...config.networks,
    mainnet: {
      ...config.networks?.mainnet,
      accounts: JSON.parse(process.env.ACCOUNT_PRIVATE_KEYS),
    },
    arbitrum_mainnet: {
      ...config.networks?.arbitrum_mainnet,
      accounts: JSON.parse(process.env.ACCOUNT_PRIVATE_KEYS),
    },
  }
}

if (process.env.FORK_MAINNET === "true" && config.networks) {
  console.log("FORK_MAINNET is set to true")
  config = {
    ...config,
    networks: {
      ...config.networks,
      hardhat: {
        ...config.networks.hardhat,
        forking: {
          url: process.env.ALCHEMY_API ? process.env.ALCHEMY_API : "",
        },
        chainId: 1,
      },
    },
    external: {
      deployments: {
        hardhat: ["deployments/mainnet"],
      },
    },
  }
}

export default config
