// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradBox is Script {
    function run() external returns (address) {
        address recentlyDeployedBox = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );
        BoxV2 newbox = new BoxV2();
        address proxy = upgradeablebox(recentlyDeployedBox, address(newbox));
        return proxy;
    }

    function upgradeablebox(
        address proxyaddress,
        address newBox
    ) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyaddress);   // point to boxV1 contract
        proxy.upgradeTo(address(newBox));    // upgrade and point to boxV2 contract
        vm.stopBroadcast();
        return address(proxy);
    }
}
