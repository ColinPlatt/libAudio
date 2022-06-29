// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ASine} from "../src/ASine.sol";

contract ASineTest is Test {

    uint256 constant PI          = 3141592653589793238;
    uint256 constant PRECISION   = 10**18;

    ASine sin;

    function setUp() public {
        sin = new ASine();
    }

    function testOscillator() public {
       (bytes2 sample, uint256 angle) = sin.SineOscillator(440*PRECISION, 5*10**17, 0);

       emit log_bytes(abi.encodePacked(sample));
       emit log_uint(angle/PRECISION);
    }

    function testMath() public {
        uint256 offset = 2*PI * 440 / 44100;

        emit log_uint(offset);

    }

    function _testLoop() public {

        //uint256 duration = 2;
        uint256 sampleRate = 4410;

        uint256 angle;
        bytes2 sample;
        bytes memory rawData = new bytes(sampleRate * 2);

        sample = bytes2(hex"ab12");

        emit log_bytes(abi.encodePacked(sample[0]));
        emit log_bytes(abi.encodePacked(sample[1]));

        for(uint256 i = 0; i< sampleRate; i++) {
            (sample, angle) = sin.SineOscillator(440*PRECISION, int256(5*10**17), 0);
            rawData[i*2] = sample[0]; 
            rawData[i*2+1] = sample[1]; 
        }

        emit log_bytes(rawData);

    }

}
