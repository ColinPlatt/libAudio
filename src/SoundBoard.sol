// SPDX-License-Identifier: The Unlciense
pragma solidity ^0.8.13;

import {WAV_8BIT} from "./libWAV.sol";

contract SoundBoard {
    using WAV_8BIT for *;

    uint256 constant sampleRate = 8000;

    function tranceBeat(uint256 offset, uint256 length) public pure returns (bytes memory) {
        bytes memory buffer = new bytes(length);

        unchecked {
            for(uint256 t = offset; t<length+offset; ++t) {
                buffer[t-offset] = bytes1(uint8(t>>(t%16==0?4:6)|t>>(t%128==0?10:4)));
            }
        }

        return buffer;
    }



}