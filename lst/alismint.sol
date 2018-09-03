function buyTokens(address beneficiary) payable {
    require(!paused);
    require(beneficiary != 0x0);
    require(validPurchase());
    require(saleAccepting());

    uint256 weiAmount = msg.value;

    // for presale
    if ( isPresale() ) {
      checkLimit(weiAmount);
    }

    // calculate token amount to be created
    uint256 tokens = weiAmount.mul(getRate());

    // update state
    weiRaised = weiRaised.add(weiAmount);

    token.mint(beneficiary, tokens);
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

    forwardFunds();
}
