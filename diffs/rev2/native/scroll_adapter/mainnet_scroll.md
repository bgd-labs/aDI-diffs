```diff
diff --git a/etherscan/rev2/current/adapters/native/mainnet_scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol b/etherscan/rev2/new/adapters/native/mainnet_scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol
index 3304710..11817a8 100644
--- a/etherscan/rev2/current/adapters/native/mainnet_scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol
+++ b/etherscan/rev2/new/adapters/native/mainnet_scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol
@@ -22,13 +22,23 @@ contract ScrollAdapter is OpAdapter {
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param ovmCrossDomainMessenger optimism entry point address
+     * @param providerGasLimit base gas limit used by the bridge adapter
      * @param trustedRemotes list of remote configurations to set as trusted
      */
     constructor(
         address crossChainController,
         address ovmCrossDomainMessenger,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) OpAdapter(crossChainController, ovmCrossDomainMessenger, trustedRemotes) {
+    )
+        OpAdapter(
+            crossChainController,
+            ovmCrossDomainMessenger,
+            providerGasLimit,
+            "Scroll native adapter",
+            trustedRemotes
+        )
+    {
         SCROLL_MESSAGE_QUEUE = IL1MessageQueue(
             IScrollMessenger(OVM_CROSS_DOMAIN_MESSENGER).messageQueue()
         );
@@ -37,7 +47,7 @@ contract ScrollAdapter is OpAdapter {
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 gasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external virtual override returns (address, uint256) {
@@ -47,16 +57,18 @@ contract ScrollAdapter is OpAdapter {
         );
         require(receiver != address(0), Errors.RECEIVER_NOT_SET);
 
+        uint256 totalGasLimit = executionGasLimit + BASE_GAS_LIMIT;
+
         // L2 message delivery fee
         uint256 fee = SCROLL_MESSAGE_QUEUE.estimateCrossDomainMessageFee(
-            gasLimit
+            totalGasLimit
         );
 
         IScrollMessenger(OVM_CROSS_DOMAIN_MESSENGER).sendMessage{value: fee}(
             receiver,
             0,
             abi.encodeWithSelector(IOpAdapter.ovmReceive.selector, message),
-            gasLimit
+            totalGasLimit
         );
 
         return (OVM_CROSS_DOMAIN_MESSENGER, 0);
```
