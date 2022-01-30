pragma solidity 0.6.0;

contract FundMe {
    address owner;
    uint256 internal totalFunds;
    mapping(address => uint256) fundsByAddress;

    constructor() public {
        owner = msg.sender;
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "Unauthorized!!");
        _;
    }

    function getOwnerAddress() public view ownerOnly returns (address) {
        return owner;
    }

    function getBalance() public view ownerOnly returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public payable ownerOnly {
        msg.sender.transfer(address(this).balance);
    }

    function addFund(uint256 _fund) internal {
        totalFunds += _fund;
    }

    function fund() public payable {
        fundsByAddress[msg.sender] += msg.value;
        addFund(msg.value);
    }

    function getDonationByAddress(address _address)
        public
        view
        returns (uint256)
    {
        if (msg.sender == _address || msg.sender == owner) {
            return fundsByAddress[_address];
        } else {
            revert();
        }
    }

    function getTotalFunds() public view ownerOnly returns (uint256) {
        return totalFunds;
    }
}
