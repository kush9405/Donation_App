// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Donation {
    address public owner;
    uint256 public totalDonated;

    constructor() {
        owner = msg.sender;
    }

    event Donated(address indexed donor, uint256 amount);
    event Withdrawn(address indexed by, uint256 amount);

    function donate() external payable {
        require(msg.value > 0, "Must send ETH");
        totalDonated += msg.value;
        emit Donated(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not the owner");
        uint256 amount = address(this).balance;
        require(amount > 0, "No balance");
        payable(owner).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}