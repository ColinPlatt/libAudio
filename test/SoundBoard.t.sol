// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {WAV_8BIT} from "src/libWAV.sol";
import {SoundBoard} from "src/SoundBoard.sol";

contract SoundBoardTest is Test {
    using WAV_8BIT for *;

    SoundBoard soundBoard;

    function setUp() public {
        soundBoard = new SoundBoard();
    }

    function _writeAsSite(string memory _filename, string memory _data) internal {

        string memory site = string.concat(
            '<!DOCTYPE html><html><head><meta charset="utf-8"><title>WAV</title></head><body><audio controls loop><source src="',
            _data,
            '" type="audio/wav"></audio></body></html>'
        );


        vm.writeFile(string.concat('test/output/',_filename,'.html'), site);
    }

    function testTranceBeat() public  {
        // should return 5 seconds of play
        _writeAsSite("tranceBeat", soundBoard.tranceBeat(80_000, 8_000 * 20).encodeWAV(8_000));
    }


}