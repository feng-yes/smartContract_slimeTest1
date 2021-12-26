// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./SlimeICoin.sol";
import "./Ownable.sol";
import "./SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SlimeNFT is IERC20, Ownable {

  using SafeMath for uint256;

  SlimeICoin private _tokenAddress;

  struct Slime {
    string sName;
    uint iDna;  // 基因是6位数
    uint iSkillId;
    uint iRank; // 稀有度 1-N，2-R，以此类推
    uint256 iExperience; //经验值
    uint256 iLevel; //等级
  }
  Slime[] public slimeList;
  mapping (uint256 => address) slimeIdxToOwner;
  uint256 slimeNFTCount;
  uint256 slimeNFTCreatedCount = 0;
  uint256 blindSellCost = 0.1 ether;
  
  mapping (address => uint) ownerSlimeCount;

  constructor(address _slimeICoin) {
    slimeNFTCount = 999999;
    setSlimeICoinAddres(_slimeICoin);
  }

  modifier notSupport() {
    require(false, "not support");
    _;
  }

  event NewSlime(uint256 idx, string name, uint256 dna);
  
  function setSlimeICoinAddres(address _slimeICoin) public {
    _tokenAddress = SlimeICoin(_slimeICoin);
  }
  
  function sendAward(address _to, uint256 amount) internal onlyOwner{
      _tokenAddress.sendToPlayer(_to, amount);
  }
  
  function playerCost(address _player, uint256 amount) internal {
      _tokenAddress.playerCost(_player, amount);
  }
  
  function checkMyCoinBalance() external view returns (string memory _uintAsString) {
    return uint2str(_tokenAddress.balanceOf(msg.sender));
  }
  
  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
  }
  
  function _generateRandomDna(string memory _str) private view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(_str, block.timestamp))) % (slimeNFTCount + 1);
  }

  function setBlindSellCost(uint256 price_) external onlyOwner returns (bool) {
    blindSellCost = price_;
    return true;
  }

  // TODO
  function blindSell(string memory _name) external {
    playerCost(msg.sender, blindSellCost);
    uint randDna = _generateRandomDna(_name);
    slimeList.push(Slime(_name, randDna, 0, 0, 0, 0));
    uint256 id = slimeList.length - 1;
    slimeIdxToOwner[id] = msg.sender;
    ownerSlimeCount[msg.sender] = ownerSlimeCount[msg.sender].add(1);
    slimeNFTCreatedCount = slimeNFTCreatedCount.add(1);
    emit NewSlime(id, _name, randDna);
  }

  function totalSupply() external view override returns (uint256){
    return slimeNFTCount;
  }

  function balanceOf(address account) external view override returns (uint256){
    return ownerSlimeCount[account];
  }

  function transfer(address recipient, uint256 amount) external notSupport override returns (bool){}

  function allowance(address owner, address spender) external view notSupport override returns (uint256){}

  function approve(address spender, uint256 amount) external notSupport override returns (bool){}

  function transferFrom(
      address sender,
      address recipient,
      uint256 amount
  ) external notSupport override returns (bool) {}
}
