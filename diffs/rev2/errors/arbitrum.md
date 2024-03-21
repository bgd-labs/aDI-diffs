```diff
diff --git a/etherscan/rev2/current/ccc_impl/arbitrum/CrossChainController/src/contracts/libs/Errors.sol b/etherscan/rev2/new/ccc_impl/arbitrum/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol
index ee5b3d2..265a073 100644
--- a/etherscan/rev2/current/ccc_impl/arbitrum/CrossChainController/src/contracts/libs/Errors.sol
+++ b/etherscan/rev2/new/ccc_impl/arbitrum/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol
@@ -41,6 +41,12 @@ library Errors {
     string public constant ADAPTER_PAYMENT_SETUP_FAILED = "32"; // adapter payment setup failed
     string public constant CHAIN_ID_MISMATCH = "33"; // the message delivered to/from wrong network
     string public constant CALLER_NOT_OVM = "34"; // the caller must be the optimism ovm contract
-    string public constant CALLER_NOT_FX_CHILD = "35"; // the caller must be the polygon fx child contract
+    string public constant CALLER_NOT_FX_TUNNEL = "35"; // the caller must be the fx tunnel contract
     string public constant INVALID_SENDER = "36"; // sender can not be address 0
+    string public constant CALLER_NOT_GNOSIS_ARBITRARY_MESSAGE_BRIDGE = "37"; // the caller must be the Gnosis AMB contract
+    string public constant ZERO_GNOSIS_ARBITRARY_MESSAGE_BRIDGE = "38"; // The passed Gnosis AMB contract is zero
+    string public constant CALLER_NOT_ZK_EVM_BRIDGE = "39"; // the caller must be the zk evm bridge
+    string public constant INVALID_HL_MAILBOX = "40"; // the Hyperlane mailbox address can not be 0
+    string public constant WORMHOLE_RELAYER_CANT_BE_ADDRESS_0 = "41"; // Wormhole relayer can not be address 0
+    string public constant CALLER_NOT_WORMHOLE_RELAYER = "42"; // caller must be the Wormhole relayer
 }
```
