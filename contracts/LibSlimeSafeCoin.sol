// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./SlimeICoin.sol";
import "@openzeppelin/contracts/utils/Address.sol";

library LibSlimeSafeCoin {
    using Address for address;
    
    function safeDecreaseOwnerAllowance(SlimeICoin token, uint256 subtractedValue) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.decreaseOwnerAllowance.selector, subtractedValue));
    }

    function safeIncreaseOwnerAllowance(SlimeICoin token, uint256 addedValue) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.increaseOwnerAllowance.selector, addedValue));
    }

    function safeSendToPlayerOnly(SlimeICoin token, address player, uint256 amount) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.sendToPlayerOnly.selector, player, amount));
    }

    function safePlayerCostOnly(SlimeICoin token, address player, uint256 amount) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.playerCostOnly.selector, player, amount));
    }

    function safeSendToPlayer(SlimeICoin token, address recipient, uint256 amount) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.sendToPlayer.selector, recipient, amount));
    }

    function safePlayerCost(SlimeICoin token, address player, uint256 amount) internal{
        _callOptionalReturn(token, abi.encodeWithSelector(token.playerCost.selector, player, amount));
    }

    function safeTransfer(
        SlimeICoin token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        SlimeICoin token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        SlimeICoin token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        SlimeICoin token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        SlimeICoin token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(SlimeICoin token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}
