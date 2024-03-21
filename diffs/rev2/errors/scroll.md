```diff
diff --git a/etherscan/rev2/current/ccc_impl/scroll/CrossChainController/src/contracts/libs/Errors.sol b/etherscan/rev2/new/ccc_impl/scroll/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol
index 58ef202..265a073 100644
--- a/etherscan/rev2/current/ccc_impl/scroll/CrossChainController/src/contracts/libs/Errors.sol
+++ b/etherscan/rev2/new/ccc_impl/scroll/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol
@@ -46,4 +46,7 @@ library Errors {
     string public constant CALLER_NOT_GNOSIS_ARBITRARY_MESSAGE_BRIDGE = "37"; // the caller must be the Gnosis AMB contract
     string public constant ZERO_GNOSIS_ARBITRARY_MESSAGE_BRIDGE = "38"; // The passed Gnosis AMB contract is zero
     string public constant CALLER_NOT_ZK_EVM_BRIDGE = "39"; // the caller must be the zk evm bridge
+    string public constant INVALID_HL_MAILBOX = "40"; // the Hyperlane mailbox address can not be 0
+    string public constant WORMHOLE_RELAYER_CANT_BE_ADDRESS_0 = "41"; // Wormhole relayer can not be address 0
+    string public constant CALLER_NOT_WORMHOLE_RELAYER = "42"; // caller must be the Wormhole relayer
 }
```
