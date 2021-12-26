// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IBEP20.sol";

interface SlimeICoin is IBEP20{

    function decreaseOwnerAllowance(uint256 subtractedValue) external returns (bool);

    function increaseOwnerAllowance(uint256 addedValue) external returns (bool);

    function sendToPlayerOnly(address player, uint256 amount) external returns (bool);

    function playerCostOnly(address player, uint256 amount) external returns (bool);

    function sendToPlayer(address recipient, uint256 amount) external returns (bool);

    function playerCost(address player, uint256 amount) external returns (bool);
}