// SPDX-License-Identifier: MIT

/**
 * SimpleToken is a simple token contract without cheating
 * This contract contains the minimum functions required for the token to operate.
 * Read Contract: _decimals, decimals, _name, name, _symbol, symbol, allowance, balanceOf, getOwner, totalSupply, owner.
 * Write Contract: transfer, transferFrom, approve, decreaseAllowance, increaseAllowance.
 * Write Contract, only for owner: renounceOwnership, transferOwnership.
 * Token created using DAppCrypto https://dappcrypto.github.io/
 */

 /**
 * Important! Always check liquidity lock before investing
 * Important! Always check if the token address is available in DAppCrypto https://dappcrypto.github.io/
 */

pragma solidity >=0.8.0;

import "./IERC20.sol";
import "./SafeMath.sol";
import "./Ownable.sol";

contract SimpleToken is Ownable, IERC20 {
    using SafeMath for uint256;
    bool private initializeToken = false;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    uint8 public _decimals;
    string public _symbol;
    string public _name;

    constructor() {
    _name = "RUBCOIN";
    _symbol = "RUBC";
    _decimals = 18;
    _totalSupply = 10000000 * 1000000000000000000;
    _balances[msg.sender] = _totalSupply;

    emit Transfer(address(0), msg.sender, _totalSupply);
  }


    function owner() external view returns (address) {
        return getOwner();
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address addressOwner, address spender) external view returns (uint256) {
        return _allowances[addressOwner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "Transfer amount exceeds allowance"));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue, "Decreased allowance below zero"));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= _balances[sender], "Transfer amount exceeds balance");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address addressOwner, address spender, uint256 amount) internal {
        require(addressOwner != address(0), "Approve from the zero address");
        require(spender != address(0), "Approve to the zero address");

        _allowances[addressOwner][spender] = amount;
        emit Approval(addressOwner, spender, amount);
    }
}