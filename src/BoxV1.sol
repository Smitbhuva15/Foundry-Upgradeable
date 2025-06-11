// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

abstract contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable{
    uint256 internal number;

    constructor() {
        _disableInitializers(); 
    }

    function initialize(address owner) public initializer {
        __Ownable_init(owner);
        __UUPSUpgradeable_init();
        
    }


    function getNumber() public view returns (uint256) {
        return number;
    }

        function setNumber(uint256 _number) internal {
        number = _number;
    }

    function version() public pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override  {}

}