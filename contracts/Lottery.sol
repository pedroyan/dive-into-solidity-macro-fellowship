//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;
import "hardhat/console.sol";

contract Lottery {
    // declaring the state variables
    address[] public players; //dynamic array of type address payable
    address[] public gameWinners;
    address public immutable owner;

    modifier requiresOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }

    /// @notice The constructor is called once when the contract is deployed. It sets the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // @notice handles ETH sent to the contract and adds the sender to the lottery
    receive() external payable {
        // Players must send exactly 0.1 ETH to enter the lottery
        require(msg.value == 0.1 ether, "You must send exactly 0.1 ETH");

        players.push(msg.sender);
    }

    /// @notice returns the contract balance in wei. Only callable by the owner.
    /// @dev Fun fact: this function is useless, since anyone can query the contract balance at any time using the
    ///      `.balance` property :)
    function getBalance() public requiresOwner view returns (uint256) {
        return address(this).balance;
    }

    /**
    * @notice Picks the winner of the lottery and sends them the contract balance. This function uses the
    * Checks-Effects-Interactions pattern to prevent reentrancy attacks, which in this case would be harmless, since
    * we are already transferring the entire lottery balance to the winner
    */
    function pickWinner() public requiresOwner {
        require(players.length >= 3, "NOT_ENOUGH_PLAYERS");

        // Pick winner "randomly"
        uint256 r = random();
        address winner;
        uint256 index = r % players.length;
        winner = players[index];

        // Append the winner to the gameWinners array
        gameWinners.push(winner);

        // Reset the lottery for the next round
        delete players;

        // Transfer the entire contract's balance to the winner
        (bool success, ) = winner.call{value: address(this).balance}("");
        require(success, "Failed to transfer balance to winner");
    }

    // helper function that returns a big random integer
    // UNSAFE! Don't trust random numbers generated on-chain, they can be exploited! This method is used here for simplicity
    // See: https://solidity-by-example.org/hacks/randomness
    function random() internal view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        players.length
                    )
                )
            );
    }
}
