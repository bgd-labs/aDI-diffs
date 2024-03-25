```diff
diff --git a/etherscan/rev2/current/adapters/native/mainnet_gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol b/etherscan/rev2/new/adapters/native/mainnet_gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol
index d2a1500..ddf70c9 100644
--- a/etherscan/rev2/current/adapters/native/mainnet_gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol
+++ b/etherscan/rev2/new/adapters/native/mainnet_gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol
@@ -22,13 +22,22 @@ contract GnosisChainAdapter is BaseAdapter, IGnosisChainAdapter {
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param arbitraryMessageBridge The Gnosis AMB contract
+     * @param providerGasLimit base gas limit used by the bridge adapter
      * @param trustedRemotes list of remote configurations to set as trusted
      */
     constructor(
         address crossChainController,
         address arbitraryMessageBridge,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) BaseAdapter(crossChainController, trustedRemotes) {
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            "Gnosis native adapter",
+            trustedRemotes
+        )
+    {
         require(
             arbitraryMessageBridge != address(0),
             Errors.ZERO_GNOSIS_ARBITRARY_MESSAGE_BRIDGE
@@ -39,7 +48,7 @@ contract GnosisChainAdapter is BaseAdapter, IGnosisChainAdapter {
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 gasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external override returns (address, uint256) {
@@ -54,10 +63,12 @@ contract GnosisChainAdapter is BaseAdapter, IGnosisChainAdapter {
             message
         );
 
+        uint256 totalGasLimit = executionGasLimit + BASE_GAS_LIMIT;
+
         IArbitraryMessageBridge(BRIDGE).requireToPassMessage(
             receiver,
             data,
-            gasLimit
+            totalGasLimit
         );
         return (address(BRIDGE), 0);
     }
```
