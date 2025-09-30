
# Flags #####

SRC_DIR=src
BIN_DIR=bin

OBJ=minesweeper.o
EXE=minesweeper.gb
MAP=minesweeper.map

ASM_FLAGS=-Wall -I src/include
L_FLAGS=-Wall --linkerscript linker.ld -n bin/minesweeper.sym --dmg --wramx --tiny
F_FLAGS=-Wall -c --mbc-type 0x00 --ram-size 0x00 --title 'Minesweeper' -j -v -p 0xFF

rwildcard=$(foreach d,\
		$(wildcard $(1:=/*)), \
		$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d) \
	)
SOURCES_COLLECTED=$(call rwildcard,$(SRC_DIR),*.s)


# Options #####

compile: clean
	rgbasm $(SOURCES_COLLECTED) $(ASM_FLAGS) -o $(BIN_DIR)/$(OBJ)
	rgblink $(BIN_DIR)/$(OBJ) $(L_FLAGS) -o $(BIN_DIR)/$(EXE)
	rgbfix $(BIN_DIR)/$(EXE) $(F_FLAGS)

clean:
	rm bin/* 2> /dev/null || true 

run: compile
	emulicious $(BIN_DIR)/$(EXE)

run-sameboy: compile
	sameboy $(BIN_DIR)/$(EXE)

map:
	rgbasm $(SOURCES_COLLECTED) $(ASM_FLAGS) -o $(BIN_DIR)/$(OBJ)
	rgblink $(BIN_DIR)/$(OBJ) $(L_FLAGS) -o $(BIN_DIR)/$(EXE) -m $(BIN_DIR)/$(MAP)
	cat $(BIN_DIR)/$(MAP)

