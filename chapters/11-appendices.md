\appendix

# The `devdoc` And `userdoc` Raw \acrshort{json} Data Of The ERC820 Registry


```{caption="The \texttt{devdoc} and \texttt{userdoc} in \gls{json} format of the ERC820 registry, extracted from the metadata of the compilation's standard output from the contract." label="lst:erc820doc" language=json}
{
  "devdoc": {
    "author": "Jordi Baylina and Jacques Dafflon",
    "methods": {
      "getInterfaceImplementer(address,bytes32)": {
        "params": {
          "_addr": "Address being queried for the implementer of an interface. (If `_addr == 0` then `msg.sender` is assumed.)",
          "_interfaceHash": "keccak256 hash of the name of the interface as a string. E.g., `web3.utils.keccak256('ERC777Token')`."
        },
        "return": "The address of the contract which implements the interface `_interfaceHash` for `_addr` or `0x0` if `_addr` did not register an implementer for this interface."
      },
      "getManager(address)": {
        "params": {
          "_addr": "Address for which to return the manager."
        },
        "return": "Address of the manager for a given address."
      },
      "implementsERC165Interface(address,bytes4)": {
        "details": "This function may modify the state when updating the cache. However, this function must have the `view` modifier since `getInterfaceImplementer` also calls it. If called from within a transaction, the ERC165 cache is updated.",
        "params": {
          "_contract": "Address of the contract to check.",
          "_interfaceId": "ERC165 interface to check."
        },
        "return": "`true` if `_contract` implements `_interfaceId`, false otherwise."
      },
      "implementsERC165InterfaceNoCache(address,bytes4)": {
        "params": {
          "_contract": "Address of the contract to check.",
          "_interfaceId": "ERC165 interface to check."
        },
        "return": "`true` if `_contract` implements `_interfaceId`, false otherwise."
      },
      "interfaceHash(string)": {
        "params": {
          "_interfaceName": "Name of the interface."
        },
        "return": "The keccak256 hash of an interface name."
      },
      "setInterfaceImplementer(address,bytes32,address)": {
        "params": {
          "_addr": "Address to define the interface for. (If `_addr == 0` then `msg.sender` is assumed.)",
          "_interfaceHash": "keccak256 hash of the name of the interface as a string. For example, `web3.utils.keccak256('ERC777TokensRecipient')` for the `ERC777TokensRecipient` interface."
        }
      },
      "setManager(address,address)": {
        "params": {
          "_addr": "Address for which to set the new manager. (If `_addr == 0` then `msg.sender` is assumed.)",
          "_newManager": "Address of the new manager for `addr`. (Pass `0x0` to reset the manager to `_addr` itself.)"
        }
      },
      "updateERC165Cache(address,bytes4)": {
        "params": {
          "_contract": "Address of the contract for which to update the cache.",
          "_interfaceId": "ERC165 interface for which to update the cache."
        }
      }
    },
    "title": "ERC820 Pseudo-introspection Registry Contract"
  },
  "userdoc": {
    "methods": {
      "getInterfaceImplementer(address,bytes32)": {
        "notice": "Query if an address implements an interface and through which contract."
      },
      "getManager(address)": {
        "notice": "Get the manager of an address."
      },
      "implementsERC165Interface(address,bytes4)": {
        "notice": "Checks whether a contract implements an ERC165 interface or not. The result is cached. If the cache is out of date, it must be updated by calling `updateERC165Cache`."
      },
      "implementsERC165InterfaceNoCache(address,bytes4)": {
        "notice": "Checks whether a contract implements an ERC165 interface or not without using nor updating the cache."
      },
      "interfaceHash(string)": {
        "notice": "Compute the keccak256 hash of an interface given its name."
      },
      "setInterfaceImplementer(address,bytes32,address)": {
        "notice": "Sets the contract which implements a specific interface for an address. Only the manager defined for that address can set it. (Each address is the manager for itself until it sets a new manager.)"
      },
      "setManager(address,address)": {
        "notice": "Sets the `_newManager` as manager for the `_addr` address. The new manager will be able to call `setInterfaceImplementer` for `_addr`."
      },
      "updateERC165Cache(address,bytes4)": {
        "notice": "Updates the cache with whether contract implements an ERC165 interface or not."
      }
    }
  }
}
```

# ERC820 Vanitygen

## Vanitygen Bash Script

```{caption="The bash script used to generate a vanity address for the ERC820 registry." label="lst:vanitygen" language=bash}
#! /bin/bash

rm -rf tmp
mkdir tmp
for i in {0..15}; do
  mkdir -p "./tmp/${i}/contracts"
  cp contracts/ERC820Registry.sol "./tmp/${i}/contracts/"
done

for VALUE in `seq 0 16 32768`; do
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: ${VALUE}/1" \
    tmp/0/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+1))/1" \
    tmp/1/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+2))/1" \
    tmp/2/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+3))/1" \
    tmp/3/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+4))/1" \
    tmp/4/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+5))/1" \
    tmp/5/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+6))/1" \
    tmp/6/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+7))/1" \
    tmp/7/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+8))/1" \
    tmp/8/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+9))/1" \
    tmp/9/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+10))/1" \
    tmp/10/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+11))/1" \
    tmp/11/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+12))/1" \
    tmp/12/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+13))/1" \
    tmp/13/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+14))/1" \
    tmp/14/contracts/ERC820Registry.sol
  sed -i '' -Ee "s/^\/\/ IV:.+$/\/\/ IV: $((${VALUE}+15))/1" \
    tmp/15/contracts/ERC820Registry.sol

  pushd ./tmp/0 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/1 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/2 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/3 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  wait
  pushd ./tmp/4 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/5 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/6 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/7 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  wait
  pushd ./tmp/8 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/9 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts --quiet &
  popd > /dev/null
  pushd ./tmp/10 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts  --quiet &
  popd > /dev/null
  pushd ./tmp/11 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts  --quiet &
  popd > /dev/null
  wait
  pushd ./tmp/12 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts  --quiet &
  popd > /dev/null
  pushd ./tmp/13 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts  --quiet &
  popd > /dev/null
  pushd ./tmp/14 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts  --quiet &
  popd > /dev/null
  pushd ./tmp/15 > /dev/null
  npx solcpiler -i ./contracts/ERC820Registry.sol \
    --solc-version="v0.4.24+commit.e67f0147" \
    --insert-file-names none --output-artifacts-dir artifacts  --quiet &
  popd > /dev/null
  wait

  node mine-info.js "${VALUE}" | tee -a addrs.txt

  rm -rf tmp/0/build tmp/0/artifacts \
    tmp/1/build tmp/1/artifacts \
    tmp/2/build tmp/2/artifacts \
    tmp/3/build tmp/3/artifacts \
    tmp/4/build tmp/4/artifacts \
    tmp/5/build tmp/5/artifacts \
    tmp/6/build tmp/6/artifacts \
    tmp/7/build tmp/7/artifacts \
    tmp/8/build tmp/8/artifacts \
    tmp/9/build tmp/9/artifacts \
    tmp/10/build tmp/10/artifacts \
    tmp/11/build tmp/11/artifacts \
    tmp/12/build tmp/12/artifacts \
    tmp/13/build tmp/13/artifacts \
    tmp/14/build tmp/14/artifacts \
    tmp/15/build tmp/15/artifacts

done

```

## Vanitygen Javascript Info Script

```{caption="The Javascript program called by the ERC820 Vanity generator to find the address of a version of the compiled contract." label="lst:vanitygeninfo" language=JavaScript}
const EthereumTx = require('ethereumjs-tx');
const EthereumUtils = require('ethereumjs-util');

const offeset = parseInt(process.argv[2]);
const rawTx = {
    nonce: 0,
    gasPrice: 100000000000,
    gasLimit: 800000,
    value: 0,
    data: undefined,
    v: 27,
    r: '0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959
F2815B16F81798',
    s: '0x0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaa'
};

for (let i = 0; i < 16; i++) {
  const code = '0x' + require(`./tmp/${i}/artifacts/ERC820Registry.json`).compilerOutput.evm.bytecode.object;
  rawTx.data = code
  const tx = new EthereumTx(rawTx);
  const contractAddr = EthereumUtils.toChecksumAddress(
    '0x' + EthereumUtils.generateAddress('0x' + tx.getSenderAddress().toString('hex'), 0 ).toString('hex')
  );
  if (contractAddr.startsWith('0x820')) {
    console.log(`${offeset + i} -> ${contractAddr}`);
  }
}

```
