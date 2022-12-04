//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/// @notice Contract used to complete the Knowledge Test pre-course assignment from 0xMacro
/// @author PedroYan
contract KnowledgeTest {
    string[] public tokens = ["BTC", "ETH"];
    address[] public players;

    /// @notice Owner of this contract, which will be the address that deployed it. This value cannot be changed
    /// once set.
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function changeTokens() public view {
        string[] memory t = tokens;
        t[0] = "VET";
    }
}
