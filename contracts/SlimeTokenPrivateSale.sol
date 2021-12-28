// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./SlimeICoin.sol";
import "./Ownable.sol";
import "./SafeMath.sol";
import "./LibSlimeSafeCoin.sol";
import "@openzeppelin/contracts/token/ERC20/utils/TokenTimelock.sol";

contract SlimeTokenPrivateSale is Ownable {
  using LibSlimeSafeCoin for SlimeICoin;
  using SafeMath for uint256;

  SlimeICoin _tokenAddress;
  uint divCount = 3;
  uint releaseTimePre = 30 days;
  uint256 public price = 0.1 ether;

  struct sendEvent
  {
      address beneficiary;
      uint256 amount;
      uint256 releaseTime;
      bool bTake;
  }
  struct sendEventList
  {
      mapping(uint => sendEvent) map;
      uint size;
  }
  mapping(address=>sendEventList) beneficiaryMap;

  constructor(address _slimeICoin) {
    setSlimeICoinAddres(_slimeICoin);
  }
  
  function setSlimeICoinAddres(address _slimeICoin) public onlyOwner {
    _tokenAddress = SlimeICoin(_slimeICoin);
  }
  
  function setPrice(uint256 _value) external onlyOwner {
    price = _value;
  }

  function buyCoins() external payable{
    uint256 amountAll = msg.value / price;
    require(amountAll >= 100, 'No enough money');
    _tokenAddress.safeDecreaseOwnerAllowance(amountAll);

    uint256 amountPre = amountAll.div(divCount + 1);
    uint256 amountLast = amountAll - amountPre * divCount;
    
    _tokenAddress.safeSendToPlayerOnly(msg.sender, amountLast);

    sendEventList storage sl = beneficiaryMap[msg.sender];
    sl.size = 0;
    for (uint index = 0; index < divCount; index++) {
        sendEvent memory s;
        s.beneficiary = msg.sender;
        s.amount = amountPre;
        s.releaseTime = block.timestamp + (index + 1) * releaseTimePre;
        s.bTake = false;
        sl.map[index] = s;
        sl.size++;
    }
  }
  
  function release() external returns (bool) {
    sendEventList storage sl = beneficiaryMap[msg.sender];

    require(sl.size >= 1, "please buy coins");

    uint256 amountAll;
    for (uint i = 0; i < sl.size; i++) {
        if (!sl.map[i].bTake && block.timestamp >= sl.map[i].releaseTime) {
            amountAll += sl.map[i].amount;
            sl.map[i].bTake = true;
        }
    }

    require(amountAll > 0, "no coins to release");
    _tokenAddress.safeSendToPlayerOnly(msg.sender, amountAll);
    return true;
  }
}