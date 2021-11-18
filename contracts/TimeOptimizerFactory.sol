// "SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.8.0;

import "./TimeOptimizer.sol";

contract TimeOptimizerFactory {

    /* Array of addresses of all existing TimeOptimizer created by the Factory */
    address[] public timeOptimizers;
   
    /* Mapping storing the optimizers addresses of a given user */
    mapping(address => address[]) public timeOptimizerByOwner; 

    /* Create an Optimizer for the user */
    function createTimeOptimizer(
        address _timeStakingAddr,
        address _uniV2RouterAddr,
        address _mooCurveZapAddr
    ) external returns(address) {
        
        TimeOptimizer timeOptimizer = new TimeOptimizer(
            _timeStakingAddr,
            _uniV2RouterAddr,
            _mooCurveZapAddr
        );
        /* Register the newly created optimizer address to the contract storage */
        timeOptimizers.push(address(timeOptimizer));

        /* Register the newly created optimizer address for the given user */
        timeOptimizerByOwner[msg.sender].push(address(timeOptimizer));

        /* Transfer the Optimizer ownership to the user */
        timeOptimizer.transferOwnership(msg.sender);

        return address(timeOptimizer);
    }

    function getOptimizerCount() external view returns(uint) {
        return timeOptimizers.length;
    } 
    
    function getOwnerOptimizers(address _owner) external view returns(address[] memory) {
        return timeOptimizerByOwner[_owner];
    }
}



