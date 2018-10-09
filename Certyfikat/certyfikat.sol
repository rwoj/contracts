pragma solidity ^0.4.25;


// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------

contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function transfer(address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    
    //function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    //function approve(address spender, uint tokens) public returns (bool success);
    //function transferFrom(address from, address to, uint tokens) public returns (bool success);
    //event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Certyficate is ERC20Interface{
    // string public name = "Cryptos";
    // string public symbol = "CRPT";
    // uint public decimals = 0;
    
    uint public quantity;
    address public issuer;
    
    mapping(address => uint) public balances;
    
    struct CertyficateDetails {
        string description;
        uint liczba;
    }
    CertyficateDetails public certyficateDetails;
    
  
    event Transfer(address indexed _from, address indexed _to, uint _quantity);


    constructor(uint _quantity) public{
        quantity = _quantity;
        issuer = msg.sender;
        balances[issuer] = quantity;
    }
    
    modifier onlyOwner(){
        require(msg.sender == issuer);
        _;
    } 

    function enterCertyficateDetails(string _description, uint _liczba) public onlyOwner returns (bool success){
        certyficateDetails.description = _description;
        certyficateDetails.liczba = _liczba;
        return true;
    }    
    
    function getCerfificateDetails() public view returns(string description, uint liczba ){
        return (certyficateDetails.description, certyficateDetails.liczba);
    }
    
    function totalSupply() public view returns (uint){
        return quantity;
    }
    
    function balanceOf(address _owner) public view returns (uint _ownerBalance){
         return balances[_owner];
     }
     
     
    //transfer from the owner balance to another address
    function transfer(address to, uint _quantity) public returns (bool success){
         require(balances[msg.sender] >= _quantity && _quantity > 0);
         
         balances[to] += _quantity;
         balances[msg.sender] -= _quantity;
         
         emit Transfer(msg.sender, to, _quantity);
         
         return true;
     }
    
}


