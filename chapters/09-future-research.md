# Future Research and Work

Even once the ERC777 standard is approved, there will be a large amount of work to do.

## Generic Operators And Hooks For ERC777 End-Users

ERC777 does more than solving some of the shortcomings of ERC200 and provides novel features such as operators, hooks and the data field. Those features bring new possibilities and novel approaches to tackle problems related to token.

Generic operators and hooks are an interesting concept which aim to deploy in a trustless fashion---for example using the same keyless deployment method as the ERC820 registry---operator contracts and hooks which may be used by any address. These generic hooks and operators allow less technically-inclined users to use the advanced features of ERC777 without having a deep technical knowledge of Ethereum required for example to deploy a contract.

Efforts must be spent researching how to properly provide generic operators and hooks such that they are safe, secure and easy to use for end users.

## Promotion Of The ERC777 Standard

The ERC777 standard is lucky to already have wide community support and acceptance. We already see many people looking it creating their own ERC777 tokens. A simple look at the number of download of the ERC777 reference implementation via \gls{npm} which is over 230 or the over 50 stars on its Github repository. We can see interest is picking up but there is still a long way to go.

\begin{figure}[!htbp]
\label{fig:ethcc}
\centering
\includegraphics[width=0.8\textwidth]{ethcc}
\caption{Jordi Baylina and Jacques Dafflon presenting the ERC777 standard at EthCC in Paris (March 2018). Photo credit: HelloGold Foundation}
\end{figure}


Meeting the community and providing talks such as the one at EthCC in Paris, back in March 2018 \citep{ethcc} are also important. We hope to have the opportunity to talk about ERC777 at future Ethereum events including the Web3 summit in Berlin, the Ethereum Magicians' Council of Prague and Devcon4 also in Prague.

## Assistance For ERC777 Token Designers

The ERC777 token standard is more complex than the ERC20 standard and we plan on working with the first token designers to make sure the understand the standard correctly and release compliant implementations.

## ERC777 Website

Both promotion and assistance of the ERC777 standard can use a website as support. Having an official website for the standard allows to publish concise information and advice regarding the standard. It allows us to educate people and provide examples of implementations and is a place where the community can easily reach out to us. Previous standards such as ERC721 also followed this path and provide \url{http://erc721.org}, an official website to promote and inform about the ERC 721 standard.

## Other Tools

As mentioned in section \ref{the-state-of-tooling}, many tools are lacking or incomplete. Contributing further to the `solcpiler` project, creating a gas analysis tool and a documentation generating tool are all interesting future project which can help make ERC777 more accessible and easier to understand. Those tools are another opportunity to give back to the community as well and can help both us and everyone else have a better experience when building any project in the Ethereum system.
