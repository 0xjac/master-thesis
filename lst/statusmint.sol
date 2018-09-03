function proxyPayment(address _th) public payable notPaused initialized contributionOpen returns (bool) {
    require(_th != 0x0);
    if (guaranteedBuyersLimit[_th] > 0) {
      buyGuaranteed(_th);
    } else {
      buyNormal(_th);
    }
    return true;
}

function buyNormal(address _th) internal {
  require(tx.gasprice <= maxGasPrice);

  // Antispam mechanism
  address caller;
  if (msg.sender == address(SNT)) {
    caller = _th;
  } else {
    caller = msg.sender;
  }

  // Do not allow contracts to game the system
  require(!isContract(caller));

  require(getBlockNumber().sub(lastCallBlock[caller]) >= maxCallFrequency);
  lastCallBlock[caller] = getBlockNumber();

  uint256 toCollect = dynamicCeiling.toCollect(totalNormalCollected);

  uint256 toFund;
  if (msg.value <= toCollect) {
    toFund = msg.value;
  } else {
    toFund = toCollect;
  }

  totalNormalCollected = totalNormalCollected.add(toFund);
  doBuy(_th, toFund, false);
}

function doBuy(address _th, uint256 _toFund, bool _guaranteed) internal {
  assert(msg.value >= _toFund);  // Not needed, but double check.
  assert(totalCollected() <= failSafeLimit);

  if (_toFund > 0) {
    uint256 tokensGenerated = _toFund.mul(exchangeRate);
    assert(SNT.generateTokens(_th, tokensGenerated));
    destEthDevs.transfer(_toFund);
    NewSale(_th, _toFund, tokensGenerated, _guaranteed);
  }

  uint256 toReturn = msg.value.sub(_toFund);
  if (toReturn > 0) {
    // If the call comes from the Token controller,
    // then we return it to the token Holder.
    // Otherwise we return to the sender.
    if (msg.sender == address(SNT)) {
      _th.transfer(toReturn);
    } else {
      msg.sender.transfer(toReturn);
    }
  }
}
