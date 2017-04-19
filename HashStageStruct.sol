pragma solidity ^0.4.3;
contract HashStageStruct {
  struct hashstage {
    address creator;
    address  client;
    uint num_stages;
    uint stage;
    uint[] stage_percentages;
    uint project_cost;
    string[] hash_list;//Position 0 is the origional contract
  }
  mapping(uint => hashstage) Agreements;

  function HashStageStruct(address _client) {
    Agreements[0].creator = msg.sender;
    Agreements[0].client = _client;
    Agreements[0].project_cost = 1000;
    Agreements[0].num_stages = 5;
    Agreements[0].stage_percentages = [1,2,3,4,5];
  }

  function GetCreator(uint _key) constant returns (address){
    return Agreements[0].creator;
  }
  function GetClient(uint _key) constant returns (address){
    return Agreements[0].client;
  }
  function GetCost(uint _key) constant returns (uint){
    return Agreements[0].project_cost;
  }
  function GetNumStages(uint _key) constant returns (uint){
    return Agreements[0].num_stages;
  }
  function GetPercentage(uint _key, uint _position) constant returns (uint){
    return Agreements[0].stage_percentages[_position];
  }
}
/*
var TempContract = HashStageStruct;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.GetCreator(0);
MyContract.GetClient(0);
MyContract.GetCost(0);
MyContract.GetNumStages(0);
MyContract.GetPercentage(0,0);
MyContract.GetPercentage(0,1);
MyContract.GetPercentage(0,2);
MyContract.GetPercentage(0,3);
MyContract.GetPercentage(0,4);
*/
