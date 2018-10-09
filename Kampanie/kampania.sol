pragma solidity ^0.4.24;

contract CampaignContractCreator{
    //dynamic array with addresses of deployed campaign contracts
    address[] public campaigns; 
    
    function createCampaignContract(uint percentPartyI,  uint percentPartyII) public{
        address newCampaign = new CampaignContract(msg.sender, percentPartyI, percentPartyII);
        campaigns.push(newCampaign);
    }
}

contract CampaignContract {
    address public owner;
    uint public balancePartyI;
    uint public balancePartyII;
    uint public nofTickets;
    uint public balanceTickets;
    // mapping (string => uint) public ticketPrices;   

    struct ContractDetails {
        uint percentPartyI;
        uint percentPartyII;
    }
    ContractDetails public contractDetails;   
  
    event Ticket(string indexed _ticketId, uint _ticketPrice, uint _amtPartyI, uint _amtPartyII);

    constructor(address _owner, uint _percentPartyI,  uint _percentPartyII) public{
        owner = _owner;
        contractDetails.percentPartyI = _percentPartyI;
        contractDetails.percentPartyII = _percentPartyII;
    }
    
    // modifier onlyOwner(){
    //     require(msg.sender == owner);
    //     _;
    // } 
    
    function getConractDetails() public view returns(uint percentPartyI, uint percentPartyII ){
        return (contractDetails.percentPartyI, contractDetails.percentPartyII);
    }
    
    function getPartyIBalance() public view returns (uint){
        return balancePartyI;
    }
    function getPartyIIBalance() public view returns (uint){
        return balancePartyI;
    }
    function getTicketsBalance() public view returns (uint){
        return balanceTickets;
    }
    function getNofTickets() public view returns (uint){
        return nofTickets;
    }    

    //calculations based on contract 
    function settleTicket(string _ticketId, uint _ticketPrice) public returns (bool success){
        require(_ticketPrice > 0);

        uint amtPartyI;
        uint amtPartyII;

        // ticketPrices[_ticketId] = _ticketPrice;
        nofTickets += 1;
        balanceTickets += _ticketPrice;
        amtPartyI = _ticketPrice * contractDetails.percentPartyI / 100;
        balancePartyI += amtPartyI;
        amtPartyII = _ticketPrice * contractDetails.percentPartyII / 100;
        balancePartyII += amtPartyII;
         
        emit Ticket(_ticketId, _ticketPrice, amtPartyI, amtPartyII);

        return true;
    }
    
}


