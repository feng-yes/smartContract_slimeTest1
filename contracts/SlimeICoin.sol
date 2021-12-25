// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface SlimeICoin is IERC20{

    function sendToPlayer(address recipient, uint256 amount) external returns (bool);

    function playerCost(address player, uint256 amount) external returns (bool);
}