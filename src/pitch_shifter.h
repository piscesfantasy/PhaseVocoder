#ifndef __PITCHSHIFTER_H__
#define __PITCHSHIFTER_H__

#include "vocoder_functions.h"
#include "frame.h"

using namespace std;

/**
 * Resample complex spectrum along frequency axis while taking care of phases
*/
class PitchShifter
{
    public:
        PitchShifter(int n, int s) : FFT_SIZE(n), FRAME_SHIFT(s) {
            cached_phase = vector<double>(n/2+1, 0.0);
            bin_shift_residual = vector<double>(n/2+1, 0.0);
            synth_freq_bin = vector<int>(n/2+1, 0);
            vocoder_func = new VocoderFunctions(n, s);
        }

        virtual void UpdatePhase(vector<double>& mag, vector<double> prev_phase, vector<double> next_phase, vector<double>& synth_ph, double factor);
        virtual void SynthesizeFrame(vector<double>& mag, vector<double>& ph, Frame *f);
        virtual void Shift(double factor, vector<Frame*>& input_spec, vector<Frame*>& output_spec, bool reset_phase);

    protected:
        int FFT_SIZE;
        int FRAME_SHIFT;
        vector<double> cached_phase; // the last phase spectrum from previous Shift execution
        vector<int> synth_freq_bin;
        vector<double> bin_shift_residual; // for interpolation
        VocoderFunctions* vocoder_func;
};

#endif
