pragma solidity 0.6.4;

import "./SlimeICoin.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract SlimeNFT is Ownable {

  using SafeMath for uint256;

  SlimeICoin private _tokenAddress;

  struct Slime {
    string sName;
    uint iDna;  // 基因是6位数
    uint iSkillId;
    uint iRank; // 稀有度 1-N，2-R，以此类推
    uint64 iExperience; //经验值
    uint32 iLevel; //等级
  }

  Slime[] public slimeList;

  constructor(address _slimeICoin) public {
    setSlimeICoinAddres(_slimeICoin);
  }
  
  function setSlimeICoinAddres(address _slimeICoin) public {
    _tokenAddress = SlimeICoin(_slimeICoin);
  }
  
  function transferloomtoken(address _to, uint256 amount) public {
      _tokenAddress.transfer(_to, amount);
  }
  
  function checkBalance(address account) external view returns (string memory _uintAsString) {
    return uint2str(_tokenAddress.balanceOf(account));
  }
  
  function checkMyBalance() external view returns (string memory _uintAsString) {
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
//   function getContractTest(string memory _str) private view returns (uint) {
//     return uint(keccak256(abi.encodePacked(_str,now))) % dnaModulus;
//   }

//   function callText(uint _price) external onlyOwner {
//     zombiePrice = _price;
//   }

}
