```diff
diff --git a/flattened/rev2/ccc_impl/current/optimism/CrossChainController.sol b/flattened/rev2/ccc_impl/new/optimism/CrossChainController.sol
index 456ef29..b840432 100644
--- a/flattened/rev2/ccc_impl/current/optimism/CrossChainController.sol
+++ b/flattened/rev2/ccc_impl/new/optimism/CrossChainController.sol
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity >=0.7.0 ^0.8.0 ^0.8.1 ^0.8.2 ^0.8.8;
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol
 
-// OpenZeppelin Contracts (last updated v4.8.0) (utils/structs/EnumerableSet.sol)
+// OpenZeppelin Contracts (last updated v4.9.0) (utils/structs/EnumerableSet.sol)
 // This file was procedurally generated from scripts/generate/templates/EnumerableSet.js.
 
 /**
@@ -17,7 +17,7 @@ pragma solidity >=0.7.0 ^0.8.0 ^0.8.1 ^0.8.2 ^0.8.8;
  * (O(1)).
  * - Elements are enumerated in O(n). No guarantees are made on the ordering.
  *
- * ```
+ * ```solidity
  * contract Example {
  *     // Add the library methods
  *     using EnumerableSet for EnumerableSet.AddressSet;
@@ -424,7 +424,7 @@ library EnumerableSet {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/access-control/interfaces/IWithGuardian.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/access-control/interfaces/IWithGuardian.sol
 
 interface IWithGuardian {
     /**
@@ -446,7 +446,7 @@ interface IWithGuardian {
     function updateGuardian(address newGuardian) external;
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/oz-common/Address.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/oz-common/Address.sol
 
 // OpenZeppelin Contracts (last updated v4.7.0) (utils/Address.sol)
 // From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
@@ -754,7 +754,7 @@ library Address {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/oz-common/Context.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/oz-common/Context.sol
 
 // OpenZeppelin Contracts v4.4.1 (utils/Context.sol)
 // From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
@@ -779,7 +779,7 @@ abstract contract Context {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol
 
 // OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)
 // From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/a035b235b4f2c9af4ba88edc4447f02e37f8d124
@@ -869,7 +869,7 @@ interface IERC20 {
     ) external returns (bool);
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20Permit.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20Permit.sol
 
 // OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/extensions/IERC20Permit.sol)
 // Modified from https://github.com/OpenZeppelin/openzeppelin-contracts/commit/00cbf5a236564c3b7aacdad1f378cae22d890ca6
@@ -930,7 +930,7 @@ interface IERC20Permit {
     function DOMAIN_SEPARATOR() external view returns (bytes32);
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/utils/interfaces/IRescuable.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/utils/interfaces/IRescuable.sol
 
 /**
  * @title IRescuable
@@ -990,79 +990,7 @@ interface IRescuable {
     function whoCanRescue() external view returns (address);
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/adapters/IBaseAdapter.sol
-
-/**
- * @title IBaseAdapter
- * @author BGD Labs
- * @notice interface containing the event and method used in all bridge adapters
- */
-interface IBaseAdapter {
-    /**
-     * @notice emitted when a trusted remote is set
-     * @param originChainId id of the chain where the trusted remote is from
-     * @param originForwarder address of the contract that will send the messages
-     */
-    event SetTrustedRemote(uint256 originChainId, address originForwarder);
-
-    /**
-     * @notice pair of origin address and origin chain
-     * @param originForwarder address of the contract that will send the messages
-     * @param originChainId id of the chain where the trusted remote is from
-     */
-    struct TrustedRemotesConfig {
-        address originForwarder;
-        uint256 originChainId;
-    }
-
-    /**
-   * @notice method that will bridge the payload to the chain specified
-   * @param receiver address of the receiver contract on destination chain
-   * @param gasLimit amount of the gas limit in wei to use for bridging on receiver side. Each adapter will manage this
-            as needed
-   * @param destinationChainId id of the destination chain in the bridge notation
-   * @param message to send to the specified chain
-   * @return the third-party bridge entrypoint, the third-party bridge message id
-   */
-    function forwardMessage(
-        address receiver,
-        uint256 gasLimit,
-        uint256 destinationChainId,
-        bytes calldata message
-    ) external returns (address, uint256);
-
-    /**
-     * @notice method used to setup payment, ie grant approvals over tokens used to pay for tx fees
-     */
-    function setupPayments() external;
-
-    /**
-     * @notice method to get the trusted remote address from a specified chain id
-     * @param chainId id of the chain from where to get the trusted remote
-     * @return address of the trusted remote
-     */
-    function getTrustedRemoteByChainId(
-        uint256 chainId
-    ) external view returns (address);
-
-    /**
-     * @notice method to get infrastructure chain id from bridge native chain id
-     * @param bridgeChainId bridge native chain id
-     */
-    function nativeToInfraChainId(
-        uint256 bridgeChainId
-    ) external returns (uint256);
-
-    /**
-     * @notice method to get bridge native chain id from native bridge chain id
-     * @param infraChainId infrastructure chain id
-     */
-    function infraToNativeChainId(
-        uint256 infraChainId
-    ) external returns (uint256);
-}
-
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/interfaces/IBaseReceiverPortal.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/interfaces/IBaseReceiverPortal.sol
 
 /**
  * @title IBaseReceiverPortal
@@ -1084,7 +1012,7 @@ interface IBaseReceiverPortal {
     ) external;
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/libs/EncodingUtils.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/libs/EncodingUtils.sol
 
 using EnvelopeUtils for Envelope global;
 using TransactionUtils for Transaction global;
@@ -1263,7 +1191,7 @@ library TransactionUtils {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/libs/Errors.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol
 
 /**
  * @title Errors library
@@ -1305,11 +1233,31 @@ library Errors {
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
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/oz-common/Ownable.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/IReinitialize.sol
+
+/**
+ * @title IReinitialize
+ * @author BGD Labs
+ * @notice interface containing re initialization method
+ */
+interface IReinitialize {
+    /**
+     * @notice method called to re initialize the proxy
+     */
+    function initializeRevision() external;
+}
+
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/oz-common/Ownable.sol
 
 // OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)
 // From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
@@ -1397,7 +1345,7 @@ abstract contract Ownable is Context {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/transparent-proxy/Initializable.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/transparent-proxy/Initializable.sol
 
 /**
  * @dev OpenZeppelin Contracts (last updated v4.7.0) (proxy/utils/Initializable.sol)
@@ -1551,7 +1499,7 @@ abstract contract Initializable {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/interfaces/ICrossChainForwarder.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/interfaces/ICrossChainForwarder.sol
 
 /**
  * @title ICrossChainForwarder
@@ -1779,7 +1727,7 @@ interface ICrossChainForwarder {
     function isSenderApproved(address sender) external view returns (bool);
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/interfaces/ICrossChainReceiver.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/interfaces/ICrossChainReceiver.sol
 
 /**
  * @title ICrossChainReceiver
@@ -2058,7 +2006,7 @@ interface ICrossChainReceiver {
     ) external;
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/access-control/OwnableWithGuardian.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/access-control/OwnableWithGuardian.sol
 
 abstract contract OwnableWithGuardian is Ownable, IWithGuardian {
     address private _guardian;
@@ -2110,7 +2058,7 @@ abstract contract OwnableWithGuardian is Ownable, IWithGuardian {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/oz-common/SafeERC20.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/oz-common/SafeERC20.sol
 
 // OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/utils/SafeERC20.sol)
 // Modified From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/00cbf5a236564c3b7aacdad1f378cae22d890ca6
@@ -2287,7 +2235,7 @@ library SafeERC20 {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/lib/solidity-utils/src/contracts/utils/Rescuable.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/lib/solidity-utils/src/contracts/utils/Rescuable.sol
 
 /**
  * @title Rescuable
@@ -2329,7 +2277,7 @@ abstract contract Rescuable is IRescuable {
     function whoCanRescue() public view virtual returns (address);
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/interfaces/IBaseCrossChainController.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/interfaces/IBaseCrossChainController.sol
 
 /**
  * @title IBaseCrossChainController
@@ -2344,7 +2292,98 @@ interface IBaseCrossChainController is
 
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/interfaces/ICrossChainController.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/adapters/IBaseAdapter.sol
+
+/**
+ * @title IBaseAdapter
+ * @author BGD Labs
+ * @notice interface containing the event and method used in all bridge adapters
+ */
+interface IBaseAdapter {
+    /**
+     * @notice emitted when a trusted remote is set
+     * @param originChainId id of the chain where the trusted remote is from
+     * @param originForwarder address of the contract that will send the messages
+     */
+    event SetTrustedRemote(uint256 originChainId, address originForwarder);
+
+    /**
+     * @notice pair of origin address and origin chain
+     * @param originForwarder address of the contract that will send the messages
+     * @param originChainId id of the chain where the trusted remote is from
+     */
+    struct TrustedRemotesConfig {
+        address originForwarder;
+        uint256 originChainId;
+    }
+
+    /**
+   * @notice method that will bridge the payload to the chain specified
+   * @param receiver address of the receiver contract on destination chain
+   * @param executionGasLimit amount of the gas limit in wei to use for delivering the message on destination network.
+            Each adapter will manage this as needed.
+   * @param destinationChainId id of the destination chain in the bridge notation
+   * @param message to send to the specified chain
+   * @return the third-party bridge entrypoint, the third-party bridge message id
+   */
+    function forwardMessage(
+        address receiver,
+        uint256 executionGasLimit,
+        uint256 destinationChainId,
+        bytes calldata message
+    ) external returns (address, uint256);
+
+    /**
+     * @notice method to get the address of the linked cross chain controller
+     * @return address of CrossChainController
+     */
+    function CROSS_CHAIN_CONTROLLER()
+        external
+        returns (IBaseCrossChainController);
+
+    /**
+     * @notice method to get the name of the adapter contract
+     * @return name of the adapter contract
+     */
+    function adapterName() external view returns (string memory);
+
+    /**
+     * @notice method to get the base gas limit used by the bridge adapter
+     */
+    function BASE_GAS_LIMIT() external returns (uint256);
+
+    /**
+     * @notice method used to setup payment, ie grant approvals over tokens used to pay for tx fees
+     */
+    function setupPayments() external;
+
+    /**
+     * @notice method to get the trusted remote address from a specified chain id
+     * @param chainId id of the chain from where to get the trusted remote
+     * @return address of the trusted remote
+     */
+    function getTrustedRemoteByChainId(
+        uint256 chainId
+    ) external view returns (address);
+
+    /**
+     * @notice method to get infrastructure chain id from bridge native chain id
+     * @param bridgeChainId bridge native chain id
+     */
+    function nativeToInfraChainId(
+        uint256 bridgeChainId
+    ) external returns (uint256);
+
+    /**
+     * @notice method to get bridge native chain id from native bridge chain id
+     * @param infraChainId infrastructure chain id
+     */
+    function infraToNativeChainId(
+        uint256 infraChainId
+    ) external returns (uint256);
+}
+
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/interfaces/ICrossChainController.sol
 
 /**
  * @title ICrossChainController
@@ -2372,7 +2411,376 @@ interface ICrossChainController is IBaseCrossChainController {
     ) external;
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/CrossChainForwarder.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/CrossChainReceiver.sol
+
+/**
+ * @title CrossChainReceiver
+ * @author BGD Labs
+ * @notice this contract contains the methods to get bridged messages and route them to their respective recipients.
+ * @dev to route a message, this one needs to be bridged correctly n number of confirmations.
+ * @dev if at some point, it is detected that some bridge has been hacked, there is a possibility to invalidate
+ *      messages by calling updateMessagesValidityTimestamp
+ */
+contract CrossChainReceiver is OwnableWithGuardian, ICrossChainReceiver {
+    using EnumerableSet for EnumerableSet.AddressSet;
+    using EnumerableSet for EnumerableSet.UintSet;
+
+    // chainId => configuration
+    mapping(uint256 => ReceiverConfigurationFull)
+        internal _configurationsByChain;
+
+    // stores hash(Transaction) => bridged transaction information and state
+    mapping(bytes32 => TransactionState) internal _transactionsState;
+
+    // stores hash(Envelope) => received envelope state
+    mapping(bytes32 => EnvelopeState) internal _envelopesState;
+
+    // stores the currently supported chains (chains that have at least 1 bridge adapter)
+    EnumerableSet.UintSet internal _supportedChains;
+
+    // storage gap allocation to be used for later updates. This way storage can be added on parent contract without
+    // overwriting storage on child
+    uint256[50] private __RECEIVER_GAP;
+
+    // checks if caller is one of the approved bridge adapters
+    modifier onlyApprovedBridges(uint256 chainId) {
+        require(
+            isReceiverBridgeAdapterAllowed(msg.sender, chainId),
+            Errors.CALLER_NOT_APPROVED_BRIDGE
+        );
+        _;
+    }
+
+    /**
+   * @param initialRequiredConfirmations number of confirmations the messages need to be accepted as valid
+   * @param bridgeAdaptersToAllow array of objects containing the chain and address of the bridge adapters that
+            can receive messages
+   */
+    constructor(
+        ConfirmationInput[] memory initialRequiredConfirmations,
+        ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersToAllow
+    ) {
+        _configureReceiverBasics(
+            bridgeAdaptersToAllow,
+            new ReceiverBridgeAdapterConfigInput[](0),
+            initialRequiredConfirmations
+        );
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getReceiverBridgeAdaptersByChain(
+        uint256 chainId
+    ) public view returns (address[] memory) {
+        return _configurationsByChain[chainId].allowedBridgeAdapters.values();
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getSupportedChains() external view returns (uint256[] memory) {
+        return _supportedChains.values();
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getConfigurationByChain(
+        uint256 chainId
+    ) external view returns (ReceiverConfiguration memory) {
+        return _configurationsByChain[chainId].configuration;
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function isReceiverBridgeAdapterAllowed(
+        address bridgeAdapter,
+        uint256 chainId
+    ) public view returns (bool) {
+        return
+            _configurationsByChain[chainId].allowedBridgeAdapters.contains(
+                bridgeAdapter
+            );
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getTransactionState(
+        bytes32 transactionId
+    ) public view returns (TransactionStateWithoutAdapters memory) {
+        return
+            TransactionStateWithoutAdapters({
+                confirmations: _transactionsState[transactionId].confirmations,
+                firstBridgedAt: _transactionsState[transactionId].firstBridgedAt
+            });
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getTransactionState(
+        Transaction memory transaction
+    ) external view returns (TransactionStateWithoutAdapters memory) {
+        return getTransactionState(transaction.getId());
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getEnvelopeState(
+        Envelope memory envelope
+    ) external view returns (EnvelopeState) {
+        return getEnvelopeState(envelope.getId());
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function getEnvelopeState(
+        bytes32 envelopeId
+    ) public view returns (EnvelopeState) {
+        return _envelopesState[envelopeId];
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function isTransactionReceivedByAdapter(
+        bytes32 transactionId,
+        address bridgeAdapter
+    ) external view returns (bool) {
+        return
+            _transactionsState[transactionId].bridgedByAdapter[bridgeAdapter];
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function updateConfirmations(
+        ConfirmationInput[] memory newConfirmations
+    ) external onlyOwner {
+        _updateConfirmations(newConfirmations);
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function updateMessagesValidityTimestamp(
+        ValidityTimestampInput[] memory newValidityTimestamp
+    ) external onlyOwner {
+        _updateMessagesValidityTimestamp(newValidityTimestamp);
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function allowReceiverBridgeAdapters(
+        ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersInput
+    ) external onlyOwner {
+        _updateReceiverBridgeAdapters(bridgeAdaptersInput, true);
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function disallowReceiverBridgeAdapters(
+        ReceiverBridgeAdapterConfigInput[] memory bridgeAdapters
+    ) external onlyOwner {
+        _updateReceiverBridgeAdapters(bridgeAdapters, false);
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function receiveCrossChainMessage(
+        bytes memory encodedTransaction,
+        uint256 originChainId
+    ) external onlyApprovedBridges(originChainId) {
+        Transaction memory transaction = TransactionUtils.decode(
+            encodedTransaction
+        );
+        Envelope memory envelope = transaction.getEnvelope();
+        require(
+            envelope.originChainId == originChainId &&
+                envelope.destinationChainId == block.chainid,
+            Errors.CHAIN_ID_MISMATCH
+        );
+        bytes32 envelopeId = transaction.getEnvelopeId();
+
+        bytes32 transactionId = TransactionUtils.getId(encodedTransaction);
+
+        TransactionState storage internalTransaction = _transactionsState[
+            transactionId
+        ];
+        ReceiverConfiguration memory configuration = _configurationsByChain[
+            originChainId
+        ].configuration;
+
+        // If bridged at is > invalidation, it means that the first time transaction was received after last invalidation and
+        // can be processed.
+        // 0 here means that it’s received for a first time, so invalidation does not matter for this message.
+        // Also checks that bridge adapter didn’t bridge this transaction already.
+        // Dont let messages pass if required confirmations are 0. Meaning that they have not been configured
+        uint120 transactionFirstBridgedAt = internalTransaction.firstBridgedAt;
+        if (
+            transactionFirstBridgedAt == 0 ||
+            (!internalTransaction.bridgedByAdapter[msg.sender] &&
+                transactionFirstBridgedAt > configuration.validityTimestamp)
+        ) {
+            if (transactionFirstBridgedAt == 0) {
+                internalTransaction.firstBridgedAt = uint120(block.timestamp);
+            }
+
+            uint8 newConfirmations = ++internalTransaction.confirmations;
+            internalTransaction.bridgedByAdapter[msg.sender] = true;
+
+            emit TransactionReceived(
+                transactionId,
+                envelopeId,
+                originChainId,
+                transaction,
+                msg.sender,
+                newConfirmations
+            );
+            // Checks that the message was not confirmed and/or delivered before, so it will not try to deliver again when message arrives
+            // from additional bridges after reaching required number of confirmations
+            if (_envelopesState[envelopeId] != EnvelopeState.None) {
+                return;
+            }
+
+            // >= is used for the case when confirmations gets lowered before message reached the old _requiredConfirmations
+            // but on receiving new messages it surpasses the current _requiredConfirmations. So it doesn't get stuck (if using ==)
+            if (
+                configuration.requiredConfirmation > 0 &&
+                newConfirmations >= configuration.requiredConfirmation
+            ) {
+                _envelopesState[envelopeId] = EnvelopeState.Delivered;
+                try
+                    IBaseReceiverPortal(envelope.destination)
+                        .receiveCrossChainMessage(
+                            envelope.origin,
+                            envelope.originChainId,
+                            envelope.message
+                        )
+                {
+                    emit EnvelopeDeliveryAttempted(envelopeId, envelope, true);
+                } catch (bytes memory) {
+                    _envelopesState[envelopeId] = EnvelopeState.Confirmed;
+                    emit EnvelopeDeliveryAttempted(envelopeId, envelope, false);
+                }
+            }
+        }
+    }
+
+    /// @inheritdoc ICrossChainReceiver
+    function deliverEnvelope(Envelope memory envelope) external {
+        bytes32 envelopeId = envelope.getId();
+        require(
+            _envelopesState[envelopeId] == EnvelopeState.Confirmed,
+            Errors.ENVELOPE_NOT_CONFIRMED_OR_DELIVERED
+        );
+
+        _envelopesState[envelopeId] = EnvelopeState.Delivered;
+        IBaseReceiverPortal(envelope.destination).receiveCrossChainMessage(
+            envelope.origin,
+            envelope.originChainId,
+            envelope.message
+        );
+        emit EnvelopeDeliveryAttempted(envelopeId, envelope, true);
+    }
+
+    /**
+   * @notice method to set a new timestamp from where the messages will be valid.
+   * @param newValidityTimestampsInput array of objects containing the chain and timestamp where all the previous unconfirmed
+            messages must be invalidated.
+   */
+    function _updateMessagesValidityTimestamp(
+        ValidityTimestampInput[] memory newValidityTimestampsInput
+    ) internal {
+        for (uint256 i; i < newValidityTimestampsInput.length; i++) {
+            ValidityTimestampInput memory input = newValidityTimestampsInput[i];
+            require(
+                input.validityTimestamp >
+                    _configurationsByChain[input.chainId]
+                        .configuration
+                        .validityTimestamp &&
+                    input.validityTimestamp <= block.timestamp,
+                Errors.INVALID_VALIDITY_TIMESTAMP
+            );
+            _configurationsByChain[input.chainId]
+                .configuration
+                .validityTimestamp = input.validityTimestamp;
+
+            emit NewInvalidation(input.validityTimestamp, input.chainId);
+        }
+    }
+
+    /**
+     * @notice method to update the number of confirmations necessary for the messages to be accepted as valid
+     * @param newConfirmations array of objects with the chainId and the new number of needed confirmations
+     */
+    function _updateConfirmations(
+        ConfirmationInput[] memory newConfirmations
+    ) internal {
+        for (uint256 i; i < newConfirmations.length; i++) {
+            ConfirmationInput memory confirmations = newConfirmations[i];
+            require(
+                confirmations.requiredConfirmations > 0 &&
+                    confirmations.requiredConfirmations <=
+                    _configurationsByChain[confirmations.chainId]
+                        .allowedBridgeAdapters
+                        .length(),
+                Errors.INVALID_REQUIRED_CONFIRMATIONS
+            );
+            _configurationsByChain[confirmations.chainId]
+                .configuration
+                .requiredConfirmation = confirmations.requiredConfirmations;
+            emit ConfirmationsUpdated(
+                confirmations.requiredConfirmations,
+                confirmations.chainId
+            );
+        }
+    }
+
+    /**
+     * @notice method to add bridge adapters to the allowed list
+     * @param bridgeAdaptersInput array of objects with the new bridge adapters and supported chains
+     */
+    function _updateReceiverBridgeAdapters(
+        ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersInput,
+        bool isAllowed
+    ) internal {
+        for (uint256 i = 0; i < bridgeAdaptersInput.length; i++) {
+            ReceiverBridgeAdapterConfigInput memory input = bridgeAdaptersInput[
+                i
+            ];
+            require(
+                input.bridgeAdapter != address(0),
+                Errors.INVALID_BRIDGE_ADAPTER
+            );
+
+            for (uint256 j; j < input.chainIds.length; j++) {
+                bool actionProcessed;
+                if (isAllowed) {
+                    _supportedChains.add(input.chainIds[j]);
+                    actionProcessed = _configurationsByChain[input.chainIds[j]]
+                        .allowedBridgeAdapters
+                        .add(input.bridgeAdapter);
+                } else {
+                    actionProcessed = _configurationsByChain[input.chainIds[j]]
+                        .allowedBridgeAdapters
+                        .remove(input.bridgeAdapter);
+                    if (
+                        actionProcessed &&
+                        _configurationsByChain[input.chainIds[j]]
+                            .allowedBridgeAdapters
+                            .length() ==
+                        0
+                    ) {
+                        _supportedChains.remove(input.chainIds[j]);
+                    }
+                }
+                if (actionProcessed) {
+                    emit ReceiverBridgeAdaptersUpdated(
+                        input.bridgeAdapter,
+                        isAllowed,
+                        input.chainIds[j]
+                    );
+                }
+            }
+        }
+    }
+
+    /// @dev utility function, defining an order of actions commonly done in batch
+    function _configureReceiverBasics(
+        ReceiverBridgeAdapterConfigInput[] memory bridgesToEnable,
+        ReceiverBridgeAdapterConfigInput[] memory bridgesToDisable,
+        ConfirmationInput[] memory newConfirmations
+    ) internal {
+        // IMPORTANT. Confirmations update should always happen after adapters, to not create a situation of
+        // blockage in the system
+        _updateReceiverBridgeAdapters(bridgesToEnable, true);
+        _updateReceiverBridgeAdapters(bridgesToDisable, false);
+        _updateConfirmations(newConfirmations);
+    }
+}
+
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/CrossChainForwarder.sol
 
 /**
  * @title CrossChainForwarder
@@ -2872,374 +3280,7 @@ contract CrossChainForwarder is OwnableWithGuardian, ICrossChainForwarder {
     }
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/CrossChainReceiver.sol
-
-/**
- * @title CrossChainReceiver
- * @author BGD Labs
- * @notice this contract contains the methods to get bridged messages and route them to their respective recipients.
- * @dev to route a message, this one needs to be bridged correctly n number of confirmations.
- * @dev if at some point, it is detected that some bridge has been hacked, there is a possibility to invalidate
- *      messages by calling updateMessagesValidityTimestamp
- */
-contract CrossChainReceiver is OwnableWithGuardian, ICrossChainReceiver {
-    using EnumerableSet for EnumerableSet.AddressSet;
-    using EnumerableSet for EnumerableSet.UintSet;
-
-    // chainId => configuration
-    mapping(uint256 => ReceiverConfigurationFull)
-        internal _configurationsByChain;
-
-    // stores hash(Transaction) => bridged transaction information and state
-    mapping(bytes32 => TransactionState) internal _transactionsState;
-
-    // stores hash(Envelope) => received envelope state
-    mapping(bytes32 => EnvelopeState) internal _envelopesState;
-
-    // stores the currently supported chains (chains that have at least 1 bridge adapter)
-    EnumerableSet.UintSet internal _supportedChains;
-
-    // storage gap allocation to be used for later updates. This way storage can be added on parent contract without
-    // overwriting storage on child
-    uint256[50] private __RECEIVER_GAP;
-
-    // checks if caller is one of the approved bridge adapters
-    modifier onlyApprovedBridges(uint256 chainId) {
-        require(
-            isReceiverBridgeAdapterAllowed(msg.sender, chainId),
-            Errors.CALLER_NOT_APPROVED_BRIDGE
-        );
-        _;
-    }
-
-    /**
-   * @param initialRequiredConfirmations number of confirmations the messages need to be accepted as valid
-   * @param bridgeAdaptersToAllow array of objects containing the chain and address of the bridge adapters that
-            can receive messages
-   */
-    constructor(
-        ConfirmationInput[] memory initialRequiredConfirmations,
-        ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersToAllow
-    ) {
-        _configureReceiverBasics(
-            bridgeAdaptersToAllow,
-            new ReceiverBridgeAdapterConfigInput[](0),
-            initialRequiredConfirmations
-        );
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getReceiverBridgeAdaptersByChain(
-        uint256 chainId
-    ) public view returns (address[] memory) {
-        return _configurationsByChain[chainId].allowedBridgeAdapters.values();
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getSupportedChains() external view returns (uint256[] memory) {
-        return _supportedChains.values();
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getConfigurationByChain(
-        uint256 chainId
-    ) external view returns (ReceiverConfiguration memory) {
-        return _configurationsByChain[chainId].configuration;
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function isReceiverBridgeAdapterAllowed(
-        address bridgeAdapter,
-        uint256 chainId
-    ) public view returns (bool) {
-        return
-            _configurationsByChain[chainId].allowedBridgeAdapters.contains(
-                bridgeAdapter
-            );
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getTransactionState(
-        bytes32 transactionId
-    ) public view returns (TransactionStateWithoutAdapters memory) {
-        return
-            TransactionStateWithoutAdapters({
-                confirmations: _transactionsState[transactionId].confirmations,
-                firstBridgedAt: _transactionsState[transactionId].firstBridgedAt
-            });
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getTransactionState(
-        Transaction memory transaction
-    ) external view returns (TransactionStateWithoutAdapters memory) {
-        return getTransactionState(transaction.getId());
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getEnvelopeState(
-        Envelope memory envelope
-    ) external view returns (EnvelopeState) {
-        return getEnvelopeState(envelope.getId());
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function getEnvelopeState(
-        bytes32 envelopeId
-    ) public view returns (EnvelopeState) {
-        return _envelopesState[envelopeId];
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function isTransactionReceivedByAdapter(
-        bytes32 transactionId,
-        address bridgeAdapter
-    ) external view returns (bool) {
-        return
-            _transactionsState[transactionId].bridgedByAdapter[bridgeAdapter];
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function updateConfirmations(
-        ConfirmationInput[] memory newConfirmations
-    ) external onlyOwner {
-        _updateConfirmations(newConfirmations);
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function updateMessagesValidityTimestamp(
-        ValidityTimestampInput[] memory newValidityTimestamp
-    ) external onlyOwner {
-        _updateMessagesValidityTimestamp(newValidityTimestamp);
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function allowReceiverBridgeAdapters(
-        ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersInput
-    ) external onlyOwner {
-        _updateReceiverBridgeAdapters(bridgeAdaptersInput, true);
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function disallowReceiverBridgeAdapters(
-        ReceiverBridgeAdapterConfigInput[] memory bridgeAdapters
-    ) external onlyOwner {
-        _updateReceiverBridgeAdapters(bridgeAdapters, false);
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function receiveCrossChainMessage(
-        bytes memory encodedTransaction,
-        uint256 originChainId
-    ) external onlyApprovedBridges(originChainId) {
-        Transaction memory transaction = TransactionUtils.decode(
-            encodedTransaction
-        );
-        Envelope memory envelope = transaction.getEnvelope();
-        require(
-            envelope.originChainId == originChainId &&
-                envelope.destinationChainId == block.chainid,
-            Errors.CHAIN_ID_MISMATCH
-        );
-        bytes32 envelopeId = transaction.getEnvelopeId();
-        // if envelope was confirmed before, just return
-        if (_envelopesState[envelopeId] != EnvelopeState.None) return;
-
-        bytes32 transactionId = TransactionUtils.getId(encodedTransaction);
-        TransactionState storage internalTransaction = _transactionsState[
-            transactionId
-        ];
-        ReceiverConfiguration memory configuration = _configurationsByChain[
-            originChainId
-        ].configuration;
-
-        // If bridged at is > invalidation, it means that the first time transaction was received after last invalidation and
-        // can be processed.
-        // 0 here means that it’s received for a first time, so invalidation does not matter for this message.
-        // Also checks that bridge adapter didn’t bridge this transaction already.
-        // Dont let messages pass if required confirmations are 0. Meaning that they have not been configured
-        uint120 transactionFirstBridgedAt = internalTransaction.firstBridgedAt;
-        if (
-            transactionFirstBridgedAt == 0 ||
-            (!internalTransaction.bridgedByAdapter[msg.sender] &&
-                transactionFirstBridgedAt > configuration.validityTimestamp)
-        ) {
-            if (transactionFirstBridgedAt == 0) {
-                internalTransaction.firstBridgedAt = uint120(block.timestamp);
-            }
-
-            uint8 newConfirmations = ++internalTransaction.confirmations;
-            internalTransaction.bridgedByAdapter[msg.sender] = true;
-
-            emit TransactionReceived(
-                transactionId,
-                envelopeId,
-                originChainId,
-                transaction,
-                msg.sender,
-                newConfirmations
-            );
-
-            // checks that the message was not delivered before, so it will not try to deliver again when message arrives
-            // from additional bridges after reaching required number of confirmations
-            // >= is used for the case when confirmations gets lowered before message reached the old _requiredConfirmations
-            // but on receiving new messages it surpasses the current _requiredConfirmations. So it doesn't get stuck (if using ==)
-            if (
-                configuration.requiredConfirmation > 0 &&
-                newConfirmations >= configuration.requiredConfirmation
-            ) {
-                _envelopesState[envelopeId] = EnvelopeState.Delivered;
-                try
-                    IBaseReceiverPortal(envelope.destination)
-                        .receiveCrossChainMessage(
-                            envelope.origin,
-                            envelope.originChainId,
-                            envelope.message
-                        )
-                {
-                    emit EnvelopeDeliveryAttempted(envelopeId, envelope, true);
-                } catch (bytes memory) {
-                    _envelopesState[envelopeId] = EnvelopeState.Confirmed;
-                    emit EnvelopeDeliveryAttempted(envelopeId, envelope, false);
-                }
-            }
-        }
-    }
-
-    /// @inheritdoc ICrossChainReceiver
-    function deliverEnvelope(Envelope memory envelope) external {
-        bytes32 envelopeId = envelope.getId();
-        require(
-            _envelopesState[envelopeId] == EnvelopeState.Confirmed,
-            Errors.ENVELOPE_NOT_CONFIRMED_OR_DELIVERED
-        );
-
-        _envelopesState[envelopeId] = EnvelopeState.Delivered;
-        IBaseReceiverPortal(envelope.destination).receiveCrossChainMessage(
-            envelope.origin,
-            envelope.originChainId,
-            envelope.message
-        );
-        emit EnvelopeDeliveryAttempted(envelopeId, envelope, true);
-    }
-
-    /**
-   * @notice method to set a new timestamp from where the messages will be valid.
-   * @param newValidityTimestampsInput array of objects containing the chain and timestamp where all the previous unconfirmed
-            messages must be invalidated.
-   */
-    function _updateMessagesValidityTimestamp(
-        ValidityTimestampInput[] memory newValidityTimestampsInput
-    ) internal {
-        for (uint256 i; i < newValidityTimestampsInput.length; i++) {
-            ValidityTimestampInput memory input = newValidityTimestampsInput[i];
-            require(
-                input.validityTimestamp >
-                    _configurationsByChain[input.chainId]
-                        .configuration
-                        .validityTimestamp &&
-                    input.validityTimestamp <= block.timestamp,
-                Errors.INVALID_VALIDITY_TIMESTAMP
-            );
-            _configurationsByChain[input.chainId]
-                .configuration
-                .validityTimestamp = input.validityTimestamp;
-
-            emit NewInvalidation(input.validityTimestamp, input.chainId);
-        }
-    }
-
-    /**
-     * @notice method to update the number of confirmations necessary for the messages to be accepted as valid
-     * @param newConfirmations array of objects with the chainId and the new number of needed confirmations
-     */
-    function _updateConfirmations(
-        ConfirmationInput[] memory newConfirmations
-    ) internal {
-        for (uint256 i; i < newConfirmations.length; i++) {
-            ConfirmationInput memory confirmations = newConfirmations[i];
-            require(
-                confirmations.requiredConfirmations > 0 &&
-                    confirmations.requiredConfirmations <=
-                    _configurationsByChain[confirmations.chainId]
-                        .allowedBridgeAdapters
-                        .length(),
-                Errors.INVALID_REQUIRED_CONFIRMATIONS
-            );
-            _configurationsByChain[confirmations.chainId]
-                .configuration
-                .requiredConfirmation = confirmations.requiredConfirmations;
-            emit ConfirmationsUpdated(
-                confirmations.requiredConfirmations,
-                confirmations.chainId
-            );
-        }
-    }
-
-    /**
-     * @notice method to add bridge adapters to the allowed list
-     * @param bridgeAdaptersInput array of objects with the new bridge adapters and supported chains
-     */
-    function _updateReceiverBridgeAdapters(
-        ReceiverBridgeAdapterConfigInput[] memory bridgeAdaptersInput,
-        bool isAllowed
-    ) internal {
-        for (uint256 i = 0; i < bridgeAdaptersInput.length; i++) {
-            ReceiverBridgeAdapterConfigInput memory input = bridgeAdaptersInput[
-                i
-            ];
-            require(
-                input.bridgeAdapter != address(0),
-                Errors.INVALID_BRIDGE_ADAPTER
-            );
-
-            for (uint256 j; j < input.chainIds.length; j++) {
-                bool actionProcessed;
-                if (isAllowed) {
-                    _supportedChains.add(input.chainIds[j]);
-                    actionProcessed = _configurationsByChain[input.chainIds[j]]
-                        .allowedBridgeAdapters
-                        .add(input.bridgeAdapter);
-                } else {
-                    actionProcessed = _configurationsByChain[input.chainIds[j]]
-                        .allowedBridgeAdapters
-                        .remove(input.bridgeAdapter);
-                    if (
-                        actionProcessed &&
-                        _configurationsByChain[input.chainIds[j]]
-                            .allowedBridgeAdapters
-                            .length() ==
-                        0
-                    ) {
-                        _supportedChains.remove(input.chainIds[j]);
-                    }
-                }
-                if (actionProcessed) {
-                    emit ReceiverBridgeAdaptersUpdated(
-                        input.bridgeAdapter,
-                        isAllowed,
-                        input.chainIds[j]
-                    );
-                }
-            }
-        }
-    }
-
-    /// @dev utility function, defining an order of actions commonly done in batch
-    function _configureReceiverBasics(
-        ReceiverBridgeAdapterConfigInput[] memory bridgesToEnable,
-        ReceiverBridgeAdapterConfigInput[] memory bridgesToDisable,
-        ConfirmationInput[] memory newConfirmations
-    ) internal {
-        // IMPORTANT. Confirmations update should always happen after adapters, to not create a situation of
-        // blockage in the system
-        _updateReceiverBridgeAdapters(bridgesToEnable, true);
-        _updateReceiverBridgeAdapters(bridgesToDisable, false);
-        _updateConfirmations(newConfirmations);
-    }
-}
-
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/BaseCrossChainController.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/BaseCrossChainController.sol
 
 /**
  * @title BaseCrossChainController
@@ -3307,7 +3348,7 @@ contract BaseCrossChainController is
     receive() external payable {}
 }
 
-// etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/CrossChainController.sol
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/CrossChainController.sol
 
 /**
  * @title CrossChainController
@@ -3338,3 +3379,19 @@ contract CrossChainController is
         );
     }
 }
+
+// etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainController.sol
+
+/**
+ * @title CrossChainControllerUpgradeRev2
+ * @author BGD Labs
+ * @notice CrossChainController Revision 2. Contract inheriting from CrossChainController with the addition of re initialization method
+ * @dev reinitializer is not used on parent CrossChainController, so this contract is needed to be able to initialize CCC with a new implementation
+ */
+contract CrossChainControllerUpgradeRev2 is
+    CrossChainController,
+    IReinitialize
+{
+    /// @inheritdoc IReinitialize
+    function initializeRevision() external reinitializer(2) {}
+}
```
