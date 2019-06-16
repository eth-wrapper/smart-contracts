pragma solidity ^0.4.25;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract ETHWrapperToken is StandardToken{
    using SafeMath for uint256;

    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public totalSupply = 0;
        
    address private adminWallet;

    /**
     * @dev Constructor
     */
    constructor(
        string _name, 
        string _symbol,
        uint8 _decimals,
        address _adminWallet
    ) public{
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        adminWallet = _adminWallet;
    }


    /**
     * @dev Checks if msg.sender is admin
     */

    modifier isAdmin(){
        require(msg.sender == adminWallet);
        _;
    }

    
    /**
     * @dev Mint new tokens
     * @param _address The address
     * @param _value Boolean to represent the status
     */
    function mint(address _address, uint256 _value) public isAdmin{
        require(_address != address(0));
        balances[_address] = balances[_address].add(_value);
        totalSupply = totalSupply.add(_value);
        Transfer(0x0, _address, _value);
    }

    /**
     * @dev Customize transfer method. 
     * Burns the tokens when _to is the admin wallet
     *
     * @param _to The address
     * @param _value Amount
     */
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_value <= balances[msg.sender]);
        if(_to == adminWallet){
            balances[msg.sender] = balances[msg.sender].sub(_value);
            totalSupply = totalSupply.sub(_value);
            emit Transfer(msg.sender, address(0), _value);
        }else{
            super.transfer(_to, _value);
        }
        return true;
    }
}
