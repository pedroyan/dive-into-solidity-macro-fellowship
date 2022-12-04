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

    modifier requiresOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }

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

    /// @notice Transfers all the balance of the contract to the owner
    function transferAll(address payable _destination) external requiresOwner {
        // Transfer the entire balance using call. Reentrancy is not a concern here since we are already emptying out
        // the entire balance in one go.
        (bool success, ) = _destination.call{value: getBalance()}("");
        require(success, "Transfer failed.");
    }

    /// @notice Adds a player to the players array
    function start() external {
        players.push(msg.sender);
    }

    /// @notice Concatenates string a and b
    function concatenate(string calldata _a, string calldata _b) public pure returns (string memory) {
        return string(abi.encodePacked(_a, _b));
    }

    /// @notice Handles ETH transfers to this contract
    receive() external payable {
    }
}
