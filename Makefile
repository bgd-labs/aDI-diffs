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

get-current-ccip-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/ccip/mainnet 0xDB8953194810b1942544fA528791278D458719D5 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/current/adapters/ccip/polygon 0x95Fa2c817169E26956AB8795c84a225b55d7db5B --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/current/adapters/ccip/avalanche 0x3F006299eC88985c18E6e885EeA29A49eC579882 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/current/adapters/ccip/binance 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}

get-new-ccip-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/ccip/mainnet 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/new/adapters/ccip/polygon 0xe79757D55a1600eF28D816a893E78E9FCDE2019E --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/new/adapters/ccip/avalanche 0x2b88C83727B0E290B76EB3F6133994fF81B7f355 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/new/adapters/ccip/binance 0xAE93BEa44dcbE52B625169588574d31e36fb3A67 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}


get-current-hyperlane-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/hyperlane/mainnet 0x6Abb61beb5848B476d026C4934E8a6415e2E75a8 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/current/adapters/hyperlane/polygon 0x3c25b96fF62D21E90556869272a277eE2E229747 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/current/adapters/hyperlane/avalanche 0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/current/adapters/hyperlane/binance 0x118DFD5418890c0332042ab05173Db4A2C1d283c --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 100 -d etherscan/rev2/current/adapters/hyperlane/gnosis 0x4A4c73d563395ad827511F70097d4Ef82E653805 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}

get-new-hyperlane-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/hyperlane/mainnet 0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/new/adapters/hyperlane/polygon 0x3e72665008dC237bdd91C04C10782Ed1987a4019 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/new/adapters/hyperlane/avalanche 0x617332a777780F546261247F621051d0b98975Eb --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/new/adapters/hyperlane/binance 0x3F006299eC88985c18E6e885EeA29A49eC579882 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 100 -d etherscan/rev2/new/adapters/hyperlane/gnosis 0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}

get-current-layerzero-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/layerzero/mainnet 0x2a323be63e08E08536Fc3b5d8C6f24825e68895e --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/layerzero/mainnet_gnosis 0x1783DA119C35ED03e608f88cB9528Aba8174fFfc --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/current/adapters/layerzero/polygon 0xDA4B6024aA06f7565BBcAaD9B8bE24C3c229AAb5 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/current/adapters/layerzero/avalanche 0xf41193E25408F652AF878c47E4401A01B5E4B682 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/current/adapters/layerzero/binance 0xFF1137243698CaA18EE364Cc966CF0e02A4e6327 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 100 -d etherscan/rev2/current/adapters/layerzero/gnosis 0x7b62461a3570c6AC8a9f8330421576e417B71EE7 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}

get-new-layerzero-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/layerzero/mainnet 0x8410d9BD353b420ebA8C48ff1B0518426C280FCC --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 137 -d etherscan/rev2/new/adapters/layerzero/polygon 0x7FAE7765abB4c8f778d57337bB720d0BC53057e3 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 43114 -d etherscan/rev2/new/adapters/layerzero/avalanche 0x10f02995a399C0dC0FaF29914220E9C1bCdE8640 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 56 -d etherscan/rev2/new/adapters/layerzero/binance 0xa5cc218513305221201f196760E9e64e9D49d98A --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 100 -d etherscan/rev2/new/adapters/layerzero/gnosis 0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}

get-current-native-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_arbitrum 0xE2a33403eaD139873820da597531f07f65ED0E3c --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_gnosis 0xe95B40b2CF5fA2F56AAEf9E52f5Bd1e70C059858 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_optimism 0x2ecC4F6CDbe6ea77107dd131Af81ec82Db330d6b --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_base 0xEB442296880a3FC7C00FFe695c40B09d970fb936 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_scroll 0xb29F03cbCc646201eC83E9F2C164747beA84b162 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_metis 0x619643b346E3389062527cdb60C8720415B39860 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_polygon 0xb13712De579E1f9943502FFCf72eab6ec348cF79 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/current/adapters/native/mainnet_mainnet 0x118DFD5418890c0332042ab05173Db4A2C1d283c --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 42161 -d etherscan/rev2/current/adapters/native/arbitrum 0x3829943c53F2d00e20B58475aF19716724bF90Ba --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM}
	cast etherscan-source --chain 100 -d etherscan/rev2/current/adapters/native/gnosis 0x889c0cc3283DB588A34E89Ad1E8F25B0fc827b4b --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}
	cast etherscan-source --chain 10 -d etherscan/rev2/current/adapters/native/optimism 0x81d32B36380e6266e1BDd490eAC56cdB300afBe0 --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM}
	cast etherscan-source --chain 8453 -d etherscan/rev2/current/adapters/native/base 0x7b62461a3570c6AC8a9f8330421576e417B71EE7 --etherscan-api-key ${ETHERSCAN_API_KEY_BASE}
	cast etherscan-source --chain 534352 -d etherscan/rev2/current/adapters/native/scroll 0x118DFD5418890c0332042ab05173Db4A2C1d283c --etherscan-api-key ${ETHERSCAN_API_KEY_SCROLL}
	#cast etherscan-source --chain 1088 -d etherscan/rev2/current/adapters/native/metis 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf
	cast etherscan-source --chain 137 -d etherscan/rev2/current/adapters/native/polygon 0xb13712De579E1f9943502FFCf72eab6ec348cF79 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}

get-new-native-adapers :;
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_arbitrum 0x88d6D01e08d3e64513b15fD46528dBbA7d755883 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_gnosis 0x7238d75fD75bb936E83b75854c653F104Ce9c9d8 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_optimism 0x0e24524778fdc67f53eEf144b8cbf50261E930B3 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_base 0xa5948b0ac79f72966dFFC5C13E44f6dfDD3D58A0 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_scroll 0xA4dC3F123e1c601A19B3DC8382BB9311F678cafA --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_metis 0x6B3Dc800E7c813Db3fe8D0F30fDCaE636935dC14 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_polygon 0x1562F1b2487F892BBA8Ef325aF054Fd157510a71 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 1 -d etherscan/rev2/new/adapters/native/mainnet_mainnet 0x6cfbd2aA4691fc18B9C209bDd43DC3943C228FCf --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 42161 -d etherscan/rev2/new/adapters/native/arbitrum 0xc8a2ADC4261c6b669CdFf69E717E77C9cFeB420d --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM}
	cast etherscan-source --chain 100 -d etherscan/rev2/new/adapters/native/gnosis 0x3C06dce358add17aAf230f2234bCCC4afd50d090 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}
	cast etherscan-source --chain 10 -d etherscan/rev2/new/adapters/native/optimism 0xAE93BEa44dcbE52B625169588574d31e36fb3A67 --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM}
	cast etherscan-source --chain 8453 -d etherscan/rev2/new/adapters/native/base 0x7120b1f8e5b73c0C0DC99C6e52Fe4937E7EA11e0 --etherscan-api-key ${ETHERSCAN_API_KEY_BASE}
	cast etherscan-source --chain 534352 -d etherscan/rev2/new/adapters/native/scroll 0x3C06dce358add17aAf230f2234bCCC4afd50d090 --etherscan-api-key ${ETHERSCAN_API_KEY_SCROLL}
	#cast etherscan-source --chain 1088 -d etherscan/rev2/new/adapters/native/metis 0xf41193E25408F652AF878c47E4401A01B5E4B682
	cast etherscan-source --chain 137 -d etherscan/rev2/new/adapters/native/polygon 0x853649f897383f89d8441346Cf26a9ed02720B02 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}

diff-native-adapters :;
	make git-diff before=etherscan/rev2/current/adapters/native/arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol after=etherscan/rev2/new/adapters/native/arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol out=rev2/native/arb_adapter/arbitrum
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol after=etherscan/rev2/new/adapters/native/mainnet_arbitrum/ArbAdapter/src/contracts/adapters/arbitrum/ArbAdapter.sol out=rev2/native/arb_adapter/mainnet_arbitrum
	make git-diff before=etherscan/rev2/current/adapters/native/optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol after=etherscan/rev2/new/adapters/native/optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol out=rev2/native/op_adapter/optimism
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol after=etherscan/rev2/new/adapters/native/mainnet_optimism/OpAdapter/src/contracts/adapters/optimism/OpAdapter.sol out=rev2/native/op_adapter/mainnet_optimism
	make git-diff before=etherscan/rev2/current/adapters/native/base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol after=etherscan/rev2/new/adapters/native/base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol out=rev2/native/base_adapter/base
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol after=etherscan/rev2/new/adapters/native/mainnet_base/CBaseAdapter/src/contracts/adapters/cBase/CBaseAdapter.sol out=rev2/native/base_adapter/mainnet_base
	make git-diff before=etherscan/rev2/current/adapters/native/gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol after=etherscan/rev2/new/adapters/native/gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol out=rev2/native/gnosis_adapter/gnosis
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol after=etherscan/rev2/new/adapters/native/mainnet_gnosis/GnosisChainAdapter/src/contracts/adapters/gnosisChain/GnosisChainAdapter.sol out=rev2/native/gnosis_adapter/mainnet_gnosis
	make git-diff before=etherscan/rev2/current/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterPolygon.sol after=etherscan/rev2/new/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterPolygon.sol out=rev2/native/polygon_adapter/polygon
	make git-diff before=etherscan/rev2/current/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterBase.sol after=etherscan/rev2/new/adapters/native/polygon/PolygonAdapterPolygon/src/contracts/adapters/polygon/PolygonAdapterBase.sol out=rev2/native/polygon_adapter/polygon_base
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterEthereum.sol after=etherscan/rev2/new/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterEthereum.sol out=rev2/native/polygon_adapter/mainnet_polygon
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterBase.sol after=etherscan/rev2/new/adapters/native/mainnet_polygon/PolygonAdapterEthereum/src/contracts/adapters/polygon/PolygonAdapterBase.sol out=rev2/native/polygon_adapter/mainnet_polygon_base
	make git-diff before=etherscan/rev2/current/adapters/native/scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol after=etherscan/rev2/new/adapters/native/scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol out=rev2/native/scroll_adapter/scroll
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol after=etherscan/rev2/new/adapters/native/mainnet_scroll/ScrollAdapter/src/contracts/adapters/scroll/ScrollAdapter.sol out=rev2/native/scroll_adapter/mainnet_scroll
	make git-diff before=etherscan/rev2/current/adapters/native/mainnet_mainnet/SameChainAdapter/src/contracts/adapters/sameChain/SameChainAdapter.sol after=etherscan/rev2/new/adapters/native/mainnet_mainnet/SameChainAdapter/src/contracts/adapters/sameChain/SameChainAdapter.sol out=rev2/native/samechain_adapter/mainnet_mainnet




get-current-ccc-impl :;
	cast etherscan-source --chain 1 -d etherscan/rev2/current/ccc_impl/mainnet 0x0Bf5bbfaE7808D329e0Ba8277e0b746BbfDA68f1 --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET}
	cast etherscan-source --chain 43114 -d etherscan/rev2/current/ccc_impl/avalanche 0x9fE056F44510F970d724adA16903ba5D75CC4742 --etherscan-api-key ${ETHERSCAN_API_KEY_AVALANCHE}
	cast etherscan-source --chain 137 -d etherscan/rev2/current/ccc_impl/polygon 0x7120b1f8e5b73c0C0DC99C6e52Fe4937E7EA11e0 --etherscan-api-key ${ETHERSCAN_API_KEY_POLYGON}
	cast etherscan-source --chain 56 -d etherscan/rev2/current/ccc_impl/binance 0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19 --etherscan-api-key ${ETHERSCAN_API_KEY_BINANCE}
	cast etherscan-source --chain 42161 -d etherscan/rev2/current/ccc_impl/arbitrum 0xbDfA4BdD705e02A2Da357ddd2e543ec654529940 --etherscan-api-key ${ETHERSCAN_API_KEY_ARBITRUM}
	cast etherscan-source --chain 8453 -d etherscan/rev2/current/ccc_impl/base 0x96F68837877fd0414B55050c9e794AECdBcfCA59 --etherscan-api-key ${ETHERSCAN_API_KEY_BASE}
	cast etherscan-source --chain 100 -d etherscan/rev2/current/ccc_impl/gnosis 0x96F68837877fd0414B55050c9e794AECdBcfCA59 --etherscan-api-key ${ETHERSCAN_API_KEY_GNOSIS}
	cast etherscan-source --chain 1088 -d etherscan/rev2/current/ccc_impl/metis 0x3829943c53F2d00e20B58475aF19716724bF90Ba
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
	cast etherscan-source --chain 1088 -d etherscan/rev2/new/ccc_impl/metis 0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04
	cast etherscan-source --chain 10 -d etherscan/rev2/new/ccc_impl/optimism 0xa5cc218513305221201f196760E9e64e9D49d98A --etherscan-api-key ${ETHERSCAN_API_KEY_OPTIMISM}
	cast etherscan-source --chain 534352 -d etherscan/rev2/new/ccc_impl/scroll 0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922 --etherscan-api-key ${ETHERSCAN_API_KEY_SCROLL}

diff-base-adapter :;
	make git-diff before=etherscan/rev2/current/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol out=rev2/base_adapter/avalanche
	make git-diff before=etherscan/rev2/current/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol out=rev2/base_adapter/polygon
	make git-diff before=etherscan/rev2/current/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol out=rev2/base_adapter/mainnet
	make git-diff before=etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/BaseAdapter.sol out=rev2/base_adapter/binance

diff-base-adapter-interface :;
	make git-diff before=etherscan/rev2/current/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol out=rev2/i_base_adapter/avalanche
	make git-diff before=etherscan/rev2/current/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol out=rev2/i_base_adapter/polygon
	make git-diff before=etherscan/rev2/current/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol out=rev2/i_base_adapter/mainnet
	make git-diff before=etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol after=etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/IBaseAdapter.sol out=rev2/i_base_adapter/binance

diff-ccip :;
	make git-diff before=etherscan/rev2/current/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol after=etherscan/rev2/new/adapters/ccip/avalanche/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol out=rev2/ccip/avalanche
	make git-diff before=etherscan/rev2/current/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol after=etherscan/rev2/new/adapters/ccip/polygon/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol out=rev2/ccip/polygon
	make git-diff before=etherscan/rev2/current/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol after=etherscan/rev2/new/adapters/ccip/mainnet/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol out=rev2/ccip/mainnet
	make git-diff before=etherscan/rev2/current/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol after=etherscan/rev2/new/adapters/ccip/binance/CCIPAdapter/src/contracts/adapters/ccip/CCIPAdapter.sol out=rev2/ccip/binance

diff-ccc-impl :;
	make git-diff before=etherscan/rev2/current/ccc_impl/mainnet/CrossChainController/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/mainnet/CrossChainControllerUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/mainnet
	make git-diff before=etherscan/rev2/current/ccc_impl/arbitrum/CrossChainController/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/arbitrum/CrossChainControllerUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/arbitrum
	make git-diff before=etherscan/rev2/current/ccc_impl/base/CrossChainController/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/base/CrossChainControllerUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/base
	make git-diff before=etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/optimism
	make git-diff before=etherscan/rev2/current/ccc_impl/scroll/CrossChainController/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/scroll/CrossChainControllerUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/scroll
	make git-diff before=etherscan/rev2/current/ccc_impl/avalanche/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/avalanche/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/avalanche
	make git-diff before=etherscan/rev2/current/ccc_impl/polygon/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/polygon/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/polygon
	make git-diff before=etherscan/rev2/current/ccc_impl/gnosis/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/gnosis/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/gnosis
	make git-diff before=etherscan/rev2/current/ccc_impl/binance/CrossChainControllerWithEmergencyMode/src/contracts/CrossChainReceiver.sol after=etherscan/rev2/new/ccc_impl/binance/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/CrossChainReceiver.sol out=rev2/ccc_impl/binance

diff-errors :;
	make git-diff before=etherscan/rev2/current/ccc_impl/mainnet/CrossChainController/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/mainnet/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/mainnet
	make git-diff before=etherscan/rev2/current/ccc_impl/arbitrum/CrossChainController/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/arbitrum/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/arbitrum
	make git-diff before=etherscan/rev2/current/ccc_impl/base/CrossChainController/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/base/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/base
	make git-diff before=etherscan/rev2/current/ccc_impl/optimism/CrossChainController/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/optimism/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/optimism
	make git-diff before=etherscan/rev2/current/ccc_impl/scroll/CrossChainController/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/scroll/CrossChainControllerUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/scroll
	make git-diff before=etherscan/rev2/current/ccc_impl/avalanche/CrossChainControllerWithEmergencyMode/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/avalanche/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/avalanche
	make git-diff before=etherscan/rev2/current/ccc_impl/polygon/CrossChainControllerWithEmergencyMode/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/polygon/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/polygon
	make git-diff before=etherscan/rev2/current/ccc_impl/gnosis/CrossChainControllerWithEmergencyMode/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/gnosis/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/gnosis
	make git-diff before=etherscan/rev2/current/ccc_impl/binance/CrossChainControllerWithEmergencyMode/src/contracts/libs/Errors.sol after=etherscan/rev2/new/ccc_impl/binance/CrossChainControllerWithEmergencyModeUpgradeRev2/src/contracts/libs/Errors.sol out=rev2/errors/binance

diff-hyperlane :;
	make git-diff before=etherscan/rev2/current/adapters/hyperlane/avalanche/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol after=etherscan/rev2/new/adapters/hyperlane/avalanche/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol out=rev2/hyperlane/avalanche
	make git-diff before=etherscan/rev2/current/adapters/hyperlane/polygon/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol after=etherscan/rev2/new/adapters/hyperlane/polygon/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol out=rev2/hyperlane/polygon
	make git-diff before=etherscan/rev2/current/adapters/hyperlane/mainnet/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol after=etherscan/rev2/new/adapters/hyperlane/mainnet/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol out=rev2/hyperlane/mainnet
	make git-diff before=etherscan/rev2/current/adapters/hyperlane/binance/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol after=etherscan/rev2/new/adapters/hyperlane/binance/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol out=rev2/hyperlane/binance
	make git-diff before=etherscan/rev2/current/adapters/hyperlane/gnosis/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol after=etherscan/rev2/new/adapters/hyperlane/gnosis/HyperLaneAdapter/src/contracts/adapters/hyperlane/HyperLaneAdapter.sol out=rev2/hyperlane/gnosis

diff-layerzero :;
	make git-diff before=etherscan/rev2/current/adapters/layerzero/avalanche/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol after=etherscan/rev2/new/adapters/layerzero/avalanche/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol out=rev2/layerzero/avalanche
	make git-diff before=etherscan/rev2/current/adapters/layerzero/polygon/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol after=etherscan/rev2/new/adapters/layerzero/polygon/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol out=rev2/layerzero/polygon
	make git-diff before=etherscan/rev2/current/adapters/layerzero/mainnet/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol after=etherscan/rev2/new/adapters/layerzero/mainnet/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol out=rev2/layerzero/mainnet
	make git-diff before=etherscan/rev2/current/adapters/layerzero/mainnet_gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol after=etherscan/rev2/new/adapters/layerzero/mainnet/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol out=rev2/layerzero/mainnet_gnosis
	make git-diff before=etherscan/rev2/current/adapters/layerzero/binance/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol after=etherscan/rev2/new/adapters/layerzero/binance/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol out=rev2/layerzero/binance
	make git-diff before=etherscan/rev2/current/adapters/layerzero/gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol after=etherscan/rev2/new/adapters/layerzero/gnosis/LayerZeroAdapter/src/contracts/adapters/layerZero/LayerZeroAdapter.sol out=rev2/layerzero/gnosis



generate-diffs :;
	make get-current-ccip-adapers
	make get-new-ccip-adapers
	make get-current-ccc-impl
	make get-new-ccc-impl
	make diff-ccip
	make diff-ccc-impl