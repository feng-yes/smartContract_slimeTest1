pragma solidity 0.6.4;

import "./IABCToken.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract SlimeNFT is Ownable {

  using SafeMath for uint256;

  IABCToken private _tokenAddress;

  struct Slime {
    string sName;
    uint iDna;  // 基因是6位数
    uint iSkillId;
    uint iRank; // 稀有度 1-N，2-R，以此类推
    uint64 iExperience; //经验值
    uint32 iLevel; //等级
  }

  Slime[] public slimeList;

  constructor(IABCToken ABCToken) public {
    _tokenAddress = ABCToken;
  }
  
  function transferloomtoken(address _to, uint256 amount) public {
    //   IABCToken token = IABCToken(tokenAddress);
      _tokenAddress.transfer(_to, amount);
  }

//   function getContractTest(string memory _str) private view returns (uint) {
//     return uint(keccak256(abi.encodePacked(_str,now))) % dnaModulus;
//   }

//   function callText(uint _price) external onlyOwner {
//     zombiePrice = _price;
//   }

}
