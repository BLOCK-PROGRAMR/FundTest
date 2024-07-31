## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
# how to build forge create --rpc-url http://127.0.0.1:8545 --private-key <privatekey> <contract>
# forge create --rpc-url <URL> --private-key <RAW_PRIVATE_KEY> <CONTRACT>

# forge create Counter --interactive
# forge script script/Counter.s.sol
# forge script script/Counter.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a --broadcast
# converting numbers
     cast --to-base <hexnumber> dec


# steps to deploy the contract:
  # 1.forge compile (compile all contracts in the src)
  # 2. forge test  (test all contract in the test)
  # 3 deploy:
# source .env
# echo $RPC_URL
# forge script script/Counter.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast

# cast commands
# cast send 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 "setNummber(uint256)" 15 --rpc-url $RPC_URL --private-key $PRIVATE_KEY 
# cast call <Contract addr> "funcionname(parameter type)(return type)" --rpc-url $RPC_URL when we can read only the contract we cant use private key

# 0xf25Bf6aae92B87894c41491Bd69dEcA569c2f4DE --seplia address to see the transacttion


# how to install the chainlink interfaces
   # forge install https://github.com/smartcontractkit/chainlink-brownie-contracts@1.2.0  --no-commit


# * Network: Sepolia
     
// eth/usd addr:0x694AA1769357215DE4FAC081bf1f309aDC325306


# forge test --match-path test/FundMe.t.sol 
#  forge test --match-path test/FundMe.t.sol --match-test test_Number -vv