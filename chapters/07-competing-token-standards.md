# Competing Token Standards

The \glspl{eip} repository is open to everyone and anyone is free to suggest any \gls{eip}. Many people correctly identified the drawbacks of ERC20 as explained in section \ref{strength-and-weaknesses-of-erc20} and many amendments to ERC20 have been proposed. Those amendments are problematic as they change the established standard, migrating to a newer and improved token standard is a better solution---which is the goal behind ERC777. Moreover ERC777 is not the only or even the first new token standard to be proposed to replace ERC20. It is also is not the last, as ERC777 gain popularity a fe more related standard and other token standards started to appear on the \glspl{eip} repository \ref{eipsrepo}.

In this chapter, we will explore three of the main tokens standard proposals competing with ERC777. The first one is ERC223 which predates ERC777 and looked very promising and gained some community support as it was for a time the only real alternative to ERC20. The two others came after ERC777 as indicated by their number: ERC827 and ERC995. In the same way ER223 tries to be an answer to the drawbacks of ERC20, ERC777 and ERC827 try to be an answer to the drawbacks of ERC20 and the issues from ERC223. The last standard, ERC995, is based on ERC995 and adds extra features on top.

## ERC223

ERC223 was submitted on March 5^th^ 2017, by a developer knows as Dexaran. It has one clear goal in mind: to address the issue of accidentally locking token in ERC20 (see section \ref{locked-tokens}).

The solution suggested by this proposal is to define a `tokenFallback` function similar to the default fallback function \citepalias[see][Fallback Function]{soldoc}. This function takes as parameters the address of the spender (`from`), the amount of tokens transferred and a `data` field. Any contract wishing to receive tokens must implement this function.

The ERC223 proposal requires the token contract to check whether the recipient is a contract when sending tokens and if it is, then the token contract must call the `tokenFallback` function on the recipient directly.

Overall ERC223 does bring some improvements, first it provides a simplified `transfer` function which does away with the `approve` and `transferFrom` mechanism of ERC20. Secondly it adds a `data` field to attach information to a token transfer. The whole standard is quite short and kept simple which may be an advantage as it makes it easy for potential developers to understand and thus may reduce mistakes when implementing tokens.

Although, the proposal may also be consider to simplistic and limited, thus creating token which are too limited and forcing developers to add non standard functionalities to provide the behaviors they need. This exact scenario is already happening with ERC20.

Moreover, the standard defines two functions named `transfer` with a different number of parameters (one with and one without the `data` parameter). This overloading is allowed in Solidity, however other high level languages such as Vyper---a new language compiling to \gls{evm} bytecode and inspired by the Python syntax---which is slowing gaining traction in the community may not support function overloading. Hence token contracts following ERC223 can never be implemented in Vyper which is a sever limitation to the growth of both ERC223 and newer languages such as Vyper.

Furthermore, because recipient contract are required to implement a specific function, which virtually almost no deployed contracts implements today. As a result, adoption of ERC223 implies that all existing contracts are migrated to new updated version if they wish to support ERC223 tokens which is another even more severe limitation to the growth and adoption of ERC223. to try and alleviate this restriction, the repository of the reference implementation for ERC223 contains an implementation which allows custom callbacks. In other words, it lets the spender specify which function to call on the recipient. While this may appear as an improvement, it actually opens the significant security breach as ERC827 which potentially allows hijacking of the contract (see section \ref{erc827} for details).

The proposal also has some inaccurate claims such as backward compatibility with ERC20. The author appears to confuse backward compatibility with the ERC20 standard and ERC20 compatible functional interfaces.

> Now ERC23 is 100% backwards compatible with ERC20 and will work with every old contract designed to work with ERC20 tokens. \flushright (Dexaran, comment on ERC223)

Specifically, both standard define an identical `transfer` function as part of their interface. Therefore, some contract capable of calling the ERC20 `transfer` function will be capable of calling the exact same transfer function on an ERC223 token contract. Nevertheless this does not imply compatibility between the two standards. The behavior of the `transfer` function changes widely form one standard to the next and this change of behavior may break things. Potentially a contract could handle transferring ERC20 tokens by first checking if the recipient is a contract or not and call `transfer` or `approve` accordingly. If this contract is given an ERC2223 token, it may try to call the `approve` function on the ERC223 token which does not implement the function and the transaction will fail.

> ERC777 has been built to solve some of the shortcomings of ERC223. Please have a look at it:
>
> \url{http://eips.ethereum.org/EIPS/eip-777} \flushright (chencho777, comment on ERC223)

Finally the developer behind the standard appears to be more focus on solving the issue of locked tokens despite the concerns mentioned above and raised by the community. Ultimately there was a feeling that an agreement would be hard to reach, community members became more and more doubtful regarding the viability of ERC223 and the standard started to become more and more stagnant, with the last comments suggesting to look at ERC777 instead.

> \@MicahZoltu is 100% correct. This discussion did not lead to a consensus, so don't expect this standard to be followed. [...] \flushright (Griff Green, comment on ERC223)


## ERC827

ERC827 is another proposal to fix ERC20. Unlike ERC777 which takes a more independent approach which is fully dissociated form ERC20 and where both standard can be implemented side-by-side, the ERC827 proposal tries to build a second standard on top of ERC20.

## ERC995
