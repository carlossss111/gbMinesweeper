
# Flags #####

SRC_DIR=src
BIN_DIR=bin

EXE=minesweeper.gb
MAP=minesweeper.map

ASM_FLAGS=-Wall -I src/include
L_FLAGS=-Wall --linkerscript linker.ld -n bin/minesweeper.sym --dmg --wramx --tiny
F_FLAGS=-Wall -c --mbc-type 0x00 --ram-size 0x00 --title 'Minesweeper' -j -v -p 0xFF

recursive_wildcard=$(foreach d,\
		$(wildcard $(1:=/*)), \
		$(call recursive_wildcard, $d, $2) $(filter $(subst *, %, $2), $d) \
	)
SOURCE_FILE_LIST=$(call recursive_wildcard,$(SRC_DIR),*.s)


# Options #####

compile: clean
	for ASM_FILE in $(SOURCE_FILE_LIST) ; do \
		OBJ_FILE=`basename $$ASM_FILE | cut -d. -f1`.o ;\
		rgbasm $$ASM_FILE $(ASM_FLAGS) -o $(BIN_DIR)/$$OBJ_FILE ; \
	done
	rgblink $(BIN_DIR)/*.o $(L_FLAGS) -o $(BIN_DIR)/$(EXE)
	rgbfix $(BIN_DIR)/$(EXE) $(F_FLAGS)

clean:
	rm bin/* 2> /dev/null || true 

run: compile
	EMulicious $(BIN_DIR)/$(EXE)

run-sameboy: compile
	sameboy $(BIN_DIR)/$(EXE)

map: compile
	rgblink $(BIN_DIR)/*.o $(L_FLAGS) -m $(BIN_DIR)/$(MAP)
	cat $(BIN_DIR)/$(MAP)

