pragma solidity ^0.4.3;
contract StagePaymentWithHashApprove {
  address creator; //use this for back doors later

  //Set up inital variables
  //hashstage is used to store all the data required for an agreement
  struct hashstage {
    address creator;//or archatect
    address  client;
    uint num_stages;
    uint stage;
    uint[] stage_percentages;
    uint256 project_cost;
    bool[2] approved;//0 for creator, 1 for client
    string[] hash_list;//Position 0 is the origional contract
  }

  //Agreements mapping allows for users to create multiple agreements with a individual private key
  mapping(uint => hashstage) Agreements;

  //Accounts mapping allows for users to store and keep track of wei they input into this contract
  mapping(address => uint256) public Accounts;

  //AgreementByUser mapping is used to look up which addresses created which agreements, so far only keeps track of most recent contract
  mapping(address => uint) public AgreementByUser;

  //Keep track of agreements made so far, in retrospect should have used array fro Agreements
  uint num_agreements = 0;

  function StagePaymentWithHashApprove() {
    creator = msg.sender;
  }

  //Creates a new Agreement Object attached to msg.sender
  function CreateAgreement() {
    num_agreements += 1;
    AgreementByUser[msg.sender] = num_agreements;
    Agreements[num_agreements].creator = msg.sender;
  }

  function AddClient(uint _key, address _client){
    if(msg.sender == Agreements[_key].creator && Agreements[_key].approved[0] == false){
      Agreements[_key].client = _client;
    }
  }

  function AddProjectCost(uint _key, uint256 _project_cost){
    if(msg.sender == Agreements[_key].creator && Agreements[_key].approved[0] == false){
      Agreements[_key].project_cost = _project_cost;
    }
  }

  function AddNumStages(uint _key, uint _num_stages){
    if(msg.sender == Agreements[_key].creator && Agreements[_key].approved[0] == false){
      Agreements[_key].num_stages = _num_stages;
    }
    for(uint i; i < _num_stages; i++){
      Agreements[_key].stage_percentages.push(0);
      Agreements[_key].hash_list.push("0");
    }
  }

  function AddStagePercentage(uint _key, uint _num_stage, uint _percentage){
    if(msg.sender == Agreements[_key].creator && Agreements[_key].approved[0] == false){
      if(Agreements[_key].num_stages >= _num_stage){
        Agreements[_key].stage_percentages[_num_stage] = _percentage;
      }
    }
  }

  //
  function ApproveAgreementCreator(uint _key){
    bool _broken = false;
    if(msg.sender == Agreements[_key].creator){
      if(Agreements[_key].client == Agreements[0].client){
          _broken = true;
      }
      if(_broken == false){
        Agreements[_key].approved[0] = true;
      }
    }
  }

  function ApproveAgreementClient(uint _key){
    if(Agreements[_key].approved[0] == true && msg.sender == Agreements[_key].client){
            Agreements[_key].approved[1] = true;
    }
  }

  //The following functions can get information about areements if one knows the contract number or _key
  function GetCreator(uint _key) constant returns (address){
    return Agreements[_key].creator;
  }
  function GetClient(uint _key) constant returns (address){
    return Agreements[_key].client;
  }
  function GetCost(uint _key) constant returns (uint){
    return Agreements[_key].project_cost;
  }
  function GetNumStages(uint _key) constant returns (uint){
    return Agreements[_key].num_stages;
  }
  function GetStage(uint _key) constant returns (uint){
    return Agreements[_key].stage;
  }
  function GetPercentage(uint _key, uint _position) constant returns (uint){
    return Agreements[_key].stage_percentages[_position];
  }
  function GetApproved(uint _key, uint _pos) constant returns (bool){
    return Agreements[_key].approved[_pos];
  }
  function GetHash(uint _key, uint _stage) constant returns (string){
    return Agreements[_key].hash_list[_stage];
  }



  //This function can take payments from any user and store how much they sent this contract
  function ClientPayment() payable{
    Accounts[msg.sender] += msg.value;
  }

  /*function SendWei(address user, uint256 amount)constant returns (bool){
    if(msg.sender == owner){
      if (!user.send(amount)) throw;
      return true;
    }
    return false;
  }*/

  function GetBalance() constant returns (uint){
    return this.balance;
  }

  //Hash approval with payment logic
  function SubmitHash(uint _key, string _hash){
    if(msg.sender == Agreements[_key].creator && Agreements[_key].approved[1] == true){
      if(Agreements[_key].stage < Agreements[_key].num_stages){
        Agreements[_key].hash_list[Agreements[_key].stage] = _hash;
      }
    }
  }

  function ApproveHash(uint _key, bool _bool){
    if(msg.sender == Agreements[_key].client && Agreements[_key].approved[1] == true){
      if(Agreements[_key].stage < Agreements[_key].num_stages){
        Agreements[_key].stage += 1;
      }
    }
  }
}
/*
var TempContract = StagePaymentWithHashApprove;
var MyContract = web3.eth.contract(TempContract.abi).at(TempContract.address);
MyContract.CreateAgreement({from:web3.eth.accounts[0],gas:1000000});
MyContract.AddClient(1, web3.eth.accounts[1], {from:web3.eth.accounts[0],gas:1000000});
MyContract.AddProjectCost(1, 1000000000000000000, {from:web3.eth.accounts[0],gas:1000000}));
MyContract.AddNumStages(1, 3, {from:web3.eth.accounts[0],gas:1000000});
MyContract.AddStagePercentage(1, 0, 5, {from:web3.eth.accounts[0],gas:1000000});
MyContract.AddStagePercentage(1, 1, 10, {from:web3.eth.accounts[0],gas:1000000});
MyContract.AddStagePercentage(1, 2, 15, {from:web3.eth.accounts[0],gas:1000000});

MyContract.GetCreator(1);
MyContract.GetClient(1);
MyContract.GetCost(1);
MyContract.GetNumStages(1);
MyContract.GetPercentage(1,0);
MyContract.GetPercentage(1,1);
MyContract.GetPercentage(1,2);

MyContract.GetApproved(1, 0);
MyContract.GetApproved(1, 1);
MyContract.ApproveAgreementCreator(1, {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveAgreementClient(1, {from:web3.eth.accounts[1],gas:1000000});
MyContract.GetApproved(1, 0);
MyContract.GetApproved(1, 1);

MyContract.SubmitHash(1, "Hello", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(1, true, {from:web3.eth.accounts[1],gas:1000000});

MyContract.SubmitHash(1, "World", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(1, true, {from:web3.eth.accounts[1],gas:1000000});

MyContract.SubmitHash(1, "I Like Pie", {from:web3.eth.accounts[0],gas:1000000});
MyContract.ApproveHash(1, true, {from:web3.eth.accounts[1],gas:1000000});

MyContract.GetStage(1);
MyContract.GetHash(1,0);
MyContract.GetHash(1,1);
MyContract.GetHash(1,2);

MyContract.ClientPayment({from:web3.eth.accounts[0], to:EthWallet.address, value: web3.toWei(1, "ether")})
MyContract.ClientPayment({from:web3.eth.accounts[1], to:EthWallet.address, value: web3.toWei(2, "ether")})
MyContract.ClientPayment({from:web3.eth.accounts[2], to:EthWallet.address, value: web3.toWei(3, "ether")})
MyContract.GetBalance();
MyContract.Accounts(web3.eth.accounts[0]);
MyContract.Accounts(web3.eth.accounts[1]);
MyContract.Accounts(web3.eth.accounts[2]);
*/
