// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Nova chain Project Contract
 * @dev Demonstration smart contract with 3 core features:
 *      - User registration
 *      - Storing a public announcement message
 *      - Owner-only reset
 */
contract Project {
    address public owner;
    mapping(address => bool) public isRegistered;
    string public announcement;

    event UserRegistered(address indexed user);
    event AnnouncementUpdated(address indexed user, string newAnnouncement);

    constructor() {
        owner = msg.sender;
    }

    /// @notice Allows a user to register once.
    function register() public {
        require(!isRegistered[msg.sender], "Already registered");
        isRegistered[msg.sender] = true;
        emit UserRegistered(msg.sender);
    }

    /// @notice Update the main announcement message.
    /// @param _msg The new announcement.
    function updateAnnouncement(string calldata _msg) public {
        require(isRegistered[msg.sender], "Not registered");
        announcement = _msg;
        emit AnnouncementUpdated(msg.sender, _msg);
    }

    /// @notice Owner can reset the announcement to a blank state.
    function resetAnnouncement() public {
        require(msg.sender == owner, "Owner only");
        announcement = "";
    }
}

