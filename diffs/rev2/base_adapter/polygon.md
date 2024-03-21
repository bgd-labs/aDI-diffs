```diff
diff --git a/etherscan/rev2/current/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol b/etherscan/rev2/new/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol
index c554ced..e220f60 100644
--- a/etherscan/rev2/current/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol
+++ b/etherscan/rev2/new/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.8;
 
-import {IBaseAdapter} from "./IBaseAdapter.sol";
-import {IBaseCrossChainController} from "../interfaces/IBaseCrossChainController.sol";
+import {IBaseAdapter, IBaseCrossChainController} from "./IBaseAdapter.sol";
 import {Errors} from "../libs/Errors.sol";
 
 /**
@@ -12,19 +11,31 @@ import {Errors} from "../libs/Errors.sol";
  * @dev All bridge adapters must implement this contract
  */
 abstract contract BaseAdapter is IBaseAdapter {
+    /// @inheritdoc IBaseAdapter
     IBaseCrossChainController public immutable CROSS_CHAIN_CONTROLLER;
 
+    /// @inheritdoc IBaseAdapter
+    uint256 public immutable BASE_GAS_LIMIT;
+
     // @dev this is the original address of the contract. Required to identify and prevent delegate calls.
     address private immutable _selfAddress;
 
     // (standard chain id -> origin forwarder address) saves for every chain the address that can forward messages to this adapter
     mapping(uint256 => address) internal _trustedRemotes;
 
+    /// @inheritdoc IBaseAdapter
+    string public adapterName;
+
     /**
      * @param crossChainController address of the CrossChainController the bridged messages will be routed to
+     * @param providerGasLimit base gas limit used by the bridge adapter
+     * @param name name of the bridge adapter contract
+     * @param originConfigs pair of origin address and chain id that adapter is allowed to get messages from
      */
     constructor(
         address crossChainController,
+        uint256 providerGasLimit,
+        string memory name,
         TrustedRemotesConfig[] memory originConfigs
     ) {
         require(
@@ -35,6 +46,9 @@ abstract contract BaseAdapter is IBaseAdapter {
             crossChainController
         );
 
+        BASE_GAS_LIMIT = providerGasLimit;
+        adapterName = name;
+
         _selfAddress = address(this);
 
         for (uint256 i = 0; i < originConfigs.length; i++) {
@@ -62,6 +76,7 @@ abstract contract BaseAdapter is IBaseAdapter {
         uint256 infraChainId
     ) public view virtual returns (uint256);
 
+    /// @inheritdoc IBaseAdapter
     function setupPayments() external virtual {}
 
     /// @inheritdoc IBaseAdapter
```
