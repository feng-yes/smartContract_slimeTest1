pragma solidity 0.6.4;

import "./ABCToken.sol";

contract SlimeCoin is ABCToken {
    
    constructor() public {
      firstMint("SMT1 coin", "smt1", 100000000000000000000000000);
    }
}