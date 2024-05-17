/// SPDX-License-Identifier: MIT
/**
 * KvantCoin
 * 
 * website: https://kvant.shop
 * telegram: t.me/kvantcoin
 *
*/
pragma solidity >=0.8.25;
/// 
import "./LiquidityBlock.sol";
import "./SafeMath.sol";
import "./ERC20.sol";
/// 
contract KvantCoin is ERC20, LiquidityBlock {
    using SafeMath for uint256;
    bool public limited;
    uint256 public maxHoldingAmount;
    uint256 public minHoldingAmount;
    mapping(address => bool) public blacklists;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;

    constructor(uint256 _totalSupply) ERC20("KvantCoin", "KTC") {
        _mint(msg.sender, _totalSupply);
    }

    function blacklist(
        address _address, 
        bool _isBlacklisting
        ) external onlyOwner {
        blacklists[_address] = _isBlacklisting;
    }

    function setRule(
        bool _limited, 
        address _uniswapV2Pair, 
        uint256 _maxHoldingAmount, 
        uint256 _minHoldingAmount
        ) external onlyOwner {
        limited = _limited;
        uniswapV2Pair = _uniswapV2Pair;
        maxHoldingAmount = _maxHoldingAmount;
        minHoldingAmount = _minHoldingAmount;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) override internal virtual {
        require(!blacklists[to] && !blacklists[from], "Blacklisted");

        if (uniswapV2Pair == address(0)) {
            require(from == owner() || to == owner(), "trading is not started");
            return;
        }

        if (limited && from == uniswapV2Pair) {
            require(super.balanceOf(to) + amount <= maxHoldingAmount && super.balanceOf(to) + amount >= minHoldingAmount, "Forbid");
        }
    }

    function burn(uint256 value) external {
        _burn(msg.sender, value);
    }
}