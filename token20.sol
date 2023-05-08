// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IECToken is ERC20, ERC20Burnable, Ownable {
        uint public tokenPrice = 1 ether;
        address Owner;
        mapping (address => uint) checkBalance;
    constructor() ERC20("IECToken", "IECT") {
        Owner = msg.sender;
    }

    function mint( uint256 amount) public onlyOwner {
        _mint(msg.sender, amount * 10** 18);
    }

    function setNewPrice( uint newPrice) public onlyOwner {
            tokenPrice = newPrice;
    }
    function Buytoken () public payable {
        require (balanceOf(msg.sender) < 5 * 10 ** 18 );
        require(msg.value >= tokenPrice, "You dont have enough money" );
        uint NumberOfTokens = msg.value / tokenPrice;
        uint amount = msg.value - NumberOfTokens*tokenPrice;
        _transfer(Owner,msg.sender, NumberOfTokens * 10  ** 18);
        payable (msg.sender).transfer(amount);

}

}