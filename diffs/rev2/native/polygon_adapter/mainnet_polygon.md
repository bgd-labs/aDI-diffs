```diff
diff --git a/etherscan/rev2/current/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterEthereum.sol b/etherscan/rev2/new/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterEthereum.sol
index 43bd440..fb11e65 100644
--- a/etherscan/rev2/current/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterEthereum.sol
+++ b/etherscan/rev2/new/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterEthereum.sol
@@ -8,8 +8,16 @@ contract PolygonAdapterEthereum is PolygonAdapterBase {
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
 
     // Overrides to use the Polygon chain id, which is Ethereum's origin
     function getOriginChainId() public pure override returns (uint256) {
```
