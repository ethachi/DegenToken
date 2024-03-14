// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    string public degen_store;
    string public double_mint;
    
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        degen_store = "The Degen store has the following redeemable items: 1. Degen Tree 2. Degen Toy 3. Degen NFT ";
        double_mint = "You can double mint only if you have 50-100 tokens";     
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 burn_amount) public override {
        require(balanceOf(msg.sender) >= burn_amount, "Insufficient Balance");
        _burn(msg.sender, burn_amount);
    }

    function redeem(uint256 redeem_value, bool store) public {
        require(store == true, "Make sure you have read the item lists available in our store");
        if (balanceOf(msg.sender) < 100) {
            revert("Insufficient Balance");
        }
        assert(redeem_value > 0 && redeem_value < 4);
        _burn(msg.sender, redeem_value * 25);
    }

    function doublemint(uint256 amount) public {
        require(
            balanceOf(msg.sender) >= 50 && balanceOf(msg.sender) <= 100,
            "Please read rules to double mint"
        );
        _mint(msg.sender, amount * 2);
    }
    
    function transferToken(address reciver, uint256 amount) public  {
        _transfer(_msgSender(), reciver, amount);
    }
}
