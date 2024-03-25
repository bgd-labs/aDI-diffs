```diff
diff --git a/etherscan/rev2/current/adapters/native/optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol b/etherscan/rev2/new/adapters/native/optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol
index c52de9d..b1f588c 100644
--- a/etherscan/rev2/current/adapters/native/optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol
+++ b/etherscan/rev2/new/adapters/native/optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol
@@ -34,20 +34,31 @@ contract OpAdapter is IOpAdapter, BaseAdapter {
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param ovmCrossDomainMessenger optimism entry point address
+     * @param providerGasLimit base gas limit used by the bridge adapter
+     * @param adapterName string indicating the adapter name
      * @param trustedRemotes list of remote configurations to set as trusted
      */
     constructor(
         address crossChainController,
         address ovmCrossDomainMessenger,
+        uint256 providerGasLimit,
+        string memory adapterName,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) BaseAdapter(crossChainController, trustedRemotes) {
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            adapterName,
+            trustedRemotes
+        )
+    {
         OVM_CROSS_DOMAIN_MESSENGER = ovmCrossDomainMessenger;
     }
 
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 destinationGasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external virtual returns (address, uint256) {
@@ -57,10 +68,12 @@ contract OpAdapter is IOpAdapter, BaseAdapter {
         );
         require(receiver != address(0), Errors.RECEIVER_NOT_SET);
 
+        uint256 totalGasLimit = executionGasLimit + BASE_GAS_LIMIT;
+
         ICrossDomainMessenger(OVM_CROSS_DOMAIN_MESSENGER).sendMessage(
             receiver,
             abi.encodeWithSelector(IOpAdapter.ovmReceive.selector, message),
-            SafeCast.toUint32(destinationGasLimit) // for now gas fees are paid on optimism ( < 1.9) and metis (<5M) but its subject to change
+            SafeCast.toUint32(totalGasLimit) // for now gas fees are paid on optimism ( < 1.9) and metis (<5M) but its subject to change
         );
 
         return (OVM_CROSS_DOMAIN_MESSENGER, 0);
```
