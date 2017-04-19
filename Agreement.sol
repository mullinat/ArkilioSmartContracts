pragma solidity ^0.4.4;

contract Agreement {
  bool creator_agree;
  bool client_agree;
  uint contract_cost;
  address creator;
  address client;
  uint[5] stages;
  uint stage;
  bytes32[5] hash_stages;
  function Agreement() {
    creator_agree = false;
    client_agree = false;
    contract_cost = 1000;
    creator = msg.sender;
    //client = ;
    stages = [20,20,20,20,20];
    stage = 1;

  }

  function CreatorAgree(){
    if (msg.sender == creator){
      creator_agree = true;
    }
  }

  function ClientAgree(){
    if (msg.sender == client){
      client_agree = true;
    }
  }

  function ClientPay() payable{

  }

  function SendHash(bytes32 _bytes32){
    if (msg.sender == creator){
      hash_stages[stage] = _bytes32;
    }
  }

  function CheckHash(bool _bool){
    if(msg.sender == client){
      if(_bool == true){

      }
      if(_bool == false){
        hash_stages[stage] = 0;
      }
    }
  }



}
