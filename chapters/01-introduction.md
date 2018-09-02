# Introduction

<!-- Introduce:

 - Blockchain / Ethereum (briefly)
 - Define Tokens, ERC20, the need for a new standard
 - Introduce ERC777 
 - Define payment channels and reason for existence, use as credit card
 - Define loyalty points for credit cards -->

## Motivation

Ethereum is a new blockchain inspired by Bitcoin, with the design goal of abstracting away transaction complexity and allowing for easy programmatic interaction through the use of a Virtual Machine and relying upon the state of this Virtual Machine rather than dealing with transaction outputs; transactions merely modify the state.

This idea of a global computer allows one to write a program, hereinafter a Smart Contract, which interacts with the EVM and inherits the safety properties of the Ethereum system (and also its limitations). Essentially it is a very low power/capacity computing platform with interesting safety properties (such as operations and state data being essentially immutable once a transaction is included in the blockchain [with sufficient confirmations as its probabilistic after all]. This is ideally suited to small minimalistic programs governing essential data, such as a ledger of transactions.

One such example of smart contracts is the ERC20 token standard (there are varying smart contract implementations). This is likely the most widely deployed smart contract on Ethereum. One issue is the design of ERC20. The way to transfer tokens to an externally owned address or to a contract address differs and transferring tokens to a contract assuming it is a regular address can result in losing those tokens forever. This consequence limits the way smart contracts can interact with ERC20 tokens and adds complexity to the \gls{ux}.

The new ERC777 token standard solves these problems and offers new powerful features which facilitate new exciting use cases for tokens.

## Objective Of The Thesis

Our objective is to identify and describe the current issues and shortcomings of Ethereum's ERC20 token standard in order to create the more advanced token standard, ERC777 which not only solves the drawbacks of ERC20 but provide new powerful features which facilitates new exciting use cases for tokens. The goals include better safety for token holders, improved usability, enhanced and more complex interactions between parties when creating exchanging and destroying tokens, and last but not least, a wide adoption by the Ethereum community.

A part of this thesis' objective is to provide, as well, a reference implementation of the ERC777 advanced token standard which is not only used as an example but provides a modular structure such that token designers are able to build their own token on top of the reference implementation, thusly avoiding common programming mistakes.

## Challenges

Writing a standard requires the ability to define specifications which are not constrained to a single use case [TODO> fix that>] but to many various ones. Therefore on one hand, the standard needs to be generic enough to be adopted and used by a large number of people. On the other hand its definition needs to be precise and explicit enough to avoid any ambiguities, conflicting conditions and undefined scenarios which are a recipe for disaster. The language of the standard must also be clear but succinct and easily understandable by non-native and non-proficient speakers.

Finally, the core goal of the standard is to be accepted and used by as many members of the Ethereum community as possible. We decided the best approach to tackle this challenge is to build the standard with the community as much as possible by asking for their thoughts and feedback and incorporate it in the standard as much as possible, as for example with the `tokensToSend` hook.

## Description Of The Work

This thesis begins by explaining the Ethereum ecosystem, the Solidity language   and the concept of tokens on the blockchain as well as the application of tokens in Ethereum, the ERC20 token standard, and its limitations. It is followed by a detailed description of the new ERC777 standard \citep{erc777} for tokens, its reference implementation\citep{erc777impl}, and the ERC820 Pseudo-introspection registry\citep{erc820} developed as part of this thesis. This includes how the issues and limitations of ERC20 are solved, the improvements brought by ERC777, the efforts made to advertise the standard to the community and how community's reception and feedback was taken into account to developed the standard. Finally, we provide an analysis of the ERC223 and ERC827 token standards proposals---which are alternatives to ERC777---and their drawbacks.

> TODO expand. One paragraph per chapter
