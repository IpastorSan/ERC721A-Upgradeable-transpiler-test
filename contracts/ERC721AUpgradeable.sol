// SPDX-License-Identifier: UNLICENSED



pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "erc721a-upgradeable/contracts/ERC721AUpgradeable.sol";




contract ERC721AUpgradeableNFT is ERC721AUpgradeable, OwnableUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;

 

    CountersUpgradeable.Counter private _tokenIds;
    uint256 public  MAX_SUPPLY;
    uint256 public  PRICE ;
    uint256 public  MAX_PER_MINT ;
    uint256 private MAX_RESERVED_MINTS ;
    uint256 private RESERVED_MINTS ;
    
    string public baseTokenURI;

        function initialize(string memory name, string memory symbol) public initializer {
        __Ownable_init();
        __ERC721A_init(name, symbol);
        MAX_SUPPLY = 100;
        PRICE = 0.001 ether;
        MAX_PER_MINT = 5;
        MAX_RESERVED_MINTS = 100;
        RESERVED_MINTS = 0;
        
    }

    function _baseURI() internal view virtual override returns (string memory) {
       return baseTokenURI;
    }
    
    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }


    function mintNFTs(uint256 _number) public payable {
        uint256 totalMinted = _tokenIds.current();

        require(totalMinted + _number <= MAX_SUPPLY, "Not enough NFTs!");
        require(_number > 0 && _number <= MAX_PER_MINT, "Cannot mint specified number of NFTs.");
        require(msg.value >= PRICE * _number , "Not enough ether to purchase NFTs.");
        
        for (uint i = 0; i < _number; i++) {
            _mintSingleNFT();
        }
    }

    function _mintSingleNFT() private {
      uint newTokenID = _tokenIds.current();
      _safeMint(msg.sender, newTokenID);
      _tokenIds.increment();

    }

    function reserveNFTs(uint256 number) public onlyOwner {
        uint256 totalMinted = _tokenIds.current();
        RESERVED_MINTS = RESERVED_MINTS + number;
        require((totalMinted + number) < MAX_SUPPLY);
        require(RESERVED_MINTS < MAX_RESERVED_MINTS);
        
        for (uint256 i = 0; i < 10; i++) {
            _mintSingleNFT();
        }
    }


//Withdraw money in contract to Owner
    function withdraw() public payable onlyOwner {
     uint256 balance = address(this).balance;
     require(balance > 0, "No ether left to withdraw");

     (bool successProject, ) = msg.sender.call{value: balance}("");

     require(successProject, "Transfer failed.");
    }

    
}