// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Trigonometry} from "solidity-trigonometry/Trigonometry.sol";

contract ASine {
    using Trigonometry for *;

    uint256 constant sampleRate = 20050;

    event log_angle(uint256 angle);

    function SineOscillator(uint256 frequency, int8 amplitude, uint8 mid, uint256 iterations) public returns (bytes memory) {
        uint256 offset = Trigonometry.TWO_PI * frequency / sampleRate;
        
        emit log_angle(offset);

        uint256 angle = 0;
        bytes memory sineData = new bytes (iterations);

        for(uint256 i = 0; i<iterations; i++) {
            sineData[i] = Oscillation(amplitude, angle, mid);
            angle += offset;
            //emit log_angle(angle);
        }

        return sineData;

    }

    function Oscillation(int8 _amplitude, uint256 _angle, uint8 _mid) public pure returns (bytes1 sample) {
        //uint256 secondsample = (127*uint256((offset).sin())/PRECISION)+128;
        
        //((_mid*uint256(_amplitude * _angle.sin()))/10**18)+127

        sample = bytes1(uint8(((_mid*uint256(_amplitude * _angle.sin()))/10**18)+127));

        return sample;
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
