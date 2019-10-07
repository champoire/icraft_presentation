pragma solidity ^0.4.2;

import "./icraftToken.sol";

contract crowdsale{
     Token private icraftToken;
     uint256 private amountSold = 0;
     uint256 private price = 100000000000000000; //Wei
     bool private isFinished = false;
     address private owner;
     
     function crowdsale(address _token) public {
         icraftToken = Token(_token);
         owner = msg.sender;
     }
     
     function buyToken() public payable{
         require(msg.value >= price);
         require(!isFinished);
         //calculate the price
         uint tokens = msg.value / price;
         require(icraftToken.balance(this) >= tokens);
         //increase amount of token sold
         amountSold += tokens;
         //transfer token to the buyer
         icraftToken.transfer(msg.sender, tokens);
         
         
     }
     
     function endSale() public{
        require(msg.sender == owner);
        icraftToken.transfer(owner, icraftToken.balance(this));
        owner.transfer(address(this).balance);
        isFinished = true;
    }
     
     function getTokenAddress() public view returns(address){
         return address(icraftToken);
     }
     function getOwner() public view returns(address){
         return owner;
     }
     function tokenSold() public view returns(uint){
         return amountSold;
     }
     
}