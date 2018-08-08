# Introduction

<!-- Introduce:

 - Blockchain / Ethereum (briefly)
 - Define Tokens, ERC20, the need for a new standard
 - Introduce ERC777 
 - Define payment channels and reason for existence, use as credit card
 - Define loyalty points for credit cards -->

## Motivation

Ethereum is a custom built blockchain which provides a decentralized computing platform.
Ethereum is decentralized platform running on a custom built blockchain.
Similarly to Bitcoin and other blockchains it suffers of a few issues. One of the most prominent one being the slow transaction speed. The Ethereum network can handle at best 15 transactions per second---Bitcoin is even worse with 3 or 4 transactions per second---which is clearly insufficient for a global daily usage. By comparison, VisaNet is theoretically capable to handle up to 65'000 transactions per second. While this number is disputed, even the more realistic value of 1700 transactions per second is well above the Ethereum blockchain capacity. Ethereum is still immature and a lot is still left to do; payment channels is one of the effort to increase the number to transactions processed per second. Originating from Bitcoin's lighting network, payment channels rely on exchanging off-chain transactions and only use the blockchain as a safeguard or to settle the past off-chain transactions. Smart contracts in Ethereum are leveraged for more exhaustive and flexible channels---compared to Bitcoin's---which can accept both Ether and tokens, allow top-ups and more.

Another issue, specifically associated with Ethereum, is related to the design of ERC20, the token standard. The way to transfer tokens to an externally owned address or to a contract address differ and transferring tokens to a contract assuming it is a regular address can result in losing those tokens forever.

The new ERC777 token standard solves those problems and offer new powerful features which facilitates new interesting use cases for tokens.

## Description Of The Work

This thesis starts by covering the overall mechanism of Ethereum payment channels and details the contributions to improve the existing payment channel proof of concept to bring it closer to a safe production ready system. Ethereum payment channels have the ability to interact with tokens, both as the asset of the channel but also within a trustless reward system based on the usage of said channel.

Subsequently, an analysis of tokens is provided to explain the application of tokens in Ethereum, the ERC20 token standard and its issues. It is followed by a detailed description of the new ERC777 standard for tokens, developed as part of this thesis. This includes how the issues of ERC20 are solved, the improvements brought by ERC77, the efforts made to advertise the standard to the community and how community's reception and feedback was taken into account to developed the standard.
