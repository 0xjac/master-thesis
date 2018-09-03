# Future Research and Work

Even once the ERC777 standard is approved, there will be a significant amount of work to do, including assisting with formal verification of the reference implementation, building tools and services (based on hooks and operators), promoting the standard, and helping the community working on tokens implementations and dapps related to ERC777.

## Formal Verification Of The Reference Implementation

The reference implementation described in section \ref{reference-implementation} is currently being formally verified by an independent third-party. We are assisting them and using their feedback to improve the reference implementation. We expect later to further modify the reference implementation based on their findings.

## Generic Operators And Hooks For ERC777 End-Users

ERC777 does more than solving some of the shortcomings of ERC200 and provides novel features such as operators, hooks and the data field. Those features bring new possibilities and novel approaches to tackle problems related to token.

Generic operators and hooks are an exciting concept which aims to deploy in a trustless fashion---for example using the same keyless deployment method as the ERC820 registry---operator contracts and hooks which may be used by any address. These generic hooks and operators allow less technically-inclined users to use the advanced features of ERC777 without having an in-depth technical knowledge of Ethereum required for example to deploy a contract.

Efforts must be spent researching how to adequately provide generic operators and hooks such that they are safe, secure and easy to use for end users.

## Promotion Of The ERC777 Standard

The ERC777 standard is lucky to have broad community support and acceptance already. We already see many people looking it creating their own ERC777 tokens. A simple look at the number of download of the ERC777 reference implementation via \gls{npm} which is over 230 or the over 50 stars on its Github repository. We can see the interest is picking up, but there is still a long way to go.

\input{fig/ethcc}

Meeting the community and providing talks such as the one at EthCC in Paris (see figure \ref{fig:ethcc}), back in March 2018 \citep{ethcc} are also important. We hope to have the opportunity to talk about ERC777 at future Ethereum events including the Web3 summit in Berlin, the Ethereum Magicians' Council of Prague and Devcon4 also in Prague.

Moreover we try to contribute to other projects which help the adoption of the standard, such as writing a paragraph\footnote{\href{https://github.com/ethereumbook/ethereumbook/pull/611}{First Mastering Ethereum pull request about ERC777: github.com/ethereumbook/ethereumbook/pull/611}}\footnote{\href{https://github.com/ethereumbook/ethereumbook/pull/612}{Second Mastering Ethereum pull request about ERC777: github.com/ethereumbook/ethereumbook/pull/612}} for the upcoming book "Mastering Ethereum" \citep{antonopoulos2018mastering} which was well received as shown in figure \ref{fig:masteringethcomment}.

\input{fig/masteringethcomment}

## Assistance For ERC777 Token Designers

The ERC777 token standard is more complicated than the ERC20 standard, and we plan on working with the first token designers to make sure they understand the standard correctly and release compliant implementations.

## ERC777 Website

Both promotion and assistance of the ERC777 standard can use a website as support. Having an official website for the standard allows publishing concise information and advice regarding the standard. It allows us to educate people and provide examples of implementations and is a place where the community can easily reach out to us. Previous standards such as ERC721 also followed this path and provide \url{http://erc721.org}, an official website to promote and inform about the ERC 721 standard.

## Other Tools

As mentioned in section \ref{the-state-of-tooling-in-the-ethereum-ecosystem}, many tools are lacking or incomplete. Contributing further to the `solcpiler` project, creating a gas analysis tool and a documentation generating tool are all interesting future project which can help make ERC777 more accessible and easier to understand. Those tools are another opportunity to give back to the community as well and can help both us and everyone else have a better experience when building any project in the Ethereum system.
