const { ethers, upgrades } = require("hardhat");

async function main() {
    //The address of the TRANSPARENT PROXY, not the implementation contract

  //NFT_CONTRACT_ADDRESS = process.env.NFT_PUBLIC_ADDRESS_TESTNET
  NFT_CONTRACT_ADDRESS = process.env.NFT_PUBLIC_ADDRESS

  //substitute for name of new contract
  let newContract = "ERC721AUpgradeableNFTV2"

  const ERC721AContractV2 = await ethers.getContractFactory(newContract);

  const nftContract = await upgrades.upgradeProxy(NFT_CONTRACT_ADDRESS, ERC721AContractV2, {gasPrice: 100000000000});

  
  console.log(`NFT Contract Upgraded ${nftContract.address}`);
}

main();