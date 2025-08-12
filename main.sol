// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Election {
    address creater;
    uint256 electionTime;
    uint256 candidateIndex;

    error VotingIsFinished();
    error CandidateIsNotExist();
    error YouCanOnlyVoteOnce();
    error YouHaveToPay10Ethers();

    struct Candidate {
        string name;
        uint256 age;
        uint256 votes;
    }

    Candidate[] candidates;
    address[] voters;

    mapping(uint256 => uint256) numberOfVotes;
    mapping(address => uint256) votersVoice;

    constructor(uint256 _electionTime) {
        electionTime = block.timestamp + _electionTime;
        candidates.push(Candidate({name: "Donald Trump", age: 79, votes: 0}));
        candidates.push(Candidate({name: "Vladimir Putin", age: 73, votes: 0}));
        candidates.push(Candidate({name: "Xi Jinping", age: 72, votes: 0}));
        voters.push(msg.sender);
    }

    modifier VoteIsNotEnd() {
        require(block.timestamp < electionTime, VotingIsFinished());
        _;
    }

    modifier CandidateIsExist(string memory _candidateName) {
        bool found = false;

        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i].name)) == keccak256(abi.encodePacked(_candidateName))) {
                candidateIndex = i;
                found = true;
                break;
            }
        }

        require(found == true, CandidateIsNotExist());
        _;
    }

    modifier isFirstTime(address _voterAddress) {
        bool alreadyVoted = false;

        for (uint i = 0; i < voters.length; i++) {
            if (voters[i] == _voterAddress) {
                alreadyVoted = true;
                break;
            }
        }

        require(!alreadyVoted, "YouCanOnlyVoteOnce");
        _;
    }

    function vote(string memory _candidateName) public VoteIsNotEnd CandidateIsExist(_candidateName) isFirstTime(msg.sender) payable {
        candidates[candidateIndex].votes += msg.value;
        voters.push(msg.sender);
    }

    function nominateCandidate(string memory _name, uint256 _age) public payable returns(string memory) {
        require(msg.value >= 10 ether, YouHaveToPay10Ethers());

        candidates.push(Candidate({name: _name, age: _age, votes: msg.value}));
        return("Congratulations, you were able to nominate your candidate!");
    }

    function aboutCandidate(string memory _candidateName) public view returns(Candidate memory) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i].name)) == keccak256(abi.encodePacked(_candidateName))) {
                return(candidates[i]);
                break;
            }
        }
    }

    function getWinner() public view returns(string memory) {
        uint256 winnerIndex = 0;

        for (uint256 i = 1; i < candidates.length; i++) { // Start from index 1, as 0 is already the initial winner
            if(candidates[winnerIndex].votes < candidates[i].votes) {
                winnerIndex = i;
            }
        }

        return candidates[winnerIndex].name;
    }
}
