const { ethers, upgrades } = require("hardhat");

async function main() {
  //substitute for contract name
  const contractName = "ERC721AUpgradeableNFT"
  
  const ERC721Contract = await ethers.getContractFactory(contractName);

  const nftContract = await upgrades.deployProxy(ERC721Contract, ["ERC721A-U", "E721AU"]);

  await nftContract.deployed();
  
  console.log("NFT Contract deployed to:", nftContract.address);
}

main();