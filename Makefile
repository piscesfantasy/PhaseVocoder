GPP = g++
GPPFlag = -O2 -Wall

SRC = src
BUILD = build

CDIR = cd
MKDIR = mkdir -p
RM = rm -rf

objects = $(BUILD)/main.o $(BUILD)/vocoder_functions.o $(BUILD)/time_stretcher.o $(BUILD)/my_fft.o $(BUILD)/frame.o $(BUILD)/wav_io.o $(BUILD)/time_stretcher_pl.o $(BUILD)/pitch_shifter.o

.PHONY : dir

all: dir program

dir:
	$(MKDIR) $(BUILD)

program: $(objects)
	$(GPP) $(GPPFlag) -o PhaseVocoder.exe $^

$(BUILD)/%.o: $(SRC)/%.cc
	$(GPP) -c -o $@ $<

.PHONY : clean
clean:
	$(RM) $(BUILD)
