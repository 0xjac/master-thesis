\appendix
\appendixpage
\addappheadtotoc

# The `devdoc` And `userdoc` Raw \acrshort{json} Data Of The ERC820 Registry

```{=latex}
\lstinputlisting[linewidth=\linewidth,caption={The \texttt{devdoc} and \texttt{userdoc} in \gls{json} format of the ERC820 registry, extracted from the metadata of the compilation's standard output from the contract.},label=lst:erc820doc,language=json]{lst/erc820doc.json}
```

# ERC820 Vanitygen

## Vanitygen Bash Script

```{=latex}
\lstinputlisting[linewidth=\linewidth,caption={The bash script used to generate a vanity address for the ERC820 registry.},label=lst:vanitygen,language=bash]{lst/vanitygen.sh}
```
\pagebreak

## Vanitygen Javascript Info Script

```{=latex}
\lstinputlisting[linewidth=\linewidth,caption={The Javascript program called by the ERC820 Vanity generator to find the address of a version of the compiled contract.},label=lst:vanitygeninfo,language=JavaScript]{lst/vanitygen-info.js}
```
