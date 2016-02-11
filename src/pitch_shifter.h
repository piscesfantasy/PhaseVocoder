#ifndef __PITCHSHIFTER_H__
#define __PITCHSHIFTER_H__

#include "vocoder_functions.h"
#include "frame.h"

using namespace std;

class PitchShifter
{
    public:
        PitchShifter(int n, int s) : FFT_SIZE(n), FRAME_SHIFT(s) {
            for (int i=0; i<n/2+1; ++i) {
                phasor.push_back(0.0);
                freq_bin_shift.push_back(0);
                phase_shift_residual.push_back(0.0);
            }
            vocoder_func = new VocoderFunctions(n, s);
        }

        virtual void UpdatePhase(vector<float>& mag, vector<float>& synth_ph, float factor);
        virtual void SynthesizeFrame(vector<float>& mag, vector<float>& ph, Frame *f);
        void Shift(float factor, vector<Frame*>& input_spec, vector<Frame*>& output_spec, bool reset_phase);

    protected:
        int FFT_SIZE;
        int FRAME_SHIFT;
        vector<float> phasor; // the delta term for the phase of every frequency bin
        vector<int> freq_bin_shift;
        vector<float> phase_shift_residual; // for interpolation
        VocoderFunctions* vocoder_func;
};

#endif
