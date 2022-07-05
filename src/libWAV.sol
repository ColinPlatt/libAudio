// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.13;

library WAV_8BIT {

    bytes4 constant RIFF_HDR = hex'52_49_46_46'; // RIFF
    bytes16 constant WAV_FMT_HDR = hex'57_41_56_45_66_6d_74_20_10_00_00_00_01_00_01_00'; // WAVE_fmt _ and constant from header  


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

    function encodeWAV(bytes memory _audioData, uint32 _sampleRate) internal pure returns (string memory) {

        uint32 audioSize = uint32(_audioData.length);

        return string.concat(
            'data:audio/wav;base64,',
            base64Encode(
                bytes.concat(
                    RIFF_HDR,
                    bytes4(reverse(audioSize+12)),
                    WAV_FMT_HDR,
                    bytes12(fmtByteRate(_sampleRate)),
                    formatDataChunk(_audioData)
                )
            )
        );

    } 

    function base64Encode(bytes memory data) internal pure returns (string memory result) {
        assembly {
            let dataLength := mload(data)

            if dataLength {
                // Multiply by 4/3 rounded up.
                // The `shl(2, ...)` is equivalent to multiplying by 4.
                let encodedLength := shl(2, div(add(dataLength, 2), 3))

                // Set `result` to point to the start of the free memory.
                result := mload(0x40)

                // Write the length of the string.
                mstore(result, encodedLength)

                // Store the table into the scratch space.
                // Offsetted by -1 byte so that the `mload` will load the character.
                // We will rewrite the free memory pointer at `0x40` later with
                // the allocated size.
                mstore(0x1f, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef")
                mstore(0x3f, "ghijklmnopqrstuvwxyz0123456789+/")

                // Skip the first slot, which stores the length.
                let ptr := add(result, 0x20)
                let end := add(ptr, encodedLength)

                // Run over the input, 3 bytes at a time.
                // prettier-ignore
                for {} iszero(eq(ptr, end)) {} {
                    data := add(data, 3) // Advance 3 bytes.
                    let input := mload(data)

                    // Write 4 characters. Optimized for fewer stack operations.
                    mstore8(    ptr    , mload(and(shr(18, input), 0x3F)))
                    mstore8(add(ptr, 1), mload(and(shr(12, input), 0x3F)))
                    mstore8(add(ptr, 2), mload(and(shr( 6, input), 0x3F)))
                    mstore8(add(ptr, 3), mload(and(        input , 0x3F)))
                    
                    ptr := add(ptr, 4) // Advance 4 bytes.
                }

                // Offset `ptr` and pad with '='. We can simply write over the end.
                // The `byte(...)` part is equivalent to `[0, 2, 1][dataLength % 3]`.
                mstore(sub(ptr, byte(mod(dataLength, 3), "\x00\x02\x01")), "==")

                // Allocate the memory for the string.
                // Add 31 and mask with `not(0x1f)` to round the
                // free memory pointer up the next multiple of 32.
                mstore(0x40, and(add(end, 31), not(0x1f)))
            }
        }
    }


}