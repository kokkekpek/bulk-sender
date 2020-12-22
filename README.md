# BulkSender

## Deploy
```sh
solc BulkSender.sol
tvm_linker compile BulkSender.code -o BulkSender.tvc
tonos-cli genaddr BulkSender.tvc BulkSender.abi.json --genkey BulkSender.keys.json
tonos-cli deploy BulkSender.tvc {} --abi BulkSender.abi.json --sign BulkSender.keys.json
```

## Call example
### Transfer 0.1💎 and 0.2💎 with "Hi" message
```sh
tonos-cli call "0:ea109b5c4fbe2d12065fefdadf54f3127c4281ebe702fe9f12c75abf833545b8" transfer '{"destinations":["0:d6bfb70f82306591f7e7ad38e2cb08a0f58f3a93bf8044863c4ad70237e5f448","0:d6bfb70f82306591f7e7ad38e2cb08a0f58f3a93bf8044863c4ad70237e5f448"],"values":[100000000, 200000000],"message":[]}' --abi BulkSender.abi.json --sign BulkSender.keys.json
```

### Destroy
```sh
tonos-cli call "0:ea109b5c4fbe2d12065fefdadf54f3127c4281ebe702fe9f12c75abf833545b8" destroy {"destinations":"0:d6bfb70f82306591f7e7ad38e2cb08a0f58f3a93bf8044863c4ad70237e5f448"}' --abi BulkSender.abi.json --sign BulkSender.keys.json
```

### sendTransaction
```sh
tonos-cli call "0:ea109b5c4fbe2d12065fefdadf54f3127c4281ebe702fe9f12c75abf833545b8" sendTransaction '{"destinations":"0:d6bfb70f82306591f7e7ad38e2cb08a0f58f3a93bf8044863c4ad70237e5f448","value":100000000}' --abi BulkSender.abi.json --sign BulkSender.keys.json
```

## Deployment tools
[TON Solidity Compiler](https://github.com/tonlabs/TON-Solidity-Compiler)
```
solc, the solidity compiler commandline interface
Version: 0.6.3-develop.2020.12.13+commit.54c8a5a1.mod.Linux.g++
```

[TVM linker](https://github.com/tonlabs/TVM-linker)
```
TVM linker 0.1.0
COMMIT_ID: 2e15070e458637add2ecb279a03bd88d8df37bde
BUILD_DATE: 2020-12-13 03:25:46 +0300
COMMIT_DATE: 2020-11-20 10:57:07 +0300
GIT_BRANCH: master
```

[tonos-cli](https://github.com/tonlabs/tonos-cli)
```
tonos_cli 0.1.28
COMMIT_ID: a389881108384118ba1a565a0450762fdabeb705
BUILD_DATE: 2020-12-13 03:41:14 +0300
COMMIT_DATE: 2020-11-30 17:42:19 +0300
GIT_BRANCH: master
```