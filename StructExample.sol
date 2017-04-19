pragma solidity ^0.4.3;
contract StructExample {
  struct Identity {
    string name;
    int8 sex;//0 for female, one for male, other for other
    string postal_code;
    address public_key;
    uint8[11] phone_number;
  }

  Identity JohnTory;
  function StructExample() {
    JohnTory.name = "John Tory";
    JohnTory.sex = 1;
    JohnTory.postal_code = "M5H 2N2";
    JohnTory.public_key = msg.sender;
    JohnTory.phone_number = [1,4,1,6,3,9,7,3,6,7,2];//(416) 397-3673
  }

  function GetName() constant returns (string){
    return JohnTory.name;
  }
  function GetSex() constant returns (int8){
    return JohnTory.sex;
  }
  function GetPostalCode() constant returns (string){
    return JohnTory.postal_code;
  }
  function GetPublicKey() constant returns (address){
    return JohnTory.public_key;
  }
  function GetPhoneNumber() constant returns (uint8[11]){
    return JohnTory.phone_number;
  }
}
/*
var TempContract = StructExample;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.GetName();
MyContract.GetSex();
MyContract.GetPostalCode();
MyContract.GetPublicKey();
MyContract.GetPhoneNumber();
*/
