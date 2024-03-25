```diff
diff --git a/etherscan/rev2/current/adapters/native/mainnet_mainnet/SameChainAdapter/src/contracts/adapters/sameChain/SameChainAdapter.sol b/etherscan/rev2/new/adapters/native/mainnet_mainnet/SameChainAdapter/src/contracts/adapters/sameChain/SameChainAdapter.sol
index de6305f..a5a6bf7 100644
--- a/etherscan/rev2/current/adapters/native/mainnet_mainnet/SameChainAdapter/src/contracts/adapters/sameChain/SameChainAdapter.sol
+++ b/etherscan/rev2/new/adapters/native/mainnet_mainnet/SameChainAdapter/src/contracts/adapters/sameChain/SameChainAdapter.sol
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.8;
 
-import {IBaseAdapter} from "../IBaseAdapter.sol";
+import {IBaseAdapter, IBaseCrossChainController} from "../IBaseAdapter.sol";
 import {IBaseReceiverPortal} from "../../interfaces/IBaseReceiverPortal.sol";
 import {Errors} from "../../libs/Errors.sol";
 import {Transaction, Envelope, TransactionUtils} from "../../libs/EncodingUtils.sol";
@@ -14,6 +14,19 @@ import {Transaction, Envelope, TransactionUtils} from "../../libs/EncodingUtils.
            that the message is forwarded to same chain
  */
 contract SameChainAdapter is IBaseAdapter {
+    /// @inheritdoc IBaseAdapter
+    function CROSS_CHAIN_CONTROLLER()
+        external
+        returns (IBaseCrossChainController)
+    {
+        return IBaseCrossChainController(address(0));
+    }
+
+    /// @inheritdoc IBaseAdapter
+    function BASE_GAS_LIMIT() external returns (uint256) {
+        return 0;
+    }
+
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address,
@@ -37,6 +50,11 @@ contract SameChainAdapter is IBaseAdapter {
         return (envelope.destination, 0);
     }
 
+    /// @inheritdoc IBaseAdapter
+    function adapterName() external view virtual returns (string memory) {
+        return "SameChain adapter";
+    }
+
     /// @inheritdoc IBaseAdapter
     function setupPayments() external {}
 
```
