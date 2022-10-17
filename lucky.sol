// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lucky{
    
    address public admin=msg.sender;
    address payable[] public participants;
    
    constructor(){
        admin = msg.sender;
    }
    
    receive() external payable{
        require(msg.value==5 ether);
        participants.push(payable(msg.sender));
    }
    
    function getBalance() public view returns(uint){
        return uint(address(this).balance);
    }
    
    function getWinner() public{
        require(msg.sender==admin);
        require(participants.length>=3);
        uint idx = uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)))%participants.length;
        address payable winner;
        winner = participants[idx];
        winner.transfer(getBalance());
        participants = new address payable[](0);
    }
    
    
}
