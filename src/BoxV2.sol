// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


contract BoxV2  {
    uint256 internal number;

    function getNumber() public view returns (uint256) {
        return number;
    }


    function version() public pure returns (uint256) {
        return 2;
    }
}