// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract HotelRoom{

    enum Statuses {
        Vacant, 
        Occupied
    }

    Statuses public currentStatus;
    event Occupy(address _occupant, uint _value);
    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant{
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier costs(uint _amount){
        require(msg.value >= _amount, "Not enough ether provide.");
        _;
    }

    function book() public payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
    
        // (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        // OR
        owner.transfer(msg.value);

        emit Occupy(msg.sender, msg.value);
    }

}