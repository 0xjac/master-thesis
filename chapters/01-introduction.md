# Introduction

<!-- Introduce:

 - Blockchain / Ethereum (briefly)
 - Define Tokens, ERC20, the need for a new standard
 - Introduce ERC777 
 - Define payment channels and reason for existence, use as credit card
 - Define loyalty points for credit cards -->

## Motivation

Ethereum is a new blockchain inspired by Bitcoin, with the design goal of abstracting away transaction complexity and allowing for easy programatic interaction through the use of a Virtual Machine. One issue is the design of ERC20, the token standard. The way to transfer tokens to an externally owned address or to a contract address differ and transferring tokens to a contract assuming it is a regular address can result in losing those tokens forever.

The new ERC777 token standard solves those problems and offer new powerful features which facilitates new interesting use cases for tokens.

## Description Of The Work

This thesis starts by explaining the Ethereum ecosystem and the concept of tokens on the blockchain as well as the application of tokens in Ethereum, the ERC20 token standard and its limitations. It is followed by a detailed description of the new ERC777 standard \citep{erc777} for tokens and the ERC820 Pseudo-introspection registry\citep{erc820}, developed as part of this thesis. This includes how the issues of ERC20 are solved, the improvements brought by ERC77, the efforts made to advertise the standard to the community and how community's reception and feedback was taken into account to developed the standard. Finally we provide an analysis of the ERC223 and ERC827 token standards proposals---which are  alternatives to ERC777---and their drawbacks.
