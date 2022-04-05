require("@nomiclabs/hardhat-waffle");
require('dotenv').config()
require('@openzeppelin/hardhat-upgrades');

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: process.env.DEVELOPMENT_ALCHEMY_KEY_RINKEBY,
      accounts: [process.env.PRIVATE_KEY],
      gasPrice: 100000000000,
      gasLimit: 1000000000,
    },
    polygonMumbai: {
      url: process.env.DEVELOPMENT_ALCHEMY_KEY_MUMBAI,
      accounts: [process.env.PRIVATE_KEY],
      gasPrice: 100000000000,
    },
  },
  etherscan: {
        // Your API key for Etherscan
        // Obtain one at https://etherscan.io/
      apiKey: process.env.POLYGONSCAN_KEY,
      }
    };