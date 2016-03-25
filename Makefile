CXX=g++
CXXFLAGS=-O3 -Wall

SRC=src
OBJ=obj

SOURCES=main.cc \
    vocoder_functions.cc \
    time_stretcher.cc \
    time_stretcher_pl.cc \
    time_stretcher_fd.cc \
    time_stretcher_fd_pl.cc \
    my_fft.cc \
    frame.cc \
    wav_io.cc \
    pitch_shifter.cc \
    phasevocoder.cc

OBJECTS:=$(addprefix $(OBJ)/, $(addsuffix .o,$(basename $(SOURCES))))

.PHONY: dir clean

all: dir program

debug: CXXFLAGS += -DDEBUG -g
debug: all

dir:
	mkdir -p $(OBJ)

program: $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o PhaseVocoder.exe $^

$(OBJ)/%.o: $(SRC)/%.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -rf $(OBJ)
