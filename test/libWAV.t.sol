// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {WAV_8BIT} from "../src/libWAV.sol";

contract libWAVTest is Test {

    function testEncode() public {

        bytes memory testData = abi.encodePacked("test data");

        emit log_bytes(testData);

        bytes memory audioFile = WAV_8BIT.encodeWAV(testData, uint32(22050));

        emit log_bytes(audioFile);

    }

}