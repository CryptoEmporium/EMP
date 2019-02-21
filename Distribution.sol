pragma solidity ^0.5.4;
/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  constructor () public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}

interface token { function transfer(address, uint) external; }

contract DistributeTokens is Ownable {

  token tokenInstance;
  address public addressOfToken;
  function setTokenReward(address _addr) external onlyOwner {
    tokenInstance = token(_addr);
    addressOfToken = _addr;
  }

  function distributeVariable(address[] _addrs, uint[] _bals) external onlyOwner {
    for(uint i = 0; i < _addrs.length; ++i){
      tokenInstance.transfer(_addrs[i],_bals[i]);
    }
  }

  function distributeFixed(address[] _addrs, uint _amoutToEach) external onlyOwner {
    for(uint i = 0; i < _addrs.length; ++i){
      tokenInstance.transfer(_addrs[i],_amoutToEach);
    }
  }

  function withdrawTokens(uint _amount) external onlyOwner {
    tokenInstance.transfer(owner,_amount);
  }
}
