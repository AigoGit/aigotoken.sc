pragma solidity ^0.4.21;

import "./DetailedERC20.sol";
import "./StandardBurnableToken.sol";

contract AigoTokenERC20 is StandardBurnableToken, DetailedERC20 {
    constructor(string _name, string _symbol, uint8 _decimals, uint256 _supply) DetailedERC20(_name, _symbol, _decimals) public {
        totalSupply_ = _supply;
        balances[msg.sender] = _supply;
    }
}