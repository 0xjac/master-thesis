function setOwner(address owner_)
    public
    auth
{
    owner = owner_;
    emit LogSetOwner(owner);
}

// ...

modifier auth {
    require(isAuthorized(msg.sender, msg.sig));
    _;
}

function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
    if (src == address(this)) {
        return true;
    } else if (src == owner) {
        return true;
    } else if (authority == DSAuthority(0)) {
        return false;
    } else {
        return authority.canCall(src, this, sig);
    }
}
