pragma solidity ^0.4.21;

import "./DetailedERC20.sol";
import "./StandardBurnableToken.sol";
import "./ERC223ReceivingContract.sol";

contract AigoTokenERC223 is StandardBurnableToken, DetailedERC20 {
    constructor(string _name, string _symbol, uint8 _decimals, uint256 _supply) DetailedERC20(_name, _symbol, _decimals) public {
        totalSupply_ = _supply;
        balances[msg.sender] = _supply;
    }
    function transfer(address _to, uint256 _value, bytes _data) public returns (bool) {
        bool result = super.transfer(_to, _value);
        if (result) {
            uint codeLength;

            assembly {
            // Retrieve the size of the code on target address, this needs assembly .
                codeLength := extcodesize(_to)
            }

            if(codeLength>0) {
                ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
                receiver.tokenFallback(msg.sender, _value, _data);
            }
        }
        return result;
    }
    function transfer(address _to, uint256 _value) public returns (bool) {
        bool result = super.transfer(_to, _value);
        if (result) {
            uint codeLength;
            bytes memory empty;

            assembly {
            // Retrieve the size of the code on target address, this needs assembly .
                codeLength := extcodesize(_to)
            }

            if(codeLength>0) {
                ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
                receiver.tokenFallback(msg.sender, _value, empty);
            }
        }
        return result;
    }
    function transferFrom(address _from, address _to, uint256 _value, bytes _data) public returns (bool) {
        bool result = super.transferFrom(_from, _to, _value);
        if (result) {
            uint codeLength;

            assembly {
            // Retrieve the size of the code on target address, this needs assembly .
                codeLength := extcodesize(_to)
            }

            if(codeLength>0) {
                ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
                receiver.tokenFallback(_from, _value, _data);
            }
        }
        return result;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        bool result = super.transferFrom(_from, _to, _value);
        if (result) {
            uint codeLength;
            bytes memory empty;

            assembly {
            // Retrieve the size of the code on target address, this needs assembly .
                codeLength := extcodesize(_to)
            }

            if(codeLength>0) {
                ERC223ReceivingContract receiver = ERC223ReceivingContract(_to);
                receiver.tokenFallback(_from, _value, empty);
            }
        }
        return result;
    }
}