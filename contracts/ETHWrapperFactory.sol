pragma solidity ^0.4.15;

import 'contracts/ETHWrapperToken.sol';


contract ETHWrapperFactory {

    function createToken(
        string _name, 
        string _symbol,
        uint8 _decimals,
        address _adminWallet
    ) public returns(address created){
        return new ETHWrapperToken(
            _name, 
            _symbol,
            _decimals,
            _adminWallet
        );
    }
}
