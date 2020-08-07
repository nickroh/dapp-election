pragma solidity 0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => uint) public voters;
    // Read/write candidates
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("can3");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);

    }

    function register() public{
        require(0==voters[msg.sender],"This Voter has already voted!");

        voters[msg.sender] = 10;
    }

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(10==voters[msg.sender],"This Voter has already voted!");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "There is no such candidate");

        // record that voter has voted
        voters[msg.sender] = 20;

        // update candidatte vote Count
        candidates[_candidateId].voteCount++;

        //triger voted event
        emit votedEvent(_candidateId);
    }

    event votedEvent(
        uint indexed _candidateId
    );
}