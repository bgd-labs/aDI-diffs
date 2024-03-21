# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes
test   :; forge test -vvv

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@npx prettier ${before} ${after} --write
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md

flatten-pool-contracts :;
	forge flatten etherscan/AaveV3Arbitrum_POOL/L2Pool/lib/aave-v3-core/contracts/protocol/pool/L2Pool.sol --output etherscan/flattened/v3PoolArbitrum/Pool.sol

diff-current-pools :;
	make flatten-pool-contracts
	make git-diff before=etherscan/flattened/v3PoolGnosis after=etherscan/flattened/v3PoolBase out=CURRENT_GNOSIS_BASE_POOL_DIFF


get-current-ccip-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/ccip/mainnet 0xDB8953194810b1942544fA528791278D458719D5 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/current/adapters/ccip/avalanche 0x95Fa2c817169E26956AB8795c84a225b55d7db5B --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/current/adapters/ccip/polygon 0x3F006299eC88985c18E6e885EeA29A49eC579882 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/current/adapters/ccip/binance 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}

get-new-ccip-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/ccip/mainnet 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/new/adapters/ccip/avalanche 0xe79757D55a1600eF28D816a893E78E9FCDE2019E --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/new/adapters/ccip/polygon 0x2b88C83727B0E290B76EB3F6133994fF81B7f355 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/new/adapters/ccip/binance 0xAE93BEa44dcbE52B625169588574d31e36fb3A67 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}

get-current-ccc-impl :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/ccc_impl/mainnet 0x0Bf5bbfaE7808D329e0Ba8277e0b746BbfDA68f1 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 43114 -d etherscan/rev2/current/ccc_impl/avalanche 0x9fE056F44510F970d724adA16903ba5D75CC4742 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 137 -d etherscan/rev2/current/ccc_impl/polygon 0x7120b1f8e5b73c0C0DC99C6e52Fe4937E7EA11e0 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 56 -d etherscan/rev2/current/ccc_impl/binance 0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 42161 -d etherscan/rev2/current/ccc_impl/arbitrum 0xbDfA4BdD705e02A2Da357ddd2e543ec654529940 --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM}
	cast etherscan-source --chain 8453 -d etherscan/rev2/current/ccc_impl/base 0x96F68837877fd0414B55050c9e794AECdBcfCA59 --etherscan-api-key ${ETHERSCAN_API_KEY_BASE}
	cast etherscan-source --chain 100 -d etherscan/rev2/current/ccc_impl/gnosis 0x96F68837877fd0414B55050c9e794AECdBcfCA59 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}
	#cast etherscan-source --chain 1088 -d etherscan/rev2/current/ccc_impl/metis 0x3829943c53F2d00e20B58475aF19716724bF90Ba --etherscan-api-key ${ETHERSCAN_API_KEY_METIS}
	cast etherscan-source --chain 10 -d etherscan/rev2/current/ccc_impl/optimism 0x9390B1735def18560c509E2d0bc090E9d6BA257a --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM}
	cast etherscan-source --chain 534352 -d etherscan/rev2/current/ccc_impl/scroll 0xa88c6D90eAe942291325f9ae3c66f3563B93FE10 --etherscan-api-key ${ETHERSCAN_API_KEY_SCROLL}

get-new-ccc-impl :;
	cast etherscan-source --chain 1 -d etherscan/rev2/new/ccc_impl/mainnet 0x28559c2F4B038b1E836fA419DCcDe7454d8Fe215 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 43114 -d etherscan/rev2/new/ccc_impl/avalanche 0x5Ef80c5eB6CF65Dab8cD1C0ee258a6D2bD38Bd22 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 137 -d etherscan/rev2/new/ccc_impl/polygon 0x87a95917DE670088d81B9a8B30E3B36704Ba3043 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 56 -d etherscan/rev2/new/ccc_impl/binance 0xf41193E25408F652AF878c47E4401A01B5E4B682 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 42161 -d etherscan/rev2/new/ccc_impl/arbitrum 0x6e633269af45F37c44659D98f382dd0DD524E5Df --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM}
	cast etherscan-source --chain 8453 -d etherscan/rev2/new/ccc_impl/base 0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F --etherscan-api-key ${ETHERSCAN_API_KEY_BASE}
	cast etherscan-source --chain 100 -d etherscan/rev2/new/ccc_impl/gnosis 0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}
	#cast etherscan-source --chain 1088 -d etherscan/rev2/new/ccc_impl/metis 0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04 --etherscan-api-key ${ETHERSCAN_API_KEY_METIS}
	cast etherscan-source --chain 10 -d etherscan/rev2/new/ccc_impl/optimism 0xa5cc218513305221201f196760E9e64e9D49d98A --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM}
	cast etherscan-source --chain 534352 -d etherscan/rev2/new/ccc_impl/scroll 0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922 --etherscan-api-key ${ETHERSCAN_API_KEY_SCROLL}

flatten-current-ccip :;
	forge flatten etherscan/rev2/current/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/current/avalanche/CCIPAdapter.sol
	forge flatten etherscan/rev2/current/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/current/polygon/CCIPAdapter.sol
	forge flatten etherscan/rev2/current/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/current/mainnet/CCIPAdapter.sol
	forge flatten etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/current/binance/CCIPAdapter.sol

flatten-new-ccip :;
	forge flatten etherscan/rev2/new/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/new/avalanche/CCIPAdapter.sol
	forge flatten etherscan/rev2/new/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/new/polygon/CCIPAdapter.sol
	forge flatten etherscan/rev2/new/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/new/mainnet/CCIPAdapter.sol
	forge flatten etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol --output flattened/rev2/ccip/new/binance/CCIPAdapter.sol


flatten-current-ccc-impl :;
	forge flatten etherscan/rev2/current/ccc_impl/mainnet/CrossChainController/src/contracts/CrossChainController.sol --output flattened/rev2/ccc_impl/current/mainnet/CrossChainController.sol
	forge flatten etherscan/rev2/current/ccc_impl/arbitrum/CrossChainController/src/contracts/CrossChainController.sol --output flattened/rev2/ccc_impl/current/arbitrum/CrossChainController.sol
	forge flatten etherscan/rev2/current/ccc_impl/base/CrossChainController/src/contracts/CrossChainController.sol --output flattened/rev2/ccc_impl/current/base/CrossChainController.sol
	forge flatten etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/CrossChainController.sol --output flattened/rev2/ccc_impl/current/optimism/CrossChainController.sol
	forge flatten etherscan/rev2/current/ccc_impl/scroll/CrossChainController/src/contracts/CrossChainController.sol --output flattened/rev2/ccc_impl/current/scroll/CrossChainController.sol
	forge flatten etherscan/rev2/current/ccc_impl/avalanche/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/current/avalanche/CrossChainControllerWithEmergencyMode.sol
	forge flatten etherscan/rev2/current/ccc_impl/polygon/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/current/polygon/CrossChainControllerWithEmergencyMode.sol
	forge flatten etherscan/rev2/current/ccc_impl/binance/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/current/binance/CrossChainControllerWithEmergencyMode.sol
	forge flatten etherscan/rev2/current/ccc_impl/gnosis/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/current/gnosis/CrossChainControllerWithEmergencyMode.sol

flatten-new-ccc-impl :;
	forge flatten etherscan/rev2/new/ccc_impl/mainnet/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainController.sol --output flattened/rev2/ccc_impl/new/mainnet/CrossChainController.sol
	forge flatten etherscan/rev2/new/ccc_impl/arbitrum/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainController.sol --output flattened/rev2/ccc_impl/new/arbitrum/CrossChainController.sol
	forge flatten etherscan/rev2/new/ccc_impl/base/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainController.sol --output flattened/rev2/ccc_impl/new/base/CrossChainController.sol
	forge flatten etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainController.sol --output flattened/rev2/ccc_impl/new/optimism/CrossChainController.sol
	forge flatten etherscan/rev2/new/ccc_impl/scroll/CrossChainControllerUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainController.sol --output flattened/rev2/ccc_impl/new/scroll/CrossChainController.sol
	forge flatten etherscan/rev2/new/ccc_impl/avalanche/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/new/avalanche/CrossChainControllerWithEmergencyMode.sol
	forge flatten etherscan/rev2/new/ccc_impl/polygon/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/new/polygon/CrossChainControllerWithEmergencyMode.sol
	forge flatten etherscan/rev2/new/ccc_impl/binance/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/new/binance/CrossChainControllerWithEmergencyMode.sol
	forge flatten etherscan/rev2/new/ccc_impl/gnosis/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/revisions/update_to_rev_2/CrossChainControllerWithEmergencyMode.sol --output flattened/rev2/ccc_impl/new/gnosis/CrossChainControllerWithEmergencyMode.sol




diff-ccip :;
	make git-diff before=flattened/rev2/ccip/current/mainnet/CCIPAdapter.sol after=flattened/rev2/ccip/new/mainnet/CCIPAdapter.sol out=rev2/ccip/mainnet
	make git-diff before=flattened/rev2/ccip/current/avalanche/CCIPAdapter.sol after=flattened/rev2/ccip/new/avalanche/CCIPAdapter.sol out=rev2/ccip/avalanche
	make git-diff before=flattened/rev2/ccip/current/polygon/CCIPAdapter.sol after=flattened/rev2/ccip/new/polygon/CCIPAdapter.sol out=rev2/ccip/polygon
	make git-diff before=flattened/rev2/ccip/current/binance/CCIPAdapter.sol after=flattened/rev2/ccip/new/binance/CCIPAdapter.sol out=rev2/ccip/binance

diff-ccc-impl :;
	make git-diff before=flattened/rev2/ccc_impl/current/mainnet/CrossChainController.sol after=flattened/rev2/ccc_impl/new/mainnet/CrossChainController.sol out=rev2/ccc_impl/mainnet
	make git-diff before=flattened/rev2/ccc_impl/current/arbitrum/CrossChainController.sol after=flattened/rev2/ccc_impl/new/arbitrum/CrossChainController.sol out=rev2/ccc_impl/arbitrum
	make git-diff before=flattened/rev2/ccc_impl/current/base/CrossChainController.sol after=flattened/rev2/ccc_impl/new/base/CrossChainController.sol out=rev2/ccc_impl/base
	make git-diff before=flattened/rev2/ccc_impl/current/optimism/CrossChainController.sol after=flattened/rev2/ccc_impl/new/optimism/CrossChainController.sol out=rev2/ccc_impl/optimism
	make git-diff before=flattened/rev2/ccc_impl/current/scroll/CrossChainController.sol after=flattened/rev2/ccc_impl/new/scroll/CrossChainController.sol out=rev2/ccc_impl/scroll
	make git-diff before=flattened/rev2/ccc_impl/current/avalanche/CrossChainControllerWithEmergencyMode.sol after=flattened/rev2/ccc_impl/new/avalanche/CrossChainControllerWithEmergencyMode.sol out=rev2/ccc_impl/avalanche
	make git-diff before=flattened/rev2/ccc_impl/current/polygon/CrossChainControllerWithEmergencyMode.sol after=flattened/rev2/ccc_impl/new/polygon/CrossChainControllerWithEmergencyMode.sol out=rev2/ccc_impl/polygon
	make git-diff before=flattened/rev2/ccc_impl/current/gnosis/CrossChainControllerWithEmergencyMode.sol after=flattened/rev2/ccc_impl/new/gnosis/CrossChainControllerWithEmergencyMode.sol out=rev2/ccc_impl/gnosis
	make git-diff before=flattened/rev2/ccc_impl/current/binance/CrossChainControllerWithEmergencyMode.sol after=flattened/rev2/ccc_impl/new/binance/CrossChainControllerWithEmergencyMode.sol out=rev2/ccc_impl/binance
