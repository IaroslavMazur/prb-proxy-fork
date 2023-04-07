// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <=0.9.0;

import { Helpers_Test } from "../Helpers.t.sol";

contract SetPermission_Test is Helpers_Test {
    /// @dev it should set the permission.
    function test_SetPermission_PermissionNotSet() external {
        setPermission({ envoy: users.envoy, target: address(targets.dummy), permission: true });
        bool permission = proxy.permissions({ envoy: users.envoy, target: address(targets.dummy) });
        assertTrue(permission);
    }

    modifier whenPermissionSet() {
        setPermission({ envoy: users.envoy, target: address(targets.dummy), permission: true });
        _;
    }

    /// @dev it should do nothing when re-setting the permission.
    function test_SetPermission_whenPermissionSet_ResetPermission() external whenPermissionSet {
        setPermission({ envoy: users.envoy, target: address(targets.dummy), permission: true });
        bool permission = proxy.permissions({ envoy: users.envoy, target: address(targets.dummy) });
        assertTrue(permission);
    }

    /// @dev it should emit a {SetPermission} event.
    function test_SetPermission_whenPermissionSet_ResetPermission_Event() external whenPermissionSet {
        vm.expectEmit();
        emit SetPermission({ envoy: users.envoy, target: address(targets.dummy), permission: true });
        setPermission({ envoy: users.envoy, target: address(targets.dummy), permission: true });
    }

    /// @dev it should unset the permission.
    function test_SetPermission_whenPermissionSet_UnsetPermission() external whenPermissionSet {
        setPermission({ envoy: users.envoy, target: address(targets.dummy), permission: false });
    }

    /// @dev it should emit a {SetPermission} event.
    function test_SetPermission_whenPermissionSet_UnsetPermission_Event() external whenPermissionSet {
        vm.expectEmit();
        emit SetPermission({ envoy: users.envoy, target: address(targets.dummy), permission: false });
        setPermission({ envoy: users.envoy, target: address(targets.dummy), permission: false });
    }
}
