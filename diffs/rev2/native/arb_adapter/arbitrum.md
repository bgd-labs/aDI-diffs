```diff
diff --git a/etherscan/rev2/current/adapters/native/arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol b/etherscan/rev2/new/adapters/native/arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol
index dc2438a..1d62bdd 100644
--- a/etherscan/rev2/current/adapters/native/arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol
+++ b/etherscan/rev2/new/adapters/native/arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol
@@ -32,14 +32,23 @@ contract ArbAdapter is IArbAdapter, BaseAdapter {
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param inbox arbitrum entry point address
+     * @param providerGasLimit base gas limit used by the bridge adapter
      * @param trustedRemotes list of remote configurations to set as trusted
      */
     constructor(
         address crossChainController,
         address inbox,
         address destinationCCC,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) BaseAdapter(crossChainController, trustedRemotes) {
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            "Arbitrum native adapter",
+            trustedRemotes
+        )
+    {
         INBOX = inbox;
         DESTINATION_CCC = destinationCCC;
     }
@@ -61,7 +70,7 @@ contract ArbAdapter is IArbAdapter, BaseAdapter {
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 destinationGasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external returns (address, uint256) {
@@ -76,14 +85,16 @@ contract ArbAdapter is IArbAdapter, BaseAdapter {
             message
         );
 
+        uint256 totalGasLimit = executionGasLimit + BASE_GAS_LIMIT;
+
         (uint256 maxSubmission, uint256 maxRedemption) = getRequiredGas(
             data.length,
-            destinationGasLimit
+            totalGasLimit
         );
         uint256 ticketID = _forwardMessage(
             MessageInformation({
                 receiver: receiver,
-                destinationGasLimit: destinationGasLimit,
+                executionGasLimit: totalGasLimit,
                 encodedMessage: data,
                 maxSubmission: maxSubmission,
                 maxRedemption: maxRedemption
@@ -153,7 +164,7 @@ contract ArbAdapter is IArbAdapter, BaseAdapter {
                 message.maxSubmission,
                 DESTINATION_CCC,
                 DESTINATION_CCC,
-                message.destinationGasLimit,
+                message.executionGasLimit,
                 L2_MAX_FEE_PER_GAS,
                 message.encodedMessage
             );
```
