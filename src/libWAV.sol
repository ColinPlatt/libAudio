// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.13;

library WAV_8BIT {

    bytes4 constant RIFF_HDR = hex'52_49_46_46'; // RIFF
    bytes16 constant WAV_FMT_HDR = hex'57_41_56_45_66_6d_74_20_10_00_00_00_01_00_02_00'; // WAVE_fmt _ and constant from header  


    function reverse(uint32 input) internal pure returns (uint32 v) {
        v = input;

        // swap bytes
        v = ((v & 0xFF00FF00) >> 8) |
            ((v & 0x00FF00FF) << 8);

        // swap 2-byte long pairs
        v = (v >> 16) | (v << 16);
    }

    function fmtByteRate(uint32 sampleRate) internal pure returns (bytes12) {

        bytes4 lsbSampleRate = bytes4(reverse(sampleRate));


        return bytes12(
            bytes.concat(
                lsbSampleRate,
                lsbSampleRate,
                hex'01_00',
                hex'08_00'
            )
        );

    }

    function formatDataChunk(bytes memory audioData) internal pure returns (bytes memory) {
        return bytes.concat(
            bytes4('data'),
            bytes4(reverse(uint32(audioData.length))),
            audioData
        );
    }

    function encodeWAV(bytes memory _audioData, uint32 _sampleRate) internal pure returns (bytes memory) {

        uint32 audioSize = uint32(_audioData.length);

        return bytes.concat(
            RIFF_HDR,
            bytes4(reverse(audioSize+12)),
            WAV_FMT_HDR,
            bytes12(fmtByteRate(_sampleRate)),
            formatDataChunk(_audioData)
        );

    } 


}