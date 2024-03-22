```diff
diff --git a/etherscan/rev2/current/adapters/layerzero/gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol b/etherscan/rev2/new/adapters/layerzero/gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol
index 6e3b5ed..1c620d1 100644
--- a/etherscan/rev2/current/adapters/layerzero/gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol
+++ b/etherscan/rev2/new/adapters/layerzero/gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: BUSL-1.1
 pragma solidity ^0.8.8;
 
-import {ILayerZeroReceiver} from "solidity-examples/interfaces/ILayerZeroReceiver.sol";
-import {ILayerZeroEndpoint} from "solidity-examples/interfaces/ILayerZeroEndpoint.sol";
+import {ILayerZeroReceiver} from "./interfaces/ILayerZeroReceiver.sol";
+import {MessagingParams, Origin, MessagingFee, MessagingReceipt} from "./interfaces/ILayerZeroEndpointV2.sol";
 import {SafeCast} from "openzeppelin-contracts/contracts/utils/math/SafeCast.sol";
-
+import {OptionsBuilder} from "./libs/OptionsBuilder.sol";
 import {BaseAdapter, IBaseAdapter} from "../BaseAdapter.sol";
-import {ILayerZeroAdapter} from "./ILayerZeroAdapter.sol";
+import {ILayerZeroAdapter, ILayerZeroEndpointV2} from "./ILayerZeroAdapter.sol";
 import {ChainIds} from "../../libs/ChainIds.sol";
 import {Errors} from "../../libs/Errors.sol";
 
@@ -23,133 +23,157 @@ contract LayerZeroAdapter is
     ILayerZeroReceiver
 {
     /// @inheritdoc ILayerZeroAdapter
-    uint16 public constant VERSION = 1;
-    ILayerZeroEndpoint public immutable LZ_ENDPOINT;
+    ILayerZeroEndpointV2 public immutable LZ_ENDPOINT;
+
+    /// @notice modifier to check that caller is LayerZero endpoint
+    modifier onlyLZEndpoint() {
+        require(
+            msg.sender == address(LZ_ENDPOINT),
+            Errors.CALLER_NOT_LZ_ENDPOINT
+        );
+        _;
+    }
 
     /**
      * @notice constructor for the Layer Zero adapter
      * @param lzEndpoint address of the layer zero endpoint on the current chain where adapter is deployed
      * @param crossChainController address of the contract that manages cross chain infrastructure
-     * @param originConfigs array of objects with chain id and origin addresses which will be allowed to send messages to this adapter
+     * @param providerGasLimit base gas limit used by the bridge adapter
+     * @param trustedRemotes array of objects with chain id and origin addresses which will be allowed to send messages to this adapter
      */
     constructor(
         address lzEndpoint,
         address crossChainController,
-        TrustedRemotesConfig[] memory originConfigs
-    ) BaseAdapter(crossChainController, originConfigs) {
+        uint256 providerGasLimit,
+        TrustedRemotesConfig[] memory trustedRemotes
+    )
+        BaseAdapter(
+            crossChainController,
+            providerGasLimit,
+            "LayerZero adapter",
+            trustedRemotes
+        )
+    {
         require(lzEndpoint != address(0), Errors.INVALID_LZ_ENDPOINT);
-        LZ_ENDPOINT = ILayerZeroEndpoint(lzEndpoint);
+        LZ_ENDPOINT = ILayerZeroEndpointV2(lzEndpoint);
+    }
+
+    /// @inheritdoc ILayerZeroReceiver
+    function nextNonce(
+        uint32 /*_srcEid*/,
+        bytes32 /*_sender*/
+    ) public pure returns (uint64) {
+        return 0;
     }
 
     /// @inheritdoc ILayerZeroReceiver
     function lzReceive(
-        uint16 _srcChainId,
-        bytes calldata _srcAddress,
-        uint64,
-        bytes calldata _payload
-    ) external {
-        // lzReceive must be called by the endpoint for security
-        require(
-            msg.sender == address(LZ_ENDPOINT),
-            Errors.CALLER_NOT_LZ_ENDPOINT
-        );
+        Origin calldata _origin,
+        bytes32,
+        bytes calldata _message,
+        address,
+        bytes calldata
+    ) external payable onlyLZEndpoint {
+        uint256 originChainId = nativeToInfraChainId(_origin.srcEid);
 
-        uint256 originChainId = nativeToInfraChainId(_srcChainId);
-        address trustedRemote = _trustedRemotes[originChainId];
-        bytes memory srcBytes = abi.encodePacked(trustedRemote, address(this));
+        require(allowInitializePath(_origin), Errors.REMOTE_NOT_TRUSTED);
 
-        require(
-            trustedRemote != address(0) &&
-                _srcAddress.length == srcBytes.length &&
-                srcBytes.length > 0 &&
-                keccak256(_srcAddress) == keccak256(srcBytes),
-            Errors.REMOTE_NOT_TRUSTED
-        );
+        _registerReceivedMessage(_message, originChainId);
+    }
 
-        _registerReceivedMessage(_payload, originChainId);
+    /// @inheritdoc ILayerZeroReceiver
+    function allowInitializePath(
+        Origin calldata origin
+    ) public view returns (bool) {
+        uint256 originChainId = nativeToInfraChainId(origin.srcEid);
+        address srcAddress = address(uint160(uint256(origin.sender)));
+        return
+            _trustedRemotes[originChainId] == srcAddress &&
+            srcAddress != address(0);
     }
 
     /// @inheritdoc IBaseAdapter
     function forwardMessage(
         address receiver,
-        uint256 destinationGasLimit,
+        uint256 executionGasLimit,
         uint256 destinationChainId,
         bytes calldata message
     ) external returns (address, uint256) {
-        uint16 nativeChainId = SafeCast.toUint16(
+        uint32 nativeChainId = SafeCast.toUint32(
             infraToNativeChainId(destinationChainId)
         );
         require(
-            nativeChainId != uint16(0),
+            nativeChainId != uint32(0),
             Errors.DESTINATION_CHAIN_ID_NOT_SUPPORTED
         );
         require(receiver != address(0), Errors.RECEIVER_NOT_SET);
 
-        bytes memory adapterParams = abi.encodePacked(
-            VERSION,
-            destinationGasLimit
+        bytes32 receiverAddress = bytes32(uint256(uint160(receiver)));
+
+        uint256 totalGasLimit = executionGasLimit + BASE_GAS_LIMIT;
+
+        bytes memory options = _generateOptions(
+            SafeCast.toUint128(totalGasLimit)
         );
 
-        (uint256 nativeFee, ) = LZ_ENDPOINT.estimateFees(
-            nativeChainId,
-            receiver,
-            message,
-            false,
-            adapterParams
+        MessagingFee memory fee = LZ_ENDPOINT.quote(
+            MessagingParams(
+                nativeChainId,
+                receiverAddress,
+                message,
+                options,
+                false
+            ),
+            address(this)
         );
 
         require(
-            nativeFee <= address(this).balance,
+            fee.nativeFee <= address(this).balance,
             Errors.NOT_ENOUGH_VALUE_TO_PAY_BRIDGE_FEES
         );
 
-        uint64 nonce = LZ_ENDPOINT.getOutboundNonce(
-            nativeChainId,
+        MessagingReceipt memory receipt = LZ_ENDPOINT.send{
+            value: fee.nativeFee
+        }(
+            MessagingParams(
+                nativeChainId,
+                receiverAddress,
+                message,
+                options,
+                false
+            ),
             address(this)
         );
 
-        // remote address concatenated with local address packed into 40 bytes
-        bytes memory remoteAndLocalAddresses = abi.encodePacked(
-            receiver,
-            address(this)
-        );
-
-        LZ_ENDPOINT.send{value: nativeFee}(
-            nativeChainId,
-            remoteAndLocalAddresses,
-            message,
-            payable(address(this)),
-            address(0), // uses native currency for bridge payment
-            adapterParams
-        );
-
-        return (address(LZ_ENDPOINT), nonce);
+        return (address(LZ_ENDPOINT), uint256(receipt.nonce));
     }
 
     /// @inheritdoc IBaseAdapter
     function nativeToInfraChainId(
         uint256 nativeChainId
     ) public pure virtual override returns (uint256) {
-        if (nativeChainId == uint16(101)) {
+        if (nativeChainId == 30101) {
             return ChainIds.ETHEREUM;
-        } else if (nativeChainId == uint16(106)) {
+        } else if (nativeChainId == 30106) {
             return ChainIds.AVALANCHE;
-        } else if (nativeChainId == uint16(109)) {
+        } else if (nativeChainId == 30109) {
             return ChainIds.POLYGON;
-        } else if (nativeChainId == uint16(110)) {
+        } else if (nativeChainId == 30110) {
             return ChainIds.ARBITRUM;
-        } else if (nativeChainId == uint16(111)) {
+        } else if (nativeChainId == 30111) {
             return ChainIds.OPTIMISM;
-        } else if (nativeChainId == uint16(112)) {
+        } else if (nativeChainId == 30112) {
             return ChainIds.FANTOM;
-        } else if (nativeChainId == uint16(116)) {
+        } else if (nativeChainId == 30116) {
             return ChainIds.HARMONY;
-        } else if (nativeChainId == uint16(102)) {
+        } else if (nativeChainId == 30102) {
             return ChainIds.BNB;
-        } else if (nativeChainId == uint16(151)) {
+        } else if (nativeChainId == 30151) {
             return ChainIds.METIS;
-        } else if (nativeChainId == uint16(145)) {
+        } else if (nativeChainId == 30145) {
             return ChainIds.GNOSIS;
+        } else if (nativeChainId == 30125) {
+            return ChainIds.CELO;
         } else {
             return 0;
         }
@@ -160,27 +184,41 @@ contract LayerZeroAdapter is
         uint256 infraChainId
     ) public pure virtual override returns (uint256) {
         if (infraChainId == ChainIds.ETHEREUM) {
-            return uint16(101);
+            return 30101;
         } else if (infraChainId == ChainIds.AVALANCHE) {
-            return uint16(106);
+            return 30106;
         } else if (infraChainId == ChainIds.POLYGON) {
-            return uint16(109);
+            return 30109;
         } else if (infraChainId == ChainIds.ARBITRUM) {
-            return uint16(110);
+            return 30110;
         } else if (infraChainId == ChainIds.OPTIMISM) {
-            return uint16(111);
+            return 30111;
         } else if (infraChainId == ChainIds.FANTOM) {
-            return uint16(112);
+            return 30112;
         } else if (infraChainId == ChainIds.HARMONY) {
-            return uint16(116);
+            return 30116;
         } else if (infraChainId == ChainIds.METIS) {
-            return uint16(151);
+            return 30151;
         } else if (infraChainId == ChainIds.BNB) {
-            return uint16(102);
+            return 30102;
         } else if (infraChainId == ChainIds.GNOSIS) {
-            return uint16(145);
+            return 30145;
+        } else if (infraChainId == ChainIds.CELO) {
+            return 30125;
         } else {
             return uint16(0);
         }
     }
+
+    /**
+     * @notice method to generate LayerZero options
+     * @param gasLimit the gas limit to use on destination chain
+     * @return bytes with the packed options
+     */
+    function _generateOptions(
+        uint128 gasLimit
+    ) internal pure returns (bytes memory) {
+        bytes memory options = OptionsBuilder.newOptions();
+        return OptionsBuilder.addExecutorLzReceiveOption(options, gasLimit, 0);
+    }
 }
```
