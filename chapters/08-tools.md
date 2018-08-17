# The State Of Tooling

The Ethereum ecosystem is still very new as a result the specific tools and libraries required are also either in there infancy or lacking. The existing tools and libraries are often still in alpha, beta or zero prefixed versions---Solidity itself is only at version `0.4`. This means they are often unstable, and with changing interfaces. The Ethereum in some respect tries to build a newer and more decentralized web, this is why the main library is called \gls{web3} and the most mature version of it is written in JavaScript. A lot of the tooling is written using \gls{node}. Reminiscent of the JavaScript ecosystem, the Ethereum ecosystem moves fast, even faster than JavaScript's, and the language syntax, tools and libraries are constantly changing.

## Compilation

The Solidity Compiler named `solc` is written in C++ but JavaScript bindings named `solcjs` and using the \gls{emscripten} binaries for `solc` are often used. Both `solc` and `solcjs` are limited and many wrappers around have been build to make the development life easier. Examples include Consensys' `truffle`, 0xproject's `sol-compiler` and Giveth's `solcpiler`.

A lot of these wrappers add features such as partial recompilation by only recompiling contracts which have changed, setting the version of Solidity to use for the compilation and more. The `truffle` suite includes more than a simple wrapper around `solcjs` and includes migration logic for smart contracts as well as a testing framework. Ultimately, we had to use `truffle` at the time as it offered one of the only coverage tool for the test of the ERC777 reference implementation.

In comparison for the ERC820 registry, Giveth's `solcpiler` is used as it provides us with a greater control over the compilation process which is important as it is important to have reproducible builds such that people can compile the source code on their own and obtain the same bytecode in order to convince themselves that the deployed bytecode matches the source file. The `solcipiler` is also a good example of the infancy of tools in the Ethereum ecosystem. During the process of obtaining reproducible builds with the exact same bytecode, we identified five issues and solved three of them through five issues and three pull requests.

## Testing and Coverage

With ERC777, the testing framework of `truffle` is also problematic and their "clean-room" feature which reverts the state after each unit test---thus isolating the state of each test---did not work fully and parts of the states were sometimes not reverted. The `truffle` suite overall has lots of nice features but hides a lot from the developer. Ultimately it is a nice to quickly test a feature or to perform quick experiments but it is less suitable for production software.

It was then the only framework which allowed us to quickly test and provide coverage information and the hope was that we would be able to work around the limitation of the framework. Over time we realized that it would be simpler to switch back to another tool such as `solcpiler`, provide a custom setup for the test suites and use an alternative tool for coverage such as 0xproject's `sol-cov`.

## Documentation

The Ethereum Foundation defines a syntax for documenting the code, named "natspec" \citepalias[see]{natsepc}. The `solc` compiler is then able to extract the documentation from the code and return as part of the standard output file, a \gls{json} version of the documentation together with a neatly parsed version of the function signature.

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

Unfortunately there is no easy-to-use tool to generate a nice HTML version of the documentation from such \gls{json} data. One such tool exists, `doxity` but it has fallen victim to the fast changing Ethereum Ecosystem. The `doxity` tool has not received an update for almost a year and does not support code written for Solidity greater than version `0.4.18` which is much older than the current `0.4.24` version.

The lack of a proper tool for the generation of documentation is the main reason for the absence of documentation regarding the ERC777 reference implementation.

## Missing Tools

Some tools are still missing and one which became apparent during the development of the ERC777 reference implementation is a gas profiler. That is a tool which is easily and automatically able to provide us with information regarding the gas consumption of each functions. We do have a general idea of the gas consumption and a manual comparison of the code can give us an estimate of whether ERC777 consume more gas than ERC20 for example. Nonetheless it is difficult to have accurate value and to offer precise claims regarding gas consumption which would be an invaluable asset.

Optimally it would be interesting---and not just for ERC777---to have gas consumption both from a static and dynamic point of view. That is to develop a gas analysis tool able to do a perform both a static analysis and a dynamic one---somewhat similar to the `eth_estimateGas` RPC call---of the source code.
