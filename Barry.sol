pragma solidity ^0.4.11;

import './ERCToken.sol';
import './SafeMath.sol';

contract BarryToken is ERC20 {
    using SafeMath for uint256;
    
    address public owner;
    
    string public symbol = 'BARRY';
    string public name = 'BARRY Token';

    uint8 public constant decimals = 18;
    uint256 public constant tokensPerEther = 2;

    uint256 public _totalSupply =     100000000000000000000;
    uint256 public _maxSupply  =   100000000000000000000000;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) public allowed;
    
    function BarryToken() {
        owner = msg.sender;
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() constant returns (uint256 totalSupply) {
        return _totalSupply;
    }
    
    function () payable {
        require( msg.value > 0 && _totalSupply < _maxSupply );

        uint256 baseTokens  = msg.value.mul(tokensPerEther);

        balances[msg.sender] = balances[msg.sender].add(baseTokens);

        owner.transfer(msg.value);
        
        _totalSupply      = _totalSupply.add(baseTokens);

        Transfer(address(this), msg.sender, baseTokens);
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) returns (bool success) {
        require((_value <= balances[msg.sender]));
        require((_value > 0));
        require(_to != address(0));
        require(balances[_to].add(_value) >= balances[_to]);
        require(msg.data.length >= (2 * 32) + 4);


        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        require((_value <= allowed[_from][msg.sender] ));
        require((_value > 0));
        require(_to != address(0));
        require(balances[_to].add(_value) >= balances[_to]);
        require(msg.data.length >= (2 * 32) + 4);


        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        Transfer(_from, _to, _value);
        return true;
    }



    function approve(address _spender, uint256 _value) returns (bool success) {

        require( (_value == 0)  || (allowed[msg.sender][_spender] == 0) );

        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }


    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }


    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
}