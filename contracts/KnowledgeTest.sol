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

    /// @notice The constructor is called once when the contract is deployed. It sets the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    /// @notice Changes the value of the first token in the tokens array
    function changeTokens() public {
        tokens[0] = "VET";
    }

    /// @notice Fetches the ETH balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /// @notice Handles ETH transfers to this contract
    receive() external payable {
    }
}
