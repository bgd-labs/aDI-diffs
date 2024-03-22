```diff
diff --git a/etherscan/rev2/current/adapters/hyperlane/polygon/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol b/etherscan/rev2/new/adapters/hyperlane/polygon/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol
index 5c2ed7c..35fc768 100644
--- a/etherscan/rev2/current/adapters/hyperlane/polygon/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol
+++ b/etherscan/rev2/new/adapters/hyperlane/polygon/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol
@@ -2,11 +2,11 @@
 pragma solidity ^0.8.0;
 
 import {SafeCast} from "openzeppelin-contracts/contracts/utils/math/SafeCast.sol";
-import {IMessageRecipient} from "hyperlane-monorepo/interfaces/IMessageRecipient.sol";
-import {TypeCasts} from "hyperlane-monorepo/libs/TypeCasts.sol";
-
+import {IMessageRecipient} from "./interfaces/IMessageRecipient.sol";
+import {TypeCasts} from "./libs/TypeCasts.sol";
+import {StandardHookMetadata} from "./libs/StandardHookMetadata.sol";
 import {BaseAdapter, IBaseAdapter} from "../BaseAdapter.sol";
-import {IHyperLaneAdapter, IMailbox, IInterchainGasPaymaster} from "./IHyperLaneAdapter.sol";
+import {IHyperLaneAdapter, IMailbox} from "./IHyperLaneAdapter.sol";
 import {Errors} from "../../libs/Errors.sol";
 
 /**
@@ -20,9 +20,6 @@ contract HyperLaneAdapter is BaseAdapter, IHyperLaneAdapter, IMessageRecipient {
     /// @inheritdoc IHyperLaneAdapter
     IMailbox public immutable HL_MAIL_BOX;
 
-    /// @inheritdoc IHyperLaneAdapter
-    IInterchainGasPaymaster public immutable IGP;
-
     /// @notice modifier to check that caller is hyper lane mailBox
     modifier onlyMailbox() {
         require(
@@ -35,23 +32,30 @@ contract HyperLaneAdapter is BaseAdapter, IHyperLaneAdapter, IMessageRecipient {
     /**
      * @param crossChainController address of the cross chain controller that will use this bridge adapter
      * @param mailBox HyperLane router contract address to send / receive cross chain messages
-     * @param igp HyperLane contract to get the gas estimation to pay for sending messages
+     * @param providerGasLimit base gas limit used by the bridge adapter
      * @param trustedRemotes list of remote configurations to set as trusted
      */
     constructor(
         address crossChainController,
         address mailBox,
-        address igp,
+        uint256 providerGasLimit,
         TrustedRemotesConfig[] memory trustedRemotes
-    ) BaseAdapter(crossChainController, trustedRemotes) {
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            "Hyperlane adapter",
+            trustedRemotes
+        )
+    {
+        require(mailBox != address(0), Errors.INVALID_HL_MAILBOX);
         HL_MAIL_BOX = IMailbox(mailBox);
-        IGP = IInterchainGasPaymaster(igp);
     }
 
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 destinationGasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external returns (address, uint256) {
@@ -64,16 +68,16 @@ contract HyperLaneAdapter is BaseAdapter, IHyperLaneAdapter, IMessageRecipient {
         );
         require(receiver != address(0), Errors.RECEIVER_NOT_SET);
 
-        bytes32 messageId = HL_MAIL_BOX.dispatch(
-            nativeChainId,
-            TypeCasts.addressToBytes32(receiver),
-            message
+        bytes memory metadata = StandardHookMetadata.overrideGasLimit(
+            executionGasLimit + BASE_GAS_LIMIT
         );
 
-        // Get the required payment from the IGP.
-        uint256 quotedPayment = IGP.quoteGasPayment(
+        // Get the required payment from the MAILBOX.
+        uint256 quotedPayment = HL_MAIL_BOX.quoteDispatch(
             nativeChainId,
-            destinationGasLimit
+            TypeCasts.addressToBytes32(receiver),
+            message,
+            metadata
         );
 
         require(
@@ -81,12 +85,11 @@ contract HyperLaneAdapter is BaseAdapter, IHyperLaneAdapter, IMessageRecipient {
             Errors.NOT_ENOUGH_VALUE_TO_PAY_BRIDGE_FEES
         );
 
-        // Pay from the contract's balance
-        IGP.payForGas{value: quotedPayment}(
-            messageId, // The ID of the message that was just dispatched
-            nativeChainId, // The destination domain of the message
-            destinationGasLimit,
-            address(this) // refunds go to CrossChainController, who paid the msg.value
+        bytes32 messageId = HL_MAIL_BOX.dispatch{value: quotedPayment}(
+            nativeChainId,
+            TypeCasts.addressToBytes32(receiver),
+            message,
+            metadata
         );
 
         return (address(HL_MAIL_BOX), uint256(messageId));
@@ -97,7 +100,7 @@ contract HyperLaneAdapter is BaseAdapter, IHyperLaneAdapter, IMessageRecipient {
         uint32 _origin,
         bytes32 _sender,
         bytes calldata _messageBody
-    ) external onlyMailbox {
+    ) external payable onlyMailbox {
         address srcAddress = TypeCasts.bytes32ToAddress(_sender);
 
         uint256 originChainId = nativeToInfraChainId(_origin);
```
