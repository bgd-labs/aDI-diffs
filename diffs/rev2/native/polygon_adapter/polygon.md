```diff
diff --git a/etherscan/rev2/current/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterPolygon.sol b/etherscan/rev2/new/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterPolygon.sol
index 8c305d5..9c9d171 100644
--- a/etherscan/rev2/current/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterPolygon.sol
+++ b/etherscan/rev2/new/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterPolygon.sol
@@ -8,8 +8,16 @@ contract PolygonAdapterPolygon is PolygonAdapterBase {
     constructor(
         address crossChainController,
         address fxTunnel,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) PolygonAdapterBase(crossChainController, fxTunnel, trustedRemotes) {}
+    )
+        PolygonAdapterBase(
+            crossChainController,
+            fxTunnel,
+            providerGasLimit,
+            trustedRemotes
+        )
+    {}
 
     // Overrides to use Ethereum chain id, which is Polygon's origin
     function getOriginChainId() public pure override returns (uint256) {
```
