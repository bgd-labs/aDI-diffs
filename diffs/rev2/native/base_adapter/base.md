```diff
diff --git a/etherscan/rev2/current/adapters/native/base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol b/etherscan/rev2/new/adapters/native/base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol
index 05c8ef2..f053b04 100644
--- a/etherscan/rev2/current/adapters/native/base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol
+++ b/etherscan/rev2/new/adapters/native/base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol
@@ -19,14 +19,22 @@ contract CBaseAdapter is OpAdapter {
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
     )
-        OpAdapter(crossChainController, ovmCrossDomainMessenger, trustedRemotes)
+        OpAdapter(
+            crossChainController,
+            ovmCrossDomainMessenger,
+            providerGasLimit,
+            "Base native adapter",
+            trustedRemotes
+        )
     {}
 
     /// @inheritdoc IOpAdapter
```
