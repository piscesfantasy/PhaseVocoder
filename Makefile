GPP=g++
GPPFLAGS=-O3 -Wall

SRC=src
BUILD=build

SOURCES=main.cc \
    vocoder_functions.cc \
    time_stretcher.cc \
    my_fft.cc \
    frame.cc \
    wav_io.cc \
    time_stretcher_pl.cc \
    pitch_shifter.cc \
    phasevocoder.cc

OBJ:=$(addprefix $(BUILD)/, $(addsuffix .o,$(basename $(SOURCES))))

.PHONY: dir clean

all: dir program

dir:
	mkdir -p $(BUILD)

program: $(OBJ)
	$(GPP) $(GPPFLAGS) -o PhaseVocoder.exe $^

$(BUILD)/%.o: $(SRC)/%.cc
	$(GPP) -c -o $@ $<

clean:
	rm -rf $(BUILD)
