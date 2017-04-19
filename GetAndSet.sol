pragma solidity ^0.4.4;

contract GetAndSet{

  address public creator;
  string public string_example;
  int public int_example;
  bytes32 public bytes32_example;
  address public address_example;
  bool public bool_example;

  function GetAndSet(){
    creator = msg.sender;
    string_example = "Hello World";
    int_example = 666;
    bytes32_example = 0xf40871941bac8acbfd226a394119b7be6f9454d1;
    address_example = msg.sender;
    bool_example = true;
  }

  function SetString(string _incoming){
    string_example = _incoming;
    return;
  }

  function SetInt(int _incoming)
  {
    int_example = _incoming;
    return;
  }

  function SetBytes32(bytes32 _incoming)
  {
    bytes32_example = _incoming;
    return;
  }

  function SetAddress()
  {
    address_example = msg.sender;
    return;
  }

  function SetBool(bool _incoming)
  {
    bool_example = _incoming;
    return;
  }



  function kill()
  {
      if (msg.sender == creator)
      {
          suicide(creator);
      }
  }

}
/*
var TempContract = GetAndSet;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.creator();

MyContract.string_example();
MyContract.SetString("How are you", {from:web3.eth.accounts[0],gas:1000000});
MyContract.string_example();

MyContract.int_example();
MyContract.SetInt(7, {from:web3.eth.accounts[0],gas:1000000});
MyContract.int_example();

MyContract.bytes32_example();
MyContract.SetBytes32(81985529216486895, {from:web3.eth.accounts[0],gas:1000000});
MyContract.bytes32_example();

MyContract.address_example();
MyContract.SetAddress({from:web3.eth.accounts[1],gas:1000000});
MyContract.address_example();

MyContract.bool_example();
MyContract.SetBool(false, {from:web3.eth.accounts[0],gas:1000000});
MyContract.bool_example();

MyContract.kill({from:web3.eth.accounts[0],gas:1000000});
MyContract.creator();
*/
