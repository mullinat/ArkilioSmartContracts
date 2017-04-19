pragma solidity ^0.4.3;
contract EthWallet {
  address public owner;

  function EthWallet() {
    owner = msg.sender;
  }

  function () payable{

  }

  function SendWeiHome(uint256 amount){
    if (!owner.send(amount)) throw;
    return;
  }

  function SendWei(address user, uint256 amount)constant returns (bool){
    if(msg.sender == owner){
      if (!user.send(amount)) throw;
      return true;
    }
    return false;
  }

  function GetBalance() constant returns (uint){
    return this.balance;
  }

  function GetBalanceInEth() constant returns (uint){
    return this.balance/1000000000000000000;
  }

}
/*
var TempContract = EthWallet;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.GetBalance();
MyContract.owner();
web3.eth.sendTransaction({from:web3.eth.accounts[0], to:EthWallet.address, value: web3.toWei(3, "ether")})
MyContract.GetBalance();
MyContract.GetBalanceInEth();
MyContract.SendWei.sendTransaction(web3.eth.accounts[5], 1000000000000000000, {from:web3.eth.accounts[0],gas:1000000});
MyContract.GetBalance();

Other Notes:
  1,000,000,000,000,000,000 Wei = 1 eth = one quadrilliong Wei
  How to send a normal transaction of ether to this address
    web3.eth.sendTransaction({from:web3.eth.accounts[0], to:EthWallet.address, value: web3.toWei(0.05, "ether")})
*/
