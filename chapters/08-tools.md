# The State Of Tooling In The Ethereum Ecosystem

The Ethereum ecosystem is still very new as a result the specific tools and libraries required are also either in their infancy or lacking. The existing tools and libraries are often still in alpha, beta or zero prefixed versions---Solidity itself is only at version `0.4`. This means they are often unstable, and with changing interfaces. The Ethereum in some respect tries to build a newer and more decentralised web, this is why the main library is called \gls{web3}, and the most mature version of it is written in JavaScript. A lot of the tooling is written using \gls{node}. Reminiscent of the JavaScript ecosystem, the Ethereum ecosystem moves fast, even faster than JavaScript's, and the language syntax, tools and libraries are constantly changing.

## Compilation

The Solidity Compiler named `solc` is written in C++, but JavaScript bindings named `solcjs` and using the \gls{emscripten} binaries for `solc` are often used. Both `solc` and `solcjs` are limited, and many wrappers around have been built to make the development life easier. Examples include Consensys' `truffle`, 0xproject's `sol-compiler` and Giveth's `solcpiler`.

A lot of these wrappers add features such as partial recompilation by only recompiling contracts which have changed, setting the version of Solidity to use for the compilation and more. The `truffle` suite includes more than a simple wrapper around `solcjs` and includes migration logic for smart contracts as well as a testing framework. Ultimately, we had to use `truffle` at the time as it offered one of the only coverage tools for the test of the ERC777 reference implementation.

In comparison for the ERC820 registry, Giveth's `solcpiler` is used as it provides us with a greater control over the compilation process which is a critical aspect as it is paramount to have reproducible builds such that people can compile the source code on their own and obtain the same bytecode in order to convince themselves that the deployed bytecode matches the source file.

> Tools such as drawbridge which provide deterministic builds are critical for wallets and similar applications to ensure verifiable security. \flushright (Daniel Ternyak, CEO of grant.io,  
former CTO of MyEtherWallet & MyCrypto)

The `solcpiler` is also a good example of the infancy of tools in the Ethereum ecosystem. During the process of obtaining reproducible builds with the exact same bytecode, we identified five problems and solved three of them through five GitHub issues\footnote{\url{https://github.com/Giveth/solcpiler/issues/11}}\footnote{\url{https://github.com/Giveth/solcpiler/issues/13}}\footnote{\url{https://github.com/Giveth/solcpiler/issues/15}}\footnote{\url{https://github.com/Giveth/solcpiler/issues/17}}\footnote{\url{https://github.com/Giveth/solcpiler/issues/18}} and four pull requests\footnote{\url{https://github.com/Giveth/solcpiler/pull/12}}\footnote{\url{https://github.com/Giveth/solcpiler/pull/14}}\footnote{\url{https://github.com/Giveth/solcpiler/pull/16}}\footnote{\url{https://github.com/Giveth/solcpiler/pull/20}}\hspace{0cm}.

## Testing and Coverage

With ERC777, the testing framework of `truffle` is also problematic and their "clean-room" feature which reverts the state after each unit test---thus isolating the state of each test---did not work adequately, and parts of the states were sometimes not reverted. The `truffle` suite overall has lots of nice features but hides a lot from the developer. Ultimately it is nice to test a feature quickly or to perform quick experiments, but it is less suitable for production software.

It was then the only framework which allowed us to test and provide coverage information quickly and the hope was that we would be able to work around the limitation of the framework. Over time we realised that it would be simpler to switch back to another tool such as `solcpiler`, provide a custom setup for the test suites and use an alternative tool for coverage such as 0xproject's `sol-cov`.

## Documentation

The Ethereum Foundation defines a syntax for documenting the code, named "natspec" \citepalias[see]{natspec}. The `solc` compiler is then able to extract the documentation from the code and return as part of the standard output file, a \gls{json} version of the documentation together with a neatly parsed version of the function signature. The appendix \ref{lst:erc820doc} x the raw \gls{json} data containing the documentation---as output by `solc`---for the ERC820 registry.

Unfortunately, there is no easy-to-use tool to generate a nice HTML version of the documentation from such \gls{json} data. One such tool exists, `doxity` but it has fallen victim to the fast-changing Ethereum Ecosystem. The `doxity` tool has not received an update for almost a year and does not support code written for Solidity greater than version `0.4.18` which is much older than the current `0.4.24` version.

The lack of a proper tool for the generation of documentation is the main reason for the absence of documentation regarding the ERC777 reference implementation.

## Gas Profiler

Some tools are still missing, and one which became apparent during the development of the ERC777 reference implementation is a gas profiler. That is a tool which is quickly and automatically able to provide us with information regarding the gas consumption of each function. We do have a general idea of the gas consumption, and manual comparison of the code can give us an estimate of whether ERC777 consume more gas than ERC20 for example. Nonetheless, it is difficult to have accurate value and to offer precise claims regarding gas consumption which would be an invaluable asset.

Optimally it would be interesting---and not just for ERC777---to have gas consumption both from a static and dynamic point of view. That is to develop a gas analysis tool able to do a perform both a static analysis and a dynamic one---somewhat similar to the `eth_estimateGas` RPC call---of the source code.

### Dynamic Analysis

It should be rather straightforward to create a profiler which performs a dynamic analysis. A simple script which can gather (or even generate) a collection of inputs and then call `eth_estimateGas` would be sufficient. The idea is trivial, and the primary focus during the development of such a tool would be the ease of use and the deployment of the code to profile.

Moreover, most developers can perform a manual dynamic analysis of their code by merely writing test cases (with hard-coded values) which call `eth_estimateGas` and log the values. This approach is even more trivial and a simple library to reduce the boilerplate code needed can also help speed up the analysis.

Overall, a dynamic analysis of gas usage is an interesting metric which provides valuable data on the simulated real-life use cases of the code.


### Static Analysis

Implementing a profiler capable of performing a static analysis of the code to evaluate gas consumption is a more complicated task. First no existing tool---such as the `eth_estimateGas` for dynamic analysis---exists.

Second, unlike a dynamic approach which is trivially capable of returning the gas consumption as a single number given the parameters, a static tool may not be able to do so. For example if the code contains an iteration over an array whose length is not known at compile time, then the gas consumption will be expressed as a formula like $X + n \cdot Y$ where $X$ is the gas used by the code outside the iterations, $n$ represents the number of iterations and $X$ is the gas used by a single iteration. Note that the values of $X$ and $Y$ are computed by the tool, but the value of $n$ is never known, an actual example (in wei) could be $29000 + n \cdot 3700$.

> We need tools such as a static gas profiler. It is a project I would be happy to support. \flushright (Daniel Ternyak, CEO of grant.io,  
former CTO of MyEtherWallet & MyCrypto)

Third, one of the most interesting features of a static analysis is to have a comprehensive picture of the code which shows precisely how much gas each instruction takes. The Ethereum yellow paper specifies the gas cost of each instruction in the \gls{evm}\citep[see][appendix G. Fee schedule]{yellowpaper}. However these costs are for the \gls{evm} bytecode, not the higher languages such as Solidity used by most developers. Hence for the tool to be useful, a mapping back to Solidity must be implemented. Some interface must be designed as well to be able to display the results to the developer.

Mainly, a profiler able to perform a static analysis of gas consumption may not be as simple as it first appears but it is a tool which is lacking, and there is an apparent interest from the community to be able to use such a tool.
