```diff
diff --git a/etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol b/etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol
index 30cd89b..a1182f7 100644
--- a/etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol
+++ b/etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol
@@ -47,15 +47,24 @@ contract CCIPAdapter is
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param ccipRouter ccip entry point address
+     * @param providerGasLimit base gas limit used by the bridge adapter
      * @param trustedRemotes list of remote configurations to set as trusted
      * @param linkToken address of the erc20 LINK token
      */
     constructor(
         address crossChainController,
         address ccipRouter,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes,
         address linkToken
-    ) BaseAdapter(crossChainController, trustedRemotes) {
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            "CCIP adapter",
+            trustedRemotes
+        )
+    {
         require(ccipRouter != address(0), Errors.CCIP_ROUTER_CANT_BE_ADDRESS_0);
         require(linkToken != address(0), Errors.LINK_TOKEN_CANT_BE_ADDRESS_0);
         CCIP_ROUTER = IRouterClient(ccipRouter);
@@ -74,7 +83,7 @@ contract CCIPAdapter is
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 destinationGasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external returns (address, uint256) {
@@ -87,8 +96,10 @@ contract CCIPAdapter is
         );
         require(receiver != address(0), Errors.RECEIVER_NOT_SET);
 
+        uint256 totalGasLimit = executionGasLimit + BASE_GAS_LIMIT;
+
         Client.EVMExtraArgsV1 memory evmExtraArgs = Client.EVMExtraArgsV1({
-            gasLimit: destinationGasLimit,
+            gasLimit: totalGasLimit,
             strict: false
         });
 
```
