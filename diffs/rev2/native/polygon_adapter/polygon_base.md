```diff
diff --git a/etherscan/rev2/current/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterBase.sol b/etherscan/rev2/new/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterBase.sol
index 43cb042..4b59936 100644
--- a/etherscan/rev2/current/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterBase.sol
+++ b/etherscan/rev2/new/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterBase.sol
@@ -30,13 +30,22 @@ abstract contract PolygonAdapterBase is
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param fxTunnel address of the fx tunnel that will be used to send/receive messages to the root/child chain
+     * @param providerGasLimit base gas limit used by the bridge adapter
      * @param trustedRemotes list of remote configurations to set as trusted
      */
     constructor(
         address crossChainController,
         address fxTunnel,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) BaseAdapter(crossChainController, trustedRemotes) {
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            "Polygon native adapter",
+            trustedRemotes
+        )
+    {
         FX_TUNNEL = fxTunnel;
     }
 
```
