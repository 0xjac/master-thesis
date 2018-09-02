# Ethereum, A Decentralised Computing Platform

The Ethereum network is a decentralised computing platform. As described in its the white paper, Ethereum "[...] is essentially the ultimate abstract foundational layer: a blockchain with a built-in Turing-complete programming language, allowing anyone to write smart contracts and decentralized applications where they can create their own arbitrary rules for ownership, transaction formats and state transition functions" \citep{buterin2013whitepaper}. This differentiates Ethereum from Bitcoin which is a trustless peer-to-peer version of electronic cash and lacks a Turing-complete language.

## The Ether Currency And Gas

The Ethereum still includes its own built-in currency named ether akin to Bitcoin. It "[...] serves the dual purpose of providing a primary liquidity layer to allow for efficient exchange between various types of digital assets and, more importantly, of providing a mechanism for paying transaction fees" \citep{buterin2013whitepaper}. The currency comes with different denominations defined. The smallest denomination is a wei---named after the computer scientist and inventor of b-money, Wei Dai. An ether is defined as 10^18^ wei. In other words, a wei represents 0.000000000000000001 ethers. The wei denomination is used for technical discussions and internal representation of the data. Most tools, libraries and smart contracts use wei, and the values are only converted to ether or some other denomination for the end-user.

### Computing Fees

The fees are part of the incentive mechanism as in Bitcoin. The main difference is the way the fees are expressed and computed. In Bitcoin, the fees are fixed and set as the difference between the input value and the output value. Because transactions on the Ethereum network execute code of a Turing-complete language, the fee is defined differently "[...] to prevent accidental or hostile infinite loops or other computational wastage in code" \citep{buterin2013whitepaper}. A transaction defines two fields `STARTGAS` and `GASPRICE`. The `STARTGAS`---also referred as just `gas` or `gasLimit`---is the maximum amount of gas the transaction may use. The `GASPRICE` is the fee the sender will pay per unit of gas consumed. Essentially, the fees are a limitation on the Turing-completeness. While the language is Turing-complete, the execution of the program is limited in its number of steps. In essence, fees are not only a part of the incentive mechanism but are also an anti-spam measure as every extra transaction is a burden on everyone in the network, and it would be effectively free to grief the network if there were no fees.

A computational step cost roughly one unit of gas. This is not exact as some steps "cost higher amounts of gas because they are more computationally expensive, or increase the amount of data that must be stored as part of the state" \citep{buterin2013whitepaper}. A cost of five units of gas per byte is also applied to all transactions.

Another advantage of not tightly coupling the cost of execution with a currency---e.g. set the cost of a computation step to three wei---is to dissociate the execution cost of a transaction and the fluctuation in value of ether with respect to fiat currencies. If the price of ether increases exponentially with respect to a currency such as the dollar, a fixed price per computational step may become prohibitive. The `GASPRICE` circumvent this issue. While the amount of gas consumed by the transaction will remain constant, the price for the gas can be reduced.

## Ethereum Accounts

There are two types of accounts on the Ethereum network, externally owned accounts---commonly referred to as regular accounts---and contract accounts. A regular account is an account controlled by a human who holds the private key needed to sign transactions. In contrast, a contract account is an account where no individual knows the private key. The account can only send its ether and call functions of other accounts through its associated code. While an account is defined as "having a 20-byte address and state transitions being direct transfers of value and information between accounts" \citep{buterin2013whitepaper}, the words "account" and "address" are often used interchangeably. Nonetheless, to be exact, an account is defined in the white paper \citep{buterin2013whitepaper} as a set of four fields:

\begin{description}
\item[Nonce]: A counter used to make sure each transaction can only be processed once
\item[Balance]: The account's current ether balance
\item[Code]The account's contract code, if present (for contracts)
\item[Storage]: The account's permanent storage (empty by default)
\end{description}

## Transactions And Messages

Ethereum makes a distinction between a transaction and a message. A transaction is a signed data packet only emitted from a regular account. This packet contains the address of a recipient, a signature to identify the sender, the amount of ether sent from the sender to the recipient a data field---which is optional and thus may be empty---and both the gas price, and the gas limit---whose meanings are explained in section \ref{computing-fees}.

A message is defined as a "virtual objects that are never serialized and exist only in the Ethereum execution environment" \citep{buterin2013whitepaper}. A message contains the sender and recipient, the amount of ether transfer with the message from the sender to the recipient, an optional potentially empty data field, and a gas limit.

Transactions and messages are very similar. The difference is that a transaction comes from a regular account only and a message comes from a contract. A transaction can call a function of a contract which in turn can create a message and call another function, either on itself or on another contract, using the `CALL` and `DELEGATECALL` opcodes. The gas used for messages comes from the transaction which triggered the call.

## The Ethereum Virtual Machine

Ethereum is a decentralised computing platform. In other words alongside a blockchain, Ethereum provides a Turing-complete language and the \gls{evm}, a virtual machine able to interpret and execute code. This code "is written in a low-level, stack-based bytecode language, referred to as "Ethereum virtual machine code" or "EVM code"\citep{buterin2013whitepaper}. This bytecode is represented by a series of bytes. The execution of code consists of first setting an instruction pointer at the beginning of the bytecode sequence, next process the operation at the current location of the point, and last increment the instruction pointer to the next byte. Those steps repeated forever until either the end of the bytecode sequence is reached, an error is raised or a `STOP` or `RETURN` instruction is executed.

The operations can perform computations and interact with data. There are three kinds of mediums to store data. First, there is a stack. This a commonly know abstract data type in computer science. Data can be added by using a push operation which adds the data on top of the stack. Mutually, the data can then be removed with a pop operation which removes and return the data from the top of the stack. Mainly, the stack is known as a \gls{lifo} data structure meaning the last value pushed (added) is the first value popped (taken). Secondly, there is a memory, which is an ever-expandable array of bytes. Those kinds of storage are both non-persistent storage. Within the context of Ethereum, this translates to this data only being available within the call or transaction and not being permanently stored on the blockchain. The third and last kind of storage is commonly referred to as "storage" is a permanent key/value store intended for long-term storage.

In addition to those types of storage, the code may access the block header data, and the incoming transaction's sender address, value, and data field.


## Solidity

While smart contracts are deployed in \gls{evm} bytecode format, they are generally almost never written in this format but in a higher language instead. Solidity and `solc`---the Solidity compiler---currently being developed by the Ethereum Foundation is the most popular smart contract language. In their own words:

> Solidity is a contract-oriented, high-level language for implementing smart contracts. It was influenced by C++, Python and JavaScript and is designed to target the Ethereum Virtual Machine (EVM).
>
> Solidity is statically typed, supports inheritance, libraries and complex user-defined types among other features. \flushright \citepalias{soldoc}

All of the contract code written for this thesis is written in Solidity and takes advantage of many of the aspects of the language, such as inheritance and modifiers. The following is a collection of relevant features or issues associated with the Solidity language which are needed to understand the code related to this thesis fully.

### State Variables

State variables are variables whose values are permanently stored with the contract, i.e. the state variables are located in the storage. The state variables are part of the state of the contract and transaction---which have to pay gas---can modify the state of the contract by executing code which modifies those state variables.

### Function Modifiers

Function modifiers are specific functions associated with the regular functions of a contract. The modifiers are called before the actual function and thus have the ability to change the behaviour of the function. They are very popular to provide access-control to functions which use should be limited according to specific conditions.

```{caption="OpenZepplin's implementation of the \texttt{onlyOwner} modifier which restrict the access to the owner of the contract." label="lst:OZOnlyOwner" language=Solidity}
/**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}
```

The listing \ref{lst:OZOnlyOwner} shows the implementation of a modifier which uses `require` to revert the transaction if the condition is not met and the strange `_;` syntax which is replaced with the bytecode of the function the modifier is associated with during the call of the actual function.

### Events

Events are an interface in Solidity to interact with the \gls{evm} logging facilities. The central aspect of events to remember is that they emitted by a contract but contracts are not able to listen for events. Events are intended for \glspl{dapp} which listen to specific events and for example can trigger actions or updates on their interface.

### View Functions

View functions in Solidity are defined as function which do not modify the state. As defined in the Solidity documentation \citepalias{soldoc}, modifying the state implies one of:

1. Writing to state variables.
2. Emitting events.
3. Creating other contracts.
4. Using `selfdestruct`.
5. Sending Ether via calls.
6. Calling any function not marked view or pure.
7. Using low-level calls.
8. Using inline assembly that contains certain opcodes.

Note that the solidity compiler will automatically generate getter functions for public state variables that is view functions with the same names as the variables return the value of the state variables. For example in the listing \ref{lst:owner}, the Solidity compiler will generate a getter named `owner()` for the public state variable `owner`.

### The `require` Instruction

The Solidity instruction `require` reverts the transaction if its parameter is false and continues the execution if the parameter is true. Most commonly, a condition is evaluated and passed as a parameter to `require`. If the condition is false, `require` will call the `REVERT` \gls{evm} opcode which stops the execution of the transaction without consuming all of the gas and revert the state changes.

### The `msg` Variable

The `msg` variable is globally available and contains multiple attributes:

\begin{description}
\item[msg.data]: The complete call data in \texttt{bytes}.
\item[msg.gas]: The remaining gas available for the transaction as an unsigned integer (\texttt{uint}).
\item[msg.sender]: The address of the sender of the message (i.e. the current call).
\item[msg.sig]: The first four bytes of the call data (i.e. the function identifier) in \texttt{bytes4}.
\item[msg.value]: The number of wei sent with the message as an unsigned integer (\texttt{uint}).
\end{description}

Note that the attributes---including `msg.sender` and `msg.value`---can change for external calls. This means, for example, that if a regular account Alice, calls a contract Carlos, Carlos will see Alice's address as the `msg.sender`. Next if Carlos makes a call to Carole, another contract, Carole will see the address of Carlos---not Alice---as the `msg.sender`.

### Fallback Function

Every contract is allowed to have at most one unnamed function which is referred to as the "fallback function". This fallback function is called if the transaction contains no data---which contains the id of the function to call---or if the id provided in the data does not match any function of the contract.

The fallback function is also limited to only 2300 gas for its execution.


## Visualising Transactions And Interactions

There is no standard notation---specific to Ethereum---to visualise the interaction between different entities or to illustrate a transaction between multiple parties. Despite, there exists more generic notations such as the \acrfull{uml} which is well know by virtually every software engineer and include sequence diagrams to depict the interactions between various entities over time.

In this thesis, we will use a customised version of \gls{uml} sequence diagrams to illustrate transactions and calls between addresses---both regular accounts and contracts---on the Ethereum Network. This modified version of sequence diagrams includes colouring of the messages exchanged and activation boxes to indicate the type of communication taking place. Specifically, off-chain communications are painted green, Ethereum transactions for which the sender must pay gas and which are asynchronous in nature, are coloured in red and finally calls, either as part of a transaction or on its own is represented in blue.

Moreover, if the execution of a transaction is stopped erroneously because of a revert or a throw, the transaction will have a return arrow with the word `REVERT` or `THROW` accordingly. Note that the transaction, in practice, does not return this information. The transaction is minded similar to any other transaction and it is only once the transaction receipt is recovered that one can see if the transaction was reverted, thrown, or executed successfully.

Finally, to help with clarity, some of the parameters of functions may be omitted and the name of an entity may be used for parameters instead of its Ethereum addresses as it would in an actual transaction. Contracts are represented by object symbols and regular accounts by actor symbols, the class attribute for contracts may be an interface implemented by the contract or the role of the contract. For actors, the class attribute---if present---always indicates the role of the actor.


As an example let use consider the example code for a centralised administrator from the Ethereum website \citep{ethowner}---shown in the listing \ref{lst:owner}.

```{caption="Centralised administrator contract, example from the Ethereum Foundation website." label="lst:owner" language=Solidity}
contract owned {
    address public owner;

    function owned() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }
}
```

The figure \ref{fig:uml} illustrate a modified \gls{uml} diagram between two regular accounts---Alice and Bob---and the contract Carlos implementing the centralised administrator---whose code is written in the listing \ref{lst:owner}. In the depicted scenario, Alice is the current owner of Carlos. She begins by making a transaction which calls `transferOwnership` on Carlos which first verifies if Alice is the current owner thanks to the `onlyOwner` modifier and then update the state of Carlos to set Bob as the new owner of the contract.

\input{fig/umlexample}

Next, Alice can inform Bob off-chain that he became the new owner of Carlos. Bob can verify this claim easily by calling the `owner` function---which was automatically generated from the public state variable: `owner`.

Finally, for illustrative purposes, Alice, tries to set herself back as the owner by calling `transferOwnership` again. Be that as it may, Alice is not the current owner of Carlos and this time the `onlyOwner` modifier fails and causes the transaction to revert.
