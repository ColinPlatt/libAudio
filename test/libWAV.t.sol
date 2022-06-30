// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {WAV_8BIT} from "../src/libWAV.sol";

contract libWAVTest is Test {

    function testEncode() public {
        

        //bytes memory testData = abi.encodePacked(hex'8080A2A2B1B1B9B9BEBEC0C0BFBFBBBBB5B5ABAB9C9C6A6A595950504B4B494949494B4B50505757626279799C9DA7A7ADADB1B1B3B3B2B2AFAFAAAAA2A2949469695C5C54544F4F4D4D4D4D4E4E5353595964648C8C9F9FA8A8AEAEB1B1B3B3B2B2AEAEA9A9A0A08F8F66665A5A53534F4F4D4D4D4D4F4F54545B5B67679292A1A1A9A9AFAFB2B2B2B2B1B1ADADA7A79E9E88886363595952524E4E4D4D4D4D505055555D5D6B6B9696A3A3ABABAFAFB2B2B2B2B0B0ACACA6A69B9B74746161575751514E4E4D4D4E4E515156565F5F6F6F9999A4A4ACACB0B0B2B2B2B2B0B0ABABA4A498986E6E5F5F565651514E4E4D4D4E4E52525858616176769B9BA6A6ACACB0B0B2B2B2B2AFAFAAAAA2A295956A6A5D5D555550504D4D4D4D4F4F53535959646489899E9EA7A7ADADB1B1B2B2B1B1AEAEA9A9A0A0919167675B5B54544F4F4D4D4D4D4F4F54545B5B66669090A0A0A9A9AEAEB1B1B2B2B1B1ADADA7A79E9E8B8B64645A5A53534F4F4D4D4E4E505055555D5D6A6A9494A2A2AAAAAFAFB1B1B2B2B0B0ACACA6A69C9C77776262585852524F4F4D4D4E4E515156565F5F6E6E9797A3A4ABABAFAFB1B1B2B2B0B0ABABA4A4999970706060575751514E4E4D4D4E4E52525857616173739A9AA5A5ACACB0B0B2B2B1B1AFAFAAAAA3A396966C6C5E5E565651514E4E4D4D4F4F53535959636385859D9DA6A6ADADB0B0B2B2B1B1AEAEA9A9A1A1929268685C5C555550504E4E4E4E505054545B5B66668E8E9F9FA8A8ADADB1B0B2B1B0B0ADADA8A89E9F8D8D65655A5A545450504E4E4E4E505055555C5C69699393A1A1A9A9AEAEB1B1B1B1B0B0ACACA6A69C9C807F6363595953534F4F4E4E4E4E515156565E5E6C6C9696A3A3AAAAAFAFB1B1B1B1AFAFABABA5A49A9A72726161585852524F4F4E4E4F4F52525757606071719999A4A4ABABAFAFB1B1B1B1AFAFAAAAA3A397976D6D5F5F565651514F4F4E4E4F4F5353595963637A7A9C9CA6A6ACACB0B0B1B1B1B1AEAEA9A9A1A1939369695D5D555551514E4E4E4E505054545A5A65658C8C9E9EA7A7ADADB0B0B1B1B0B0ADADA8A89F9F8F8F66665B5B545450504E4E4E4E505055555C5C68689191A0A0A8A8ADADB0B0B1B1B0B0ACACA6A69D9D888864645A5A535350504E4E4F4F515156565E5E6B6B9595A2A2A9A9AEAEB0B0B1B1AFAFABABA5A59A9A74746262585853534F4F4E4E4F4F52525757606070709898A3A3AAAAAFAEB1B1B1B0AEAEAAAAA3A397976F6F6060575752524F4F4E4E505053535959626276769B9BA5A5ABABAFAFB1B1B0B0AEAEA9A9A1A194946B6B5E5E565651514F4F4E4E505054545A5A646489899D9DA6A6ACACAFAFB1B1B0B0ADADA8A89F9F909068685C5C555551514F4F4F4F515155555C5C67678F8F9F9FA7A7ADADB0B0B0B0AFAFACACA6A69D9D8A8A65655B5B545450504F4F4F4F515156565E5E6A6A9394A1A1A9A9ADADB0B0B0B0AFAFABABA5A59B9B787863635959535350504F4F4F4F5252575760606E6E9797A2A2AAAAAEAEB0B0AEAEA9A99F9F8B8B6363585852524F4F4F4F5252585863638A8A9F9FA8A8AEAEB0B0B0B0ACACA5A599996E6E5E5E555550504F4F505054545C5C6A6A9696A4A4ABABAFAFB0B0AEAEA9A9A1A190906565595953534F4F4F4F52525757616179799D9DA7A7ADADB0B0B0B0ACACA6A69B9B71715F5F565651514F4F505054545B5B68689494A2A2AAAAAFAFB0B0AFAFAAAAA2A2939367675B5B545450504F4F51515656606073739B9BA6A6ADACAFAFB0B0ADADA7A79D9D77776161575752524F4F505053535A5A66669090A1A1A9A9AEAEB0B0AFAFABABA3A395956A6A5C5C545450504F4F515156565E5E6F6F9999A5A5ACACAFAFB0B0');
        bytes memory testData = abi.encodePacked(hex"0000000024171ef33c133c1416f918f934e723a63cf224f211ce1a0d");

        emit log_bytes(abi.encodePacked(blockhash(0)));

        /*bytes memory testData;

        for(uint256 i = 0; i<500; i++) {
            testData = bytes.concat(testData,abi.encodePacked(blockhash(0)));
        }
        */

        emit log_string(WAV_8BIT.encodeWAV(testData, uint32(22050)));

    }


}

/// @notice Library to encode strings in Base64.
/// @author Solmate (https://github.com/Rari-Capital/solmate/blob/main/src/utils/Base64.sol)
/// @author Modified from (https://github.com/Brechtpd/base64/blob/main/base64.sol) by Brecht Devos - <brecht@loopring.org>.
library Base64 {
    function encode(bytes memory data) internal pure returns (string memory result) {
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