```diff
diff --git a/etherscan/rev2/current/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol b/etherscan/rev2/new/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol
index 032fb42..80c2bc6 100644
--- a/etherscan/rev2/current/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol
+++ b/etherscan/rev2/new/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 
+import {IBaseCrossChainController} from "../interfaces/IBaseCrossChainController.sol";
+
 /**
  * @title IBaseAdapter
  * @author BGD Labs
@@ -27,19 +29,38 @@ interface IBaseAdapter {
     /**
    * @notice method that will bridge the payload to the chain specified
    * @param receiver address of the receiver contract on destination chain
-   * @param gasLimit amount of the gas limit in wei to use for bridging on receiver side. Each adapter will manage this
-            as needed
+   * @param executionGasLimit amount of the gas limit in wei to use for delivering the message on destination network.
+            Each adapter will manage this as needed.
    * @param destinationChainId id of the destination chain in the bridge notation
    * @param message to send to the specified chain
    * @return the third-party bridge entrypoint, the third-party bridge message id
    */
     function forwardMessage(
         address receiver,
-        uint256 gasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external returns (address, uint256);
 
+    /**
+     * @notice method to get the address of the linked cross chain controller
+     * @return address of CrossChainController
+     */
+    function CROSS_CHAIN_CONTROLLER()
+        external
+        returns (IBaseCrossChainController);
+
+    /**
+     * @notice method to get the name of the adapter contract
+     * @return name of the adapter contract
+     */
+    function adapterName() external view returns (string memory);
+
+    /**
+     * @notice method to get the base gas limit used by the bridge adapter
+     */
+    function BASE_GAS_LIMIT() external returns (uint256);
+
     /**
      * @notice method used to setup payment, ie grant approvals over tokens used to pay for tx fees
      */
```
