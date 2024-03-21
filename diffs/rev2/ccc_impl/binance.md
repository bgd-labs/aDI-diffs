```diff
diff --git a/etherscan/rev2/current/ccc_impl/binance/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainReceiver.sol b/etherscan/rev2/new/ccc_impl/binance/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/CrossChainReceiver.sol
index 9e0d441..5c6b415 100644
--- a/etherscan/rev2/current/ccc_impl/binance/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainReceiver.sol
+++ b/etherscan/rev2/new/ccc_impl/binance/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/CrossChainReceiver.sol
@@ -176,10 +176,9 @@ contract CrossChainReceiver is OwnableWithGuardian, ICrossChainReceiver {
             Errors.CHAIN_ID_MISMATCH
         );
         bytes32 envelopeId = transaction.getEnvelopeId();
-        // if envelope was confirmed before, just return
-        if (_envelopesState[envelopeId] != EnvelopeState.None) return;
 
         bytes32 transactionId = TransactionUtils.getId(encodedTransaction);
+
         TransactionState storage internalTransaction = _transactionsState[
             transactionId
         ];
@@ -213,9 +212,12 @@ contract CrossChainReceiver is OwnableWithGuardian, ICrossChainReceiver {
                 msg.sender,
                 newConfirmations
             );
-
-            // checks that the message was not delivered before, so it will not try to deliver again when message arrives
+            // Checks that the message was not confirmed and/or delivered before, so it will not try to deliver again when message arrives
             // from additional bridges after reaching required number of confirmations
+            if (_envelopesState[envelopeId] != EnvelopeState.None) {
+                return;
+            }
+
             // >= is used for the case when confirmations gets lowered before message reached the old _requiredConfirmations
             // but on receiving new messages it surpasses the current _requiredConfirmations. So it doesn't get stuck (if using ==)
             if (
```
