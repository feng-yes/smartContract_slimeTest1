// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./SafeMath.sol";
import "./SlimeTokenbase.sol";

contract SlimeCoin is SlimeTokenbase {
    using SafeMath for uint256;

    uint16 _adminsId = 0;

    struct AdminMgr
    {
      // admins => adminsId
      mapping(address=>uint16) map;
      address[] keys;
    }
    AdminMgr _adminMgr;

    modifier onlyAdmin() {
      require(_adminMgr.map[msg.sender] != 0, "not admin");
      _;
    }
    
    constructor() ERC20("SMT1 coin", "smt1") {
        _mint(msg.sender, 12000000 * (10 ** uint256(decimals())));
    }

    function mint(address account, uint256 amount) external onlyOwner returns (bool) {
      _mint(account, amount);
      return true;
    }

    function burn(address account, uint256 amount) external onlyOwner returns (bool) {
      _burn(account, amount);
      return true;
    }
    
    function setAdmin(address account) external onlyOwner returns (uint) {
      require(_adminMgr.map[account] == 0, "already admin");
      _adminsId++;
      _adminMgr.map[account] = _adminsId;
      _adminMgr.keys.push(account);
      return _adminsId;
    }

    function changeAdminAddress(uint16 adminsId_, address account) external onlyOwner {
      require(_adminMgr.map[account] == 0, "already admin");
      address oldAdmin;
      uint keyIndex;
      for (uint i = 0; i<_adminMgr.keys.length; i++){
          if (_adminMgr.map[_adminMgr.keys[i]] == adminsId_) {
              oldAdmin = _adminMgr.keys[i];
              keyIndex = i;
              break;
          }
      }
      require(oldAdmin != address(0), "adminsId not exist");

      uint256 allowanceCoins = allowance(owner(), oldAdmin);
      _approve(owner(), oldAdmin, 0);
      _approve(owner(), account, allowanceCoins);

      delete _adminMgr.map[oldAdmin];
      _adminMgr.map[account] = adminsId_;
      // replace, not change len
      _adminMgr.keys[keyIndex] = account;
    }

    function delAdminByAddress(address admin) external onlyOwner {
      require(_adminMgr.map[admin] != 0, "not admin");

      delete _adminMgr.map[admin];
      // reduce key len
      uint keyIndex;
      for (uint i = 0; i<_adminMgr.keys.length; i++){
          if (admin == _adminMgr.keys[i]) {
              keyIndex = i;
              break;
          }
      }
      if (keyIndex != _adminMgr.keys.length - 1) {
        for (uint i = keyIndex; i<_adminMgr.keys.length - 1; i++){
            _adminMgr.keys[i] = _adminMgr.keys[i+1];
        }
      }
      // delete _adminMgr.keys[_adminMgr.keys.length-1];
      // _adminMgr.keys.length--;
      _adminMgr.keys.pop();

      _approve(owner(), admin, 0);
    }

    // function burnFrom(address account, uint256 amount) external onlyAdmin returns (bool) {
    //   _burnFrom(account, amount);
    //   return true;
    // }
    
    function checkAdminLen() external view onlyOwner returns (uint) {
      return _adminMgr.keys.length;
    }
    
    function getAdminByKeyIndex(uint i) external view onlyOwner returns (address) {
      return _adminMgr.keys[i];
    }
    
    function getAdminIDByAdress(address admin) external view onlyOwner returns (uint256) {
      return _adminMgr.map[admin];
    }
    
    function getAdminAdressByID(uint16 adminsId_) external view onlyOwner returns (address) {
      uint keyIndex;
      bool bFind = false;
      for (uint i = 0; i<_adminMgr.keys.length; i++){
          if (_adminMgr.map[_adminMgr.keys[i]] == adminsId_) {
              keyIndex = i;
              bFind = true;
              break;
          }
      }
      require(bFind, "adminsId not exist");
      return _adminMgr.keys[keyIndex];
    }
    
    function checkAdminAllowance(address admin) external view returns (uint256) {
      return allowance(owner(), admin);
    }

    function sendToPlayer(address player, uint256 amount) external onlyAdmin returns (bool) {
      transferFrom(owner(), player, amount);
      return true;
    }
    
    function playerCost(address player, uint256 amount) external onlyAdmin returns (bool) {
      _transfer(player, owner(), amount);
      _approve(owner(), _msgSender(), allowance(owner(), _msgSender()).add(amount));
      return true;
    }
}