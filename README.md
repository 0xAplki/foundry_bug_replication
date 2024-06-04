## What is this script

We are noticing some weird behavior whereby in some chains the address computed and returned by the ComposableStablePoolFactory is
different than the one that is actually deployed and emitted in the pool creation event.

This happens intermittently. See this asciinema for reference: https://asciinema.org/a/EJNtfBkOVtlD3OdLUHgOh5e4t

## How to run this script against mainnet fork

```sh
forge install

# start anvil forking mainnet
# NB: if you prefer another RPC url see https://chainlist.org/chain/1
anvil --rpc-url wss://ethereum-rpc.publicnode.com

# in a different terminal
forge script script/BugReplication.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --skip-simulation -vvvvv

```
