// contracts/GeoNexusToken.sol
// SPDX-License-Identifier: MIT
// This is the official version of GNT Token
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract GeoNexusToken is ERC20, ERC20Capped, ERC20Burnable {
    address payable owner;
    uint256 public blockReward;

    constructor(uint256 cap, uint reward) ERC20("GeoNexus Token", "GNT") ERC20Capped(cap * (10 ** decimals())) {
        _mint(msg.sender, 69000000 * (10 ** decimals()));
        owner = payable(msg.sender);
        blockReward = reward * (10 ** decimals());
    }

    /**
     * @dev See {ERC20Capped-_mint}.
     */
    function _mint(address account, uint256 amount) internal virtual override(ERC20Capped, ERC20) {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override {
        if (from != address(0) && to != block.coinbase && block.coinbase != address(0)) {
          _mintMinerReward();
        }
        super._beforeTokenTransfer(from, to, value);
    }

    function getBlockReward() public view returns (uint256) {
        return blockReward;
    }

function setBlockReward(uint256 reward) public onlyOwner returns (uint256) {
    return blockReward = reward * (10 ** decimals());
}
    // Contract destructor

    function transferEther(address payable _to) public {
       _to.transfer(address(this).balance);
    }

    // Access control modifier
    modifier onlyOwner() {
        require(owner == _msgSender(), "Ownable: Only Owner Can Modifie This");
        _;
    }

}
