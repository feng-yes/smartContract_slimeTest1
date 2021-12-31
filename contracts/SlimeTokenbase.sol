// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

abstract contract SlimeTokenbase is ERC20Pausable, Ownable {

    function mint(address account, uint256 amount) external onlyOwner returns (bool) {
      _mint(account, amount);
      return true;
    }

    function burn(address account, uint256 amount) external onlyOwner returns (bool) {
      _burn(account, amount);
      return true;
    }

    function PauseContract() external onlyOwner {
      _pause();
    }

    function StopPauseContract() external onlyOwner {
      _unpause();
    }
}