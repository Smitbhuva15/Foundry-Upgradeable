// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";



 contract BoxV2 is UUPSUpgradeable {
    uint256 internal number;

    function getNumber() public view returns (uint256) {
        return number;
    }

        function setNumber(uint256 _number) internal {
        number = _number;
    }



    function version() public pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}