# Introduction

<!-- Introduce:

 - Blockchain / Ethereum (briefly)
 - Define Tokens, ERC20, the need for a new standard
 - Introduce ERC777 
 - Define payment channels and reason for existence, use as credit card
 - Define loyalty points for credit cards -->

## Motivation

Ethereum is a new blockchain inspired by Bitcoin, with the design goal of abstracting away transaction complexity and allowing for easy programatic interaction through the use of a Virtual Machine and relying upon the state of this Virtual Machine rather than dealing with transaction outputs; transactions simply modify the state.

This idea of a global computer allows one to write a program, hereinafter a Smart Contract, which interacts with the EVM and inherits the safety properties of the Ethereum system (and also its limitations).  Essentially it is a very low power/capacity computing platform with interesting safety properties (such as operations and state data being essentially immutable once a transaction is included in the blockchain [with sufficient confirmations as its probabilistic after all].  This is ideally suited to small minimalistic programs governing essential data, such as a ledger of transactions.

One such example of smart contracts is the ERC20 token standard (there are varying smart contract implementations).  This is likely the most widely deployed smart contract on Ethereum.  One issue is the design of ERC20.  The way to transfer tokens to an externally owned address or to a contract address differ and transferring tokens to a contract assuming it is a regular address can result in losing those tokens forever.  This also limits the way smart contracts can interact with ERC20 tokens and adds complexity to the \gls{ux}.

The new ERC777 token standard solves these problems and offers new powerful features which facilitate new interesting use cases for tokens.

## Description Of The Work

This thesis starts by explaining the Ethereum ecosystem and the concept of tokens on the blockchain as well as the application of tokens in Ethereum, the ERC20 token standard and its limitations. It is followed by a detailed description of the new ERC777 standard \citep{erc777} for tokens and the ERC820 Pseudo-introspection registry\citep{erc820}, developed as part of this thesis. This includes how the issues of ERC20 are solved, the improvements brought by ERC77, the efforts made to advertise the standard to the community and how community's reception and feedback was taken into account to developed the standard. Finally we provide an analysis of the ERC223 and ERC827 token standards proposals---which are  alternatives to ERC777---and their drawbacks.
