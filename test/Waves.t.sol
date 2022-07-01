// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";


import {Trigonometry} from "solidity-trigonometry/Trigonometry.sol";


import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";

contract WavesTest is Test {
    using FixedPointMathLib for uint256;
    using Trigonometry for *;

    uint256 constant uPRECISION = 1e18;
    int256  constant sPRECISION = 1e18;
    int256  constant sPI = 3141592653589793238;
    uint256 constant PI = 3141592653589793238;
    uint256 constant TWO_PI = 2*PI;

    function testMath() public {
        uint256 t = 1;
        uint256 frequency = 1e16;

       // emit log_string("part1");
        int256 part1 = ((t*frequency*TWO_PI)/1e18).sin();
       // emit log_int(part1);

        //emit log_string("part2");
        int256 part2 = (((3*t*frequency*TWO_PI)/1e18).sin())/3;
        //emit log_int(part2);

       // emit log_string("part3");
        int256 part3 = (((5*t*frequency*TWO_PI)/1e18).sin())/5;
        //emit log_int(part3);

        //emit log_string("part4");
        int256 part4 = (((7*t*frequency*TWO_PI)/1e18).sin())/7;
        //emit log_int(part4);

        //emit log_string("part5");
        int256 part5 = (((9*t*frequency*TWO_PI)/1e18).sin())/9;
        //emit log_int(part5);

        //emit log_string("joint");
        int256 joint = part1 + part2 - part3 + part4 - part5; 
        //emit log_int(joint);

        bytes memory output = new bytes(100);

        for(uint256 i = 0; i<10000; i++) {
            //emit log_uint(squaredWave(i, int256(30),frequency));
            output[i] = bytes1(squaredWave(i, int256(30),frequency));
        }
        
        emit log_bytes(output);





        
        //emit log_int((int256((2*uPRECISION*uPRECISION)/Trigonometry.PI)*((Trigonometry.sin((Trigonometry.TWO_PI*125*1e16*1)/uPRECISION)/2*1e17)/sPRECISION).atan1to1())/sPRECISION);
    }





    function squaredWave(uint256 t, int256 amplitude, uint256 frequency) public pure returns (uint8 y) {
        int256 part1 = ((t*frequency*TWO_PI)/1e18).sin();
        int256 part2 = (((3*t*frequency*TWO_PI)/1e18).sin())/3;
        int256 part3 = (((5*t*frequency*TWO_PI)/1e18).sin())/5;
        int256 part4 = (((7*t*frequency*TWO_PI)/1e18).sin())/7;
        int256 part5 = (((9*t*frequency*TWO_PI)/1e18).sin())/9;
        int256 joint = part1 + part2 - part3 + part4 - part5; 

        return uint8(uint256(127+int256((joint * amplitude)/1e18)));
    }

    function squaredWave


}
