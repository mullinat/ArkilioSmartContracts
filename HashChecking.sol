pragma solidity ^0.4.4;

contract HashChecking{
  uint public num_stages = 5;
  uint public stage = 0;
  string[5] public hash_list;
  address public creator;
  address public client;

  function HashChecking(address _client){
    creator = msg.sender;
    client = _client;
  }

  function SubmitHash(string _bytes32){
    if(msg.sender == creator){
      if(stage < num_stages){
        hash_list[stage] = _bytes32;
      }
    }
  }

  function ApproveHash(bool _bool){
    if(msg.sender == client){
      if(stage < num_stages){
        stage += 1;
      }
    }
  }
}
/*
var TempContract = HashChecking;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.stage();

MyContract.SubmitHash("First Hash", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(true, {from:web3.eth.accounts[1],gas:1000000});
MyContract.stage();
MyContract.hash_list(0);

MyContract.SubmitHash("Second Hash", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(true, {from:web3.eth.accounts[1],gas:1000000});
MyContract.stage();
MyContract.hash_list(1);

MyContract.SubmitHash("Third Hash", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(true, {from:web3.eth.accounts[1],gas:1000000});
MyContract.stage();
MyContract.hash_list(2);

MyContract.SubmitHash("Fourth Hash", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(true, {from:web3.eth.accounts[1],gas:1000000});
MyContract.stage();
MyContract.hash_list(3);

MyContract.SubmitHash("Fifth Hash", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(true, {from:web3.eth.accounts[1],gas:1000000});
MyContract.stage();
MyContract.hash_list(4);

MyContract.hash_list(0);
MyContract.hash_list(1);
MyContract.hash_list(2);
MyContract.hash_list(3);
MyContract.hash_list(4);
*/
