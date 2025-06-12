// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradBox} from "../script/UpgradBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {Test} from "forge-std/Test.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox deployBox;
    UpgradBox upgradeBox;


    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradBox();
    }

    function testboxWork() public {
        address proxy = deployBox.run();
         BoxV1 boxV1 = BoxV1(proxy);
        assertEq(boxV1.version(), 1);
    }

    function testDeploymentIsV1() public {
        address proxyAddress = deployBox.run();
        uint256 expectedValue = 7;
        vm.expectRevert();
        BoxV2 boxV2 = BoxV2(proxyAddress);
        boxV2.setValue(expectedValue);
    }

    function testUpgradeToV2() public {
        address proxyAddress = deployBox.run();
        BoxV1 boxV1 = BoxV1(proxyAddress);
        assertEq(boxV1.version(), 1);

        BoxV2 boxV2 = new BoxV2();
        address upgradedProxy = upgradeBox.upgradeablebox(proxyAddress, address(boxV2));
        
        assertEq(BoxV2(upgradedProxy).version());

        BoxV2(upgradedProxy).setNumber(8);
        assertEq(BoxV2(upgradedProxy).getNumber(),8);
    }

}
