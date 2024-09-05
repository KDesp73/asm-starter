ASM = nasm
LD = ld
ASM_FLAGS = -I src -f elf32 -ggdb -F dwarf    # Assembly flags: elf32 format with DWARF debugging info
LD_FLAGS = -m elf_i386

SRC_DIR = src
OBJ_DIR = build
SRC = $(wildcard $(SRC_DIR)/*.asm)
OBJ = $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SRC))
EXEC = helloworld

all: $(EXEC)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm | $(OBJ_DIR)
	$(ASM) $(ASM_FLAGS) $< -o $@

$(EXEC): $(OBJ)
	$(LD) $(LD_FLAGS) -o $@ $^

clean:
	rm -f $(OBJ) $(EXEC)

cleanall: clean
	rm -rf $(OBJ_DIR)

debug: $(EXEC)
	gdb $(EXEC)

.PHONY: all clean cleanall debug
