pragma solidity ^0.4.2;

contract Token{
    string private name = "icraftToken";
    string private symbol = "ICC";
    uint256 private totalSupply = 10000;
    
    mapping(address => uint) private balanceOf;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    function Token() public{
        balanceOf[msg.sender] = totalSupply;
    }
    
    function transfer(address _to, uint256 _value) public returns(bool){
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function getName() public view returns(string){
        return name;
    }
    
    function getSymbole() public view returns(string){
        return symbol;
    }
    
    function getTotalSupply() public view returns(uint){
        return totalSupply;
    }
    
    function balance(address user) public view returns(uint){
        return balanceOf[user];
    }
    
}