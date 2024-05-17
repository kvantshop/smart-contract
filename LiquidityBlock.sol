// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
///
import "./Ownable.sol";
import "./SafeMath.sol";
import "./IERC20.sol";
import "./IUniswapV2Router02.sol";
/// contract LiquidityBlock
contract LiquidityBlock is Ownable {
    using SafeMath for uint256;
    receive() external payable {}
    fallback() external payable {}

    function addFirstLiquidity(address _addressSwapV2Router) public onlyOwner {
        address addressToken = address(this);
        uint256 amountTokens = IERC20(address(this)).balanceOf(address(this));
        uint256 amountETH = address(this).balance;

        require(IERC20(addressToken).approve(_addressSwapV2Router, amountTokens), "approve failed");
        IUniswapV2Router02(_addressSwapV2Router).addLiquidityETH{value: amountETH}(
            addressToken,
            amountTokens,
            amountTokens,
            amountETH,
            msg.sender,
            block.timestamp
        );
    }
}