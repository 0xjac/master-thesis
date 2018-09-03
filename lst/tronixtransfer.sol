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
