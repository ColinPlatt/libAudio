// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Trigonometry} from "solidity-trigonometry/Trigonometry.sol";

contract ASine {
    using Trigonometry for *;

    uint256 constant sampleRate = 44100 * 10**18;
    uint256 constant bitDepth = 16;


    function SineOscillator(uint256 frequency, int256 amplitude, uint256 angle) public pure returns (bytes2, uint256) {
        uint256 offset = Trigonometry.TWO_PI * frequency / sampleRate;

        bytes2 sample = bytes2(abi.encodePacked(int16(amplitude * angle.sin())));
        angle += offset;
        return (sample, angle);
    }

/*

const int sampleRate = 44100;
const int bitDepth = 16;

class SineOscillator {
    float frequency, amplitude, angle = 0.0f, offset = 0.0f;
public:
    SineOscillator(float freq, float amp) : frequency(freq), amplitude(amp) {
        offset = 2 * M_PI * frequency / sampleRate;
    }
    float process() {
        auto sample = amplitude * sin(angle);
        angle += offset;
        return sample;
        // Asin(2pif/sr)
    }
};

*/



}
