// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {WAV_8BIT} from "../src/libWAV.sol";


import {Trigonometry} from "solidity-trigonometry/Trigonometry.sol";


import {ABDKMath64x64} from "abdk-libraries-solidity/ABDKMath64x64.sol";
import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";



contract logWavesTest is Test {
    using ABDKMath64x64 for *;
    using Trigonometry for *;
    using FixedPointMathLib for uint256;

    int256 constant s = 1;
    int256 constant mu = 1;
    
    int256 constant SQRT_PI_2 = 2.506628 * 1e6;

    function _testFunction() public {
        int256 x = 2;

        int256 first = (x*s*SQRT_PI_2);

        emit log_int(first.fromInt().inv());

        int128 second = x.fromInt().ln().sub(mu.fromInt());

        emit log_int(second.mul(second));

        int128 third = (2*s**2).fromInt();

        emit log_int(third);  

        int128 forth = second.neg().div(third).exp();

        emit log_int(forth);  

        int256 fifth = forth.muli(first);

        emit log_int(fifth);


    }

    uint256 constant PI = 3141592653589793238;
    uint256 constant TWO_PI = 2*PI;

    uint256 constant frequency = 110; 

    function _testStep() public {

        uint256 length = 11025*5;
        uint256 height = 250;
        uint256 mid = length/4;
        uint256 end = length-mid;

        bytes memory buf = new bytes(length);

        uint8 level;

        int256[] memory wave = new int256[](frequency);

        unchecked{

            for (uint256 i = 0; i<frequency; i++) {
                wave[i] = sinusoidWave1(i, frequency);
            }

            uint8 tick = uint8(mid / height);

            for (uint256 i = 0; i<mid; i++) {
                buf[i] = bytes1(level);
                if(i%tick==0) {
                    level++;
                }
                
            }

            tick = uint8((end-mid)/height);

            uint8 sample;

            for (uint256 i = mid; i<length; i++) {
                sample = uint8(int8(128+((int8(level)*wave[i%frequency])/1e18)));
                buf[i] = bytes1(sample);
                if(level > 1 && i%tick==0) {
                    level--;
                }
            }
        }

        //emit log_string();
        string memory WAV_FILE = WAV_8BIT.encodeWAV(buf, uint32(11025));

        _writeToFile(WAV_FILE, "test/test_wav.txt");

    }

    function _testSquare() public {

        uint256 length = 11025*5;
        uint8 high = 10;

        bytes memory buf = new bytes(length);


        int256[] memory wave = new int256[](frequency);

        unchecked{

            for (uint256 i = 0; i<frequency; i++) {
                wave[i] = sinusoidWave1(i, frequency);
            }

            uint256 count;

            uint8 sample;

            for (uint256 i = 0; i<length; i++) {
                if(i%(frequency*5)==0) {
                    count = 0;
                } 
                if(count < 880) {
                    sample = uint8(int8(128+((int8(high*uint8(count/100)))*wave[i%frequency])/1e18));
                    buf[i] = bytes1(sample);
                    count++;
                } else {
                    sample = uint8(int8(128+((int8(high)*wave[i%frequency])/1e18)));
                    buf[i] = bytes1(sample);
                }
                
            }

        }

        //emit log_string();
        string memory WAV_FILE = WAV_8BIT.encodeWAV(buf, uint32(11025));

        _writeToFile(WAV_FILE, "test/test_sq_wav.txt");

    }

    function testViznut() public {


        uint256 length = 8000*10;

        bytes memory buf = new bytes(length);

        unchecked{

            for (uint256 i = 0; i<length; i++) {
                buf[i] = (sampleFormula(i) & hex'FF');               
            }

        }

        //emit log_string();
        string memory WAV_FILE = WAV_8BIT.encodeWAV(buf, uint32(8000));

        _writeToFile(WAV_FILE, "test/test_viznut_wav.txt");


    }

    function sampleFormula(uint256 t) public pure returns (bytes1) {

        return bytes1(uint8((t*10)&(t*10)>>8));


    }

    function testMath() public {
        for(uint t = 100; t<1000; t+=10) {
            emit log_uint((t*10)&(t*10)>>8);
        }


    }





    uint256 constant SCALE = 1e18 * 2 * PI; 

    uint256 constant TWO_THIRDS = 666666666666666666;
    uint256 constant FREQ = 11025;

    function testWave() public {

        uint256 t = 51;
        uint256 hz = frequency;

        uint256 f = hz.divWadDown(FREQ);

        int256 firstSin = ((PI*t).mulWadDown(f).sin())**3/1e18**2;

        int256 secondSin = (PI.mulWadDown((t*1e18).mulWadDown(f)+TWO_THIRDS)).sin();

        emit log_int(firstSin + secondSin);

        emit log_int(sinusoidWave1(t, hz));


    }

    function sinusoidWave1(uint256 t, uint256 hz) public pure returns (int256 y) {

        unchecked{
            uint256 f = hz.divWadDown(FREQ);

            int256 firstSin = ((PI*t).mulWadDown(f).sin())**3/1e18**2;

            int256 secondSin = (PI.mulWadDown((t*1e18).mulWadDown(f)+TWO_THIRDS)).sin();


            return firstSin+secondSin;
        }
    }


    function _writeToFile(string memory line, string memory filePath) internal {
        string[] memory inputs = new string[](5);
        inputs[0] = "./script/write-to-file.sh";
        inputs[1] = "-f";
        inputs[2] = filePath;
        inputs[3] = "-i";
        inputs[4] = line;

        vm.ffi(inputs);
    }

}