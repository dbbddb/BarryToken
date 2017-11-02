pragma solidity ^0.4.11;

contract ERC20 {
    
    function balanceOf( address who ) constant returns (uint value);
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);
    
    function transfer(address _to, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);

    event Transfer( address indexed from, address indexed to, uint value);
    event Approval( address indexed owner, address indexed spender, uint value);
}
