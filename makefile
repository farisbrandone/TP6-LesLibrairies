# Compiler and flags
CC = gcc
CFLAGS = -g -Wall -Wextra -fPIC
LDFLAGS = -shared
AR = ar
ARFLAGS = rcs

# Directories
SRC_DIR = src
LIB_DIR_STAT = $(SRC_DIR)/lib/calculatriceStat
LIB_DIR_DYN = $(SRC_DIR)/lib/calculatriceDyn
LIB_DIR = $(SRC_DIR)/lib
BUILD_DIR = $(SRC_DIR)/build
BIN_DIR = $(SRC_DIR)/bin

# Include paths for libraries
LIB_INCLUDES = -I $(LIB_DIR)

# Library targets
LIB_STATIC = $(LIB_DIR_STAT)/libcalculatriceStat.a
LIB_DYNAMIC = $(LIB_DIR_DYN)/libcalculatriceDyn.so

# Main application
MAIN_OBJ = $(BUILD_DIR)/main.o
EXECUTABLE = $(BIN_DIR)/exe

# Default target
all: $(EXECUTABLE)

# Create executable
$(EXECUTABLE): $(MAIN_OBJ) $(LIB_STATIC) $(LIB_DYNAMIC)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(MAIN_OBJ) \
		-L$(LIB_DIR_STAT) -lcalculatriceStat \
		-L$(LIB_DIR_DYN) -lcalculatriceDyn \
		-Wl,-rpath,$(LIB_DIR_DYN)

# Main object file
$(BUILD_DIR)/main.o: $(SRC_DIR)/app/main.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -I $(LIB_DIR_STAT) -I $(LIB_DIR_DYN) -c $< -o $@

# Static library
$(LIB_STATIC): $(BUILD_DIR)/calculatriceStat.o
	@mkdir -p $(LIB_DIR_STAT)
	$(AR) $(ARFLAGS) $@ $<

# Dynamic library
$(LIB_DYNAMIC): $(BUILD_DIR)/calculatriceDyn.o
	@mkdir -p $(LIB_DIR_DYN)
	$(CC) $(LDFLAGS) -o $@ $<

# Object files
$(BUILD_DIR)/calculatriceStat.o: $(LIB_DIR_STAT)/calculatriceStat.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/calculatriceDyn.o: $(LIB_DIR_DYN)/calculatriceDyn.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Run the program
run: $(EXECUTABLE)
	./$(EXECUTABLE)

# Install libraries to system path (optional)
install: $(LIB_DYNAMIC)
	@echo "Installing shared libraries to /usr/local/lib/"
	sudo cp $(LIB_DYNAMIC) /usr/local/lib/
	sudo ldconfig

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Show file structure
tree:
	@echo "Project structure:"
	@tree $(SRC_DIR) -I '*.so|*.o' || echo "Install 'tree' command for better visualization"

# Debug info
debug:
	@echo "Static library: $(LIB_STATIC)"
	@echo "Dynamic library: $(LIB_DYNAMIC)"
	@echo "Main object: $(MAIN_OBJ)"
	@echo "Executable: $(EXECUTABLE)"

.PHONY: all run install clean tree debug
