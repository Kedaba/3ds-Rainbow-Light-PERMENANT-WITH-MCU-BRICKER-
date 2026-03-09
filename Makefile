TARGET = launcher
BUILD = build

all: $(BUILD)/$(TARGET).3dsx

$(BUILD)/$(TARGET).3dsx: $(TARGET).elf
	mkdir -p $(BUILD)
	3dstool -c ctr $(TARGET).elf -o $(BUILD)/$(TARGET).3dsx

$(TARGET).elf: $(TARGET).c
	devkitARM/bin/arm-none-eabi-gcc -O2 -Wall -marm -mthumb-interwork -mthumb -IdevkitPro/libctru/include -LdevkitPro/libctru/lib -lctru -o $(TARGET).elf $(TARGET).c

clean:
	rm -rf $(BUILD) *.elf
