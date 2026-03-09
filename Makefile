DEVKITPRO ?= /opt/devkitpro
DEVKITARM ?= $(DEVKITPRO)/devkitARM
PREFIX := $(DEVKITARM)/bin/arm-none-eabi-

# Project name
TARGET := launcher
BUILD_DIR := build

# Source files
SRCS := $(TARGET).c
OBJS := $(SRCS:.c=.o)

# Flags
CFLAGS := -O2 -Wall -mword-relocations -marm -mcpu=mpcore -mtune=mpcore -fomit-frame-pointer -ffast-math -std=c11
LDFLAGS := -specs=3dsx.specs -L$(DEVKITPRO)/libctru/lib -lctru -lm

# Create build dir if needed
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile .c -> .o
%.o: %.c | $(BUILD_DIR)
	$(PREFIX)gcc $(CFLAGS) -c $< -o $(BUILD_DIR)/$@

# Link .o -> .elf
$(BUILD_DIR)/$(TARGET).elf: $(OBJS) | $(BUILD_DIR)
	$(PREFIX)gcc $(CFLAGS) $(BUILD_DIR)/*.o -o $@ $(LDFLAGS)

# Convert .elf -> .3dsx
$(BUILD_DIR)/$(TARGET).3dsx: $(BUILD_DIR)/$(TARGET).elf
	$(PREFIX)objcopy -O binary $< $@

# Default target
all: $(BUILD_DIR)/$(TARGET).3dsx

# Clean
clean:
	rm -rf $(BUILD_DIR)
