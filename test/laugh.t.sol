// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {WAV_8BIT} from "../src/libWAV.sol";

contract laughTest is Test {

    function testBuffer() public {

        uint256 Hz = 11025;

        bytes memory buf = new bytes(Hz*10);

        emit log_bytes(buf);


    }


}