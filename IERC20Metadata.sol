/// SPDX-License-Identifier: MIT
import "./IERC20.sol";
pragma solidity >=0.8.25;
// File @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol@v4.4.0
// OpenZeppelin Contracts v4.4.0 (token/ERC20/extensions/IERC20Metadata.sol)
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}