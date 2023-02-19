// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract callAnything {
    address public s_someAddress;
    uint256 public s_amount;

    function tranfer(address _someAddress, uint256 _amount) public {
        s_someAddress = _someAddress;
        s_amount = _amount;
    }

    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }
    function getDataToCallTransfer(address someAdress, uint256 amount) public pure returns(bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAdress, amount);
    }
    function callTransferFunc1(address someAddress, uint256 amount) public returns (bytes4, bool) 
    {
        (bool success, bytes memory returnData) = address(this).call(
            // getDataToCallTransfer(someAddress, amount);
            abi.encodeWithSelector(getSelectorOne(), someAddress, amount)
        );
        return (bytes4(returnData), success);
    }

    function callTranferFuncWithSignature (address someAddress, uint256 amount) public returns(bytes4, bool)
    {
        (bool success, bytes memory returnData) = address(this).call(
            abi.encodeWithSignature("transfer(address,uint256)", someAddress, amount)
        );
        return (bytes4(returnData), success);
    }
}