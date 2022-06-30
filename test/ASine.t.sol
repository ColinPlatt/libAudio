// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {ASine} from "../src/ASine.sol";

import {Trigonometry} from "solidity-trigonometry/Trigonometry.sol";


import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";

contract ASineTest is Test {
    using FixedPointMathLib for uint256;
    using Trigonometry for *;

    uint256 constant PI          = 3141592653589793238;
    uint256 constant PRECISION   = 10**18;

    ASine sin;

    function setUp() public {
        sin = new ASine();
    }

    function testOscillator() public {

        //function SineOscillator(uint256 frequency, int8 amplitude, uint8 mid, uint256 iterations) internal pure returns (bytes memory)

       bytes memory WaveData = sin.SineOscillator(uint256(440), int8(5), uint8(127), uint256(10));

       emit log_bytes(WaveData);
    }

    

    function testMath() public {
        uint256 offset = 2*PI * 440 / 20050;
        

        bytes1 byteSample = sin.Oscillation(int8(1), offset*2, uint8(127));

        //uint256 offset = Trigonometry.TWO_PI * frequency / sampleRate;

        uint256 secondsample = (127*uint256((offset*2).sin())/PRECISION)+127;

        emit log_uint(secondsample);

        emit log_uint(offset);
        emit log_uint(uint8(byteSample));

    }

    /*function _testLoop() public {

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


    }*/
    

}
