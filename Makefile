BUILD := bin
C_SOURCES := $(wildcard kernel/*.c kernel/drivers/*.c) # 
HEADERS := $(wildcard kernel/*.h kernel/drivers/*.h kernel/stdlib/*.h)
ASM_SOURCES := $(wildcard boot/*.asm)
OBJ = $(C_SOURCES:.c=.o)
# OBJ = $(C_SOURCES:kernel%.c=$(BUILD)%.o)

$(info $$C_SOURCES is [${C_SOURCES}])
$(info $$HEADERS is [${HEADERS}])
$(info $$ASM_SOURCES is [${ASM_SOURCES}])
$(info $$OBJ is [${OBJ}])

# Build the final OS binary
$(BUILD)/nickos.bin: $(BUILD)/mbr.bin $(BUILD)/kernel.bin
	cat $^ > $@

# Build master boot record
$(BUILD)/mbr.bin: boot/mbr.asm $(ASM_SOURCES)
	nasm $< -f bin -o $@

$(BUILD)/kernel_entry.o: kernel/kernel.asm
	nasm $^ -f elf -o $@

# Link all object files and kernel entry
$(BUILD)/kernel.bin: $(OBJ) $(BUILD)/kernel_entry.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c $(HEADERS)
	i386-elf-gcc -ffreestanding -c $< -o $@

run:
	qemu-system-x86_64 -fda $(BUILD)/nickos.bin

clean:
	find . -iname *.o -exec rm {} \;

all: $(BUILD)/nickos.bin

do: all run clean