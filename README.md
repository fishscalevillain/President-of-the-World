# World Leaders Election Smart Contract

This repository contains a Solidity smart contract for a decentralized election of world leaders. Users can nominate candidates by paying a nomination fee, and voters can cast votes for their preferred candidate.

## Features

•   **Decentralized and Transparent Election:** The election process is governed by a smart contract on the Ethereum blockchain, ensuring transparency, immutability, and security.
•   **Candidate Nomination:** Users can nominate a candidate by paying a nomination fee of 10 Ether.  This adds them to the pool of candidates.
•   **Voting:**  Registered voters can cast their vote for their chosen candidate by sending Ether.  The amount of Ether sent contributes to the candidate's vote count.
•   **Limited Voting Period:** The election has a predefined voting period set during contract deployment.
•   **Winner Determination:**  The contract allows anyone to query the winner after the election period is over.

## How it Works

1.  **Deployment:** The contract is deployed with an initial set of default candidates (Donald Trump, Vladimir Putin, Xi Jinping).  The contract creator also sets the election time.
2.  **Nomination:**  Users can nominate additional candidates by calling the `nominateCandidate` function and paying the nomination fee (10 Ether).  This contributes 10 Ether to the candidate's total votes.
3.  **Voting:**  Users vote by calling the `vote` function and sending Ether. The Ether amount they send is added to the candidate's vote count. Note that only one vote is allowed per address.
4.  **Election End:** Once the voting period has ended, anyone can call the `getWinner` function to determine the candidate with the most votes.
