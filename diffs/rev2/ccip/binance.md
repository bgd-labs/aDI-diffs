```diff
diff --git a/flattened/rev2/ccip/current/binance/CCIPAdapter.sol b/flattened/rev2/ccip/new/binance/CCIPAdapter.sol
index 0cfba43..c433ce0 100644
--- a/flattened/rev2/ccip/current/binance/CCIPAdapter.sol
+++ b/flattened/rev2/ccip/new/binance/CCIPAdapter.sol
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.0 ^0.8.1 ^0.8.4 ^0.8.8;
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol
 
-// OpenZeppelin Contracts (last updated v4.8.0) (utils/structs/EnumerableSet.sol)
+// OpenZeppelin Contracts (last updated v4.9.0) (utils/structs/EnumerableSet.sol)
 // This file was procedurally generated from scripts/generate/templates/EnumerableSet.js.
 
 /**
@@ -17,7 +17,7 @@ pragma solidity ^0.8.0 ^0.8.1 ^0.8.4 ^0.8.8;
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
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/Address.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/Address.sol
 
 // OpenZeppelin Contracts (last updated v4.7.0) (utils/Address.sol)
 // From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/8b778fa20d6d76340c5fac1ed66c80273f05b95a
@@ -732,7 +732,7 @@ library Address {
     }
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/SafeCast.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/SafeCast.sol
 
 // OpenZeppelin Contracts (last updated v4.8.0) (utils/math/SafeCast.sol)
 // This file was procedurally generated from scripts/generate/templates/SafeCast.js.
@@ -1964,7 +1964,7 @@ library SafeCast {
     }
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol
 
 // OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)
 // From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/a035b235b4f2c9af4ba88edc4447f02e37f8d124
@@ -2054,7 +2054,7 @@ interface IERC20 {
     ) external returns (bool);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20Permit.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20Permit.sol
 
 // OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/extensions/IERC20Permit.sol)
 // Modified from https://github.com/OpenZeppelin/openzeppelin-contracts/commit/00cbf5a236564c3b7aacdad1f378cae22d890ca6
@@ -2115,7 +2115,7 @@ interface IERC20Permit {
     function DOMAIN_SEPARATOR() external view returns (bytes32);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/utils/interfaces/IRescuable.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/utils/interfaces/IRescuable.sol
 
 /**
  * @title IRescuable
@@ -2175,79 +2175,7 @@ interface IRescuable {
     function whoCanRescue() external view returns (address);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol
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
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/interfaces/IERC165.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/interfaces/IERC165.sol
 
 interface IERC165 {
     // @dev Should indicate whether the contract implements IAny2EVMMessageReceiver
@@ -2260,7 +2188,7 @@ interface IERC165 {
     function supportsInterface(bytes4 interfaceId) external view returns (bool);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/lib/Client.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/lib/Client.sol
 
 library Client {
     struct EVMTokenAmount {
@@ -2301,7 +2229,7 @@ library Client {
     }
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/libs/ChainIds.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/libs/ChainIds.sol
 
 library ChainIds {
     uint256 constant ETHEREUM = 1;
@@ -2314,9 +2242,13 @@ library ChainIds {
     uint256 constant METIS = 1088;
     uint256 constant BNB = 56;
     uint256 constant BASE = 8453;
+    uint256 constant POLYGON_ZK_EVM = 1101;
+    uint256 constant GNOSIS = 100;
+    uint256 constant SCROLL = 534352;
+    uint256 constant CELO = 42220;
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/libs/EncodingUtils.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/libs/EncodingUtils.sol
 
 using EnvelopeUtils for Envelope global;
 using TransactionUtils for Transaction global;
@@ -2495,7 +2427,7 @@ library TransactionUtils {
     }
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/libs/Errors.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/libs/Errors.sol
 
 /**
  * @title Errors library
@@ -2537,11 +2469,17 @@ library Errors {
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
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/interfaces/IAny2EVMMessageReceiver.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/interfaces/IAny2EVMMessageReceiver.sol
 
 /// @notice Application contracts that intend to receive messages from
 /// the router should implement this interface.
@@ -2555,7 +2493,7 @@ interface IAny2EVMMessageReceiver {
     function ccipReceive(Client.Any2EVMMessage calldata message) external;
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/interfaces/IRouterClient.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/interfaces/IRouterClient.sol
 
 // Client library above
 
@@ -2604,7 +2542,7 @@ interface IRouterClient {
     ) external payable returns (bytes32 messageId);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/interfaces/ICrossChainForwarder.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/interfaces/ICrossChainForwarder.sol
 
 /**
  * @title ICrossChainForwarder
@@ -2832,7 +2770,7 @@ interface ICrossChainForwarder {
     function isSenderApproved(address sender) external view returns (bool);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/interfaces/ICrossChainReceiver.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/interfaces/ICrossChainReceiver.sol
 
 /**
  * @title ICrossChainReceiver
@@ -3111,7 +3049,7 @@ interface ICrossChainReceiver {
     ) external;
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/SafeERC20.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/lib/solidity-utils/src/contracts/oz-common/SafeERC20.sol
 
 // OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/utils/SafeERC20.sol)
 // Modified From commit https://github.com/OpenZeppelin/openzeppelin-contracts/commit/00cbf5a236564c3b7aacdad1f378cae22d890ca6
@@ -3288,7 +3226,7 @@ library SafeERC20 {
     }
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/ICCIPAdapter.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/ICCIPAdapter.sol
 
 /**
  * @title ICCIPAdapter
@@ -3309,7 +3247,7 @@ interface ICCIPAdapter {
     function CCIP_ROUTER() external view returns (IRouterClient);
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/interfaces/IBaseCrossChainController.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/interfaces/IBaseCrossChainController.sol
 
 /**
  * @title IBaseCrossChainController
@@ -3324,7 +3262,98 @@ interface IBaseCrossChainController is
 
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol
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
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol
 
 /**
  * @title BaseAdapter
@@ -3333,19 +3362,31 @@ interface IBaseCrossChainController is
  * @dev All bridge adapters must implement this contract
  */
 abstract contract BaseAdapter is IBaseAdapter {
+    /// @inheritdoc IBaseAdapter
     IBaseCrossChainController public immutable CROSS_CHAIN_CONTROLLER;
 
+    /// @inheritdoc IBaseAdapter
+    uint256 public immutable BASE_GAS_LIMIT;
+
     // @dev this is the original address of the contract. Required to identify and prevent delegate calls.
     address private immutable _selfAddress;
 
     // (standard chain id -> origin forwarder address) saves for every chain the address that can forward messages to this adapter
     mapping(uint256 => address) internal _trustedRemotes;
 
+    /// @inheritdoc IBaseAdapter
+    string public adapterName;
+
     /**
      * @param crossChainController address of the CrossChainController the bridged messages will be routed to
+     * @param providerGasLimit base gas limit used by the bridge adapter
+     * @param name name of the bridge adapter contract
+     * @param originConfigs pair of origin address and chain id that adapter is allowed to get messages from
      */
     constructor(
         address crossChainController,
+        uint256 providerGasLimit,
+        string memory name,
         TrustedRemotesConfig[] memory originConfigs
     ) {
         require(
@@ -3356,6 +3397,9 @@ abstract contract BaseAdapter is IBaseAdapter {
             crossChainController
         );
 
+        BASE_GAS_LIMIT = providerGasLimit;
+        adapterName = name;
+
         _selfAddress = address(this);
 
         for (uint256 i = 0; i < originConfigs.length; i++) {
@@ -3383,6 +3427,7 @@ abstract contract BaseAdapter is IBaseAdapter {
         uint256 infraChainId
     ) public view virtual returns (uint256);
 
+    /// @inheritdoc IBaseAdapter
     function setupPayments() external virtual {}
 
     /// @inheritdoc IBaseAdapter
@@ -3410,7 +3455,7 @@ abstract contract BaseAdapter is IBaseAdapter {
     }
 }
 
-// etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol
+// etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol
 
 /**
  * @title CCIPAdapter
@@ -3447,15 +3492,24 @@ contract CCIPAdapter is
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
@@ -3474,7 +3528,7 @@ contract CCIPAdapter is
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 destinationGasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external returns (address, uint256) {
@@ -3487,8 +3541,10 @@ contract CCIPAdapter is
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
