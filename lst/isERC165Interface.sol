/// @notice Checks whether the hash is a ERC165 interface (ending with 28 zeroes) or not.
/// @param _interfaceHash The hash to check.
/// @return `true` if the hash is a ERC165 interface (ending with 28 zeroes), `false` otherwise.
function isERC165Interface(bytes32 _interfaceHash) internal pure returns (bool) {
    return _interfaceHash & 0x00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF == 0;
}
