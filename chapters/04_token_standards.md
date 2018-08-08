# ERC20 Token Standard

The first---and so far only---standard for tokens on the Ethereum blockchain is ERC20. There have been many new token standards and extensions or improvements to ERC20 suggested over time. Not including ERC777---the standard detailed in this paper---such proposals include the following standards: the ERC223 token standard, the ERC827 Token Standard (ERC20 Extension), the ERC995 Token Standard, the ERC1003 Token Standard (ERC20 Extension), and changes to ERC20 such as: Token Standard Extension for Increasing & Decreasing Supply (ERC621), Provable Burn: ERC20 Extension (ERC661), Unlimited ERC20 token allowance (ERC717), Proposed ERC20 change: make 18 decimal places compulsory (ERC724), Reduce mandatority of Transfer events for void transfers (ERC732), Resolution on the EIP20 API Approve / TransferFrom multiple withdrawal attack (ERC738), Extending ERC20 with token locking capability (ERC1132).

## The First Token Standard

The ERC20 standard was created on November 19th 2015 as listed on the EIPs website under the ERC track \cite[see][ERC track]{eipssite}. A standard for tokens must define a specific interface and expected behaviors a token must have when interacted with. This allows wallets, dapps and services to easily interact with any token.  It defines a simple interface which lets anyone transfer their tokens to other address, check a balance, the total supply of tokens and such. Specifically it defines nine functions a token must implement: `name`, `symbol`, `decimals`, `totalSupply`, `balanceOf`, `transfer`, `transferFrom`, `approve`, `allowance` as well as two events which must be fired in particular cases: `Transfer` and `Approval`.

The `name`, `symbol` are optional functions which fairly basic and easy to understand. They return the name and the symbol or abbreviation of the token. Considering the Aragon token as an example, the `name` function returns the string `Aragon Network Token` and the `symbol` functions returns `ANT`. Another somewhat harder to understand optional function is `decimals`. This function returns the number of decimals used by the token and thus define what transformation should be applied to any amount of tokens before being displayed to the user or communicated to the token contract. As previously explained, the balances and amounts of tokens handled by the token contracts are (256 bits) unsigned integers. Therefore the smallest fractional monetary unit is one. For some---or many---tokens, it makes more sense to allow smaller fractions. The `decimals` function return the number of decimals to apply to any amount passed to or returned by the token contract. Most tokens simply follow Ether---which uses eighteen decimals---and use eighteen decimals as well. Another decimals value used is zero. A token with zero decimals can make sense when a token represent an entity which is not divisible---such as a physical entity. Altogether those functions are optional and purely cosmetic. The most important function being `decimals` as any misuse will show an incorrect representation of tokens and thus of value.

The `totalSupply` and `balanceOf` are also `view` methods. Simply put, they do not modify the state of the token contract, but only return data from it. This behavior is similar to what one can expect from getter functions in object oriented programming.

The `totalSupply` function returns the total number of tokens held by all the token holders. This number can either be constant or variable. A constant total supply implies the token contract is created with a limited supply of tokens with neither the ability to mint tokens nor the ability to burn. A variable total supply, on the other hand, signifies that a the token contract is capable of minting new tokens or burning them or both.

The `balanceOf` function takes an address as parameter and returns the number of tokens held by that address.

## Transferring ERC20 Tokens

The `transfer` and `transferFrom` functions are used to move tokens across addresses. The `transfer` function takes two parameters, first the address of the recipient and secondly the number of tokens to transfer. When executed, the balance of the address which called the function is debited and the balance of the address specified as the first parameter is credited the number of token specified as the second parameter. Of course, before updating any balance some checks are performed to ensure the debtor as enough funds.

\begin{figure}[ht!]
\centering
\begin{tikzpicture}
  \begin{umlseqdiag}
    \umlactor[class=Spender]{Alice}
    \umlobject[no ddots]{Token Contract}
    \umlactor[class=Recipient]{Bob}
    \begin{umlcall}[op={transfer(Bob, 10)},draw=BrickRed]{Alice}{Token Contract}
      \begin{umlcall}[op=\shortstack{update\\ balances},draw=MidnightBlue]{Token Contract}{Token Contract}
        \end{umlcall}
    \end{umlcall}
    \umlsdnode[dt=14]{Bob}
  \end{umlseqdiag}
\end{tikzpicture}
\caption{Standad ERC20 \texttt{transfer} between two regular accounts: Alice and Bob.}
\label{fig:erc20transfer}
\end{figure}

As seen on figure \ref{fig:erc20transfer} when performing a transfer, the spender emits a transaction which calls the token contract and update the balances accordingly. The recipient is never involved in the transaction. The logic to update the balance is entirely done within the token contract, in the `transfer` function.

Examples of the implementation details to update the balances are shown in listings \ref{lst:OZTransfer} and \ref{lst:TronixTransfer}.

```{caption="OpenZepplin's implementation of ERC20's transfer function." label="lst:OZTransfer" language=solidity}
/**
* @dev Transfer token for a specified address
* @param _to The address to transfer to.
* @param _value The amount to be transferred.
*/
function transfer(address _to, uint256 _value) public returns (bool) {
  require(_value <= balances[msg.sender]);
  require(_to != address(0));

  balances[msg.sender] = balances[msg.sender].sub(_value);
  balances[_to] = balances[_to].add(_value);
  emit Transfer(msg.sender, _to, _value);
  return true;
}
```

The implementation of the `transfer` function in the listing \ref{lst:OZTransfer} shows---on lines 7 and 8---the conditions checked before effectually performing the transfer and update of the balances---on lines 10 and 11.
The solidity instruction `require` evaluates the condition it is passed as parameter. If it is true it will continue with the execution, otherwise it will call the `REVERT` EVM opcode which stops the execution of the transaction without consuming all of the gas and revert the state changes.

The first check ensure that the token holder---here referred as the sender---does not try to send a number of tokens higher than its balance. The variable `msg.sender` is a special value in Solidity which holds the address of the sender of the message for the current call. In other words, `msg.sender` is the address which called the `transfer` function.

The second checks ensure that the recipient---defined in the parameter `_to`---is not the zero address. The notation `address(0)` is a cast of the number literal zero to a 20 bits address. The zero address is a special address. Sending tokens to the zero address is assimilated to burning the tokens. Ideally the balance of the zero address should not be update in this case. This is not always the case, tokens such as Tronix are held by the zero address. A quick look at their implementation shown in listing \ref{lst:TronixTransfer} of the transfer methods shows there is no check to ensure the recipient is not the zero address. Note that the `validAddress` modifier only verifies the `msg.sender` or in other words, the spender, not the recipipent.

```{caption="Tronix transfer function." language=solidity label="lst:TronixTransfer"}
modifier isRunning {
    assert (!stopped);
    _;
}

modifier validAddress {
    assert(0x0 != msg.sender);
    _;
}

// ...

function transfer(address _to, uint256 _value)
    isRunning validAddress returns (bool success)
{
    require(balanceOf[msg.sender] >= _value);
    require(balanceOf[_to] + _value >= balanceOf[_to]);
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    Transfer(msg.sender, _to, _value);
    return true;
}
```

The `transferFrom` function is the second function available to transfer tokens between addresses. It's use is depicted in figure \ref{fig:erc20transferFrom}. It takes three parameters the debtor address, the creditor address and the number of tokens to transfer.

\begin{figure}[ht!]
\centering
\begin{tikzpicture}
  \begin{umlseqdiag}
    \umlactor[class=Spender]{Alice}
    \umlobject[no ddots]{Token Contract}
    \umlactor[class=Recipient,x=9]{Carlos}
    \begin{umlfragment}[type=Approval]
      \begin{umlcall}[op={approve(Carlos, 10)},draw=BrickRed,dt=8]{Alice}{Token Contract}
        \begin{umlcall}[op=\shortstack{update\\ allowance},draw=MidnightBlue]{Token Contract}{Token Contract}
        \end{umlcall}
      \end{umlcall}
    \end{umlfragment}
    \begin{umlfragment}[type={Transfer}]
      \begin{umlcall}[op={notify of approve},draw=OliveGreen,dt=8]{Alice}{Carlos}
        \begin{umlcall}[op={transferFrom(Alice, Carlos, 10)},draw=BrickRed,dt=4]{Carlos}{Token Contract}
          \begin{umlcall}[op=\shortstack{react to\\ transfer},draw=MidnightBlue]{Carlos}{Carlos}
          \end{umlcall}
        \end{umlcall}
      \end{umlcall}
    \end{umlfragment}
  \end{umlseqdiag}
\end{tikzpicture}
\caption{Standad ERC20 \texttt{transferFrom} between a regular account Alice and a contract account Carlos.}
\label{fig:erc20transferFrom}
\end{figure}

The reason for the existence of this second function to transfer tokens is contracts. Contracts usually need to react when receiving tokens. When a normal `transfer` is called to send tokens to a contract, the receiving contract is never called and cannot react. Contracts are also not able to listen to events, making it impossible for a contract to react to a `Transfer` event. The `transferFrom` lets the token contract transfer the tokens from someone else to itself or others. At first glance this appears to be insecure as it lets anyone withdraw tokens from any address. This is where the `approve` and `allowance` functions come into play. The specification for the `transferFrom` function state that "[t]he function SHOULD `throw` unless the `_from` account has deliberately authorized the sender of the message via some mechanism" \citep{erc20}. The `approve` function the standard mechanism to authorize a sender to call `transferFrom`. Consider an ERC20 token, a regular user Alice and a contract Carlos. Alice wishes to send five tokens to Carlos to purchase a service offered by Carlos. If she uses the `transfer` function, the contract will never be made aware of the five tokens it received and will not activate the service for Alice. Instead, Alice can call `approve` to allow Carlos to transfer five of Alice's tokens. Anyone can then call `allowance` to check that Alice did in fact allow Carlos to transfer the five tokens from Alice's balance. Alice can then call a public function of Carlos or notify off-chain the maintainers of the Carlos contract such that they can call the function. This function of Carlos can call the `transferFrom` function of the token contract to receive the five tokens from Alice.


## Strength And Weaknesses Of ERC20

Overall the ERC20 token standard was kept simple in its design. Hence the standard results in simple token contracts. This is one of the upside of the standard. Token contracts can be kept short and simple which makes them easy and cheap to audit. This is especially important as an insecure contract will lose its value extremely quickly and good smart contract auditors are expensive and have little availability.

At the other end of the spectrum however, this translates to a higher burden on the user, applications and wallets interacting with the tokens.

### Locked Tokens

One of the largest issue is the distinction all token holders must make when transferring tokens regarding the type of recipient. There are no issues if the recipient is a regular account, `transfer` just works and calling `approve` with the correct amount and let the recipient call `transferFrom`. The user experience in this case is somewhat suboptimal as it requires off-chain communication, two transactions, and the recipient has two pay the gas for the second transaction. Nonetheless the intended goal is achieved and the transfer from the spender to the recipient is achieved.

The same cannot be said if the recipient is a contract account. When using `transfer` to send tokens to a contract. The spender initiates the transfer and only communicates with the token contract the recipient is never notified---as previously shown in figure \ref{fig:erc20transfer}. The result is that while the token balance of the receiving contract is increased, that contract may never be able to use and spend the tokens it received---this situation is commonly referred to as "locked tokens". A simple proof is the Tronix contract whose `transfer` function was discussed before. A rapid look at the token balance of the Tronix contract---deployed at itself shows a balance of 5'504'504.3514 TRX as of August 8^th^ 2018. With an exchange rate of $0.0272, this represent a value of just a little under 150,000 US dollars. By analyzing the code, one can see there are no functions which would allow anyone to spend those tokens. There are of course many more similar examples of such scenarios where people sent tokens either to the token contract or to some other contract by mistake and the amounts add up quickly

### Approval Race Condition

By abusing the \gls{abi} of ERC20, an attacker can trick its victim into approving more tokens for the attacker to spend than intended. This attack was revealed on November 29^th^ 2018. Essentially, it takes advantage of two of ERC20's functions: `approve` and `transferFrom`. Because this is an issue with the logic in the standard, all ERC20-compliant implementations are affected. This attack works as follow, as described in the original paper \citep{erc20approveattack}:

1. Alice allows Bob to transfer $N$ of Alice's tokens ($N>0$) by calling the `approve` function on the token smart contract, passing Bob's address and $N$ as function arguments.
2. After some time, Alice decides to change from $N$ to $M$ ($M>0$) the number of Alice's tokens Bob is allowed to transfer, so she calls the `approve` function again, this time passing Bob's address and $M$ as function arguments
3. Bob notices Alice's second transaction before it was mined and quickly sends another transaction that calls `transferFrom` method to transfer $N$ Alice's tokens somewhere.
4. If Bob's transaction is executed before Alice's transaction, then Bob will successfully transfer $N$ of Alice's tokens and will gain an ability to transfer another $M$ tokens.
5. Before Alice noticed that something went wrong, Bob calls the `transferFrom` function again, this time to transfer $M$ of Alice's tokens.

So, Alice's attempt to change Bob's allowance from $N$ to $M$ ($N>0$ and $M>0$) made it possible for Bob to transfer $N+M$ of Alice's tokens, while Alice never wanted to allow so many of her tokens to be transferred by Bob.

\begin{figure}[ht!]
\centering
\begin{tikzpicture}
  \begin{umlseqdiag}
    \umlactor[class=Victim]{Alice}
    \umlobject[no ddots]{Token Contract}
    \umlactor[class=Attacker,x=9]{Bob}
    \begin{umlcall}[op={approve(Bob, N)},draw=BrickRed,dt=6]{Alice}{Token Contract}
    \end{umlcall}
    \begin{umlfragment}[type={Race Condition},name=racecond]
      \begin{umlcall}[op={transferFrom(Alice, Bob, N)},draw=BrickRed,dt=16.4]{Bob}{Token Contract}
      \end{umlcall}
      \begin{umlcall}[op={approve(Bob, M)},draw=BrickRed,dt=8]{Alice}{Token Contract}
      \end{umlcall}
    \end{umlfragment}
    \begin{umlcall}[op={transferFrom(Alice, Bob, M)},draw=BrickRed,dt=6]{Bob}{Token Contract}
    \end{umlcall}
    \umlsdnode[dt=8]{Alice}
    \umlnote[x=2,y=-6]{racecond}{Bob sees Alice's approve transaction and tries to front-run her with a transferFrom transaction with a higher gas price.}
  \end{umlseqdiag}
\end{tikzpicture}
\caption{Sequence of calls for the \texttt{approve}/\texttt{transferFrom} attack.}
\label{fig:erc20approveattack}
\end{figure}

### Absence Of burning

The ERC20 standard defines the behavior for minting new tokens. Namely, "[a] token contract which creates new tokens SHOULD trigger a Transfer event with the `_from` address set to `0x0` when tokens are created" \citep{erc20}. Unfortunately the standard does not go further, nothing is specified regarding the balance of `0x0` or the `totalSupply` for example.

Furthermore, the standard does not contain any specification about burning tokens. Sending to the `0x0` address is commonly assumed to represent burning---not to be confused with voluntary locking where the tokens are sent to some other address made of a repeating and non-random looking pattern such as `0x1111111111111111111111111111111111111111`. While "sending to `0x`" is a perfectly reasonable abstraction to represent a burn of tokens, it needs to be clearly defined. Should the balance of `0x0` be incremented? If yes, should the total supply remain the same or should it ignore the balance of `0x0` and be decreased? Should a `Transfer` event with the `to` address set to `0x0` be emitted? Can the tokens be burned using a `transfer` or `transferFrom` call with `to` set to `0x0` or should specific function be used to burn the tokens?

Out of all the questions above, most tokens tend to emit `Transfer` events with the `to` address set to `0x0`. The remaining questions are solved differently for various tokens. Multiple mutually exclusive solution may be acceptable. However in some cases, some solutions may be preferable over others. As an example, most of the smart contracts are written in Solidity where an uninitialized variable of type `address` has a value of zero (`0x0`). On the off-chance that the value passed as the `to` parameter to a `transfer` call is uninitialized, then if the token contract allows burning via `transfer`, this will result in an unintentional burn of the tokens. In such a scenario, it may be preferable to revert the transaction instead and expose a specfic function to burn tokens instead.


Short description of tokens and their use.

Explain ERC20:

 - specifications
 - issues (vulnerabilities, locking)
 - examples of attacks and locked funds

Mention ERC223 and its own problems:

  - tokensFallback on all contracts
  - not backwards compatible with ERC20
  - unusable by existing contracts
  - community/human issues with the author
