pragma solidity ^0.4.3;
contract Poll {
  address public creator;
  struct poll{
    mapping(address => bool) eligibility;
    string[] options;
    uint num_options;
    mapping(uint => uint) votes;
    uint total_voters;
  }
  poll myPoll;
  function Poll(){
    creator = msg.sender;
    myPoll.total_voters = 0;
  }

  function SetOptions(string _option){
    if(msg.sender == creator){
      myPoll.options.push(_option);
      myPoll.num_options += 1;
    }
  }

  function SetVoter(address _address){
    if(msg.sender == creator){
      myPoll.eligibility[_address] = true;
      myPoll.total_voters += 1;
    }
  }

  function Vote(uint _vote){
    if(myPoll.eligibility[msg.sender] == true){
      if(_vote <= myPoll.num_options){
        myPoll.votes[_vote] += 1;
        myPoll.eligibility[msg.sender] = false;
      }
    }
  }

  function GetEligibility(address _address) constant returns (bool){
    return myPoll.eligibility[_address];
  }

  function GetVotes(uint _uint) constant returns (uint){
    return myPoll.votes[_uint];
  }

  function GetOptions(uint _uint) constant returns (string){
    return myPoll.options[_uint];
  }
}
/*
var TempContract = Poll;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.creator();

MyContract.SetOptions("Apple Pie", {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetOptions(0);
MyContract.SetOptions("Pork", {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetOptions(1);
MyContract.SetOptions("Soup", {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetOptions(2);


MyContract.SetVoter(web3.eth.accounts[0], {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetEligibility(web3.eth.accounts[0]);
MyContract.SetVoter(web3.eth.accounts[1], {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetEligibility(web3.eth.accounts[1]);
MyContract.SetVoter(web3.eth.accounts[2], {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetEligibility(web3.eth.accounts[2]);

MyContract.Vote.sendTransaction(0, {from:web3.eth.accounts[0],gas:1000000});
MyContract.Vote.sendTransaction(1, {from:web3.eth.accounts[1],gas:1000000});
MyContract.Vote.sendTransaction(0, {from:web3.eth.accounts[2],gas:1000000});

MyContract.GetVotes(0);
MyContract.GetVotes(1);
MyContract.GetVotes(2);
*/
