# Compiler and flags
CC = gcc
CFLAGS = -g -Wall -Wextra -fPIC
LDFLAGS = -shared
LIBS = -lm
AR = ar
ARFLAGS = rcs

# Directories
SRC_DIR = src
LIB_DIR = $(SRC_DIR)/lib
BUILD_DIR = $(SRC_DIR)/build
BIN_DIR = $(SRC_DIR)/bin
INCLUDE= $(SRC_DIR)/include

# Include paths for libraries
LIB_INCLUDES = -I $(SRC_DIR)/include

# Include paths for main application
MAIN_INCLUDES = -I $(LIB_DIR)


# Library targets
LIBRARIES = calculatrice
LIB_OBJECTS = $(BUILD_DIR)/calculatrice.o
LIB_SO_FILES = $(LIB_DIR)/calculatrice.so

#LIB_A_FILES = $(LIB_DIR)/calculatrice.a

# Main application
MAIN_OBJ = $(BUILD_DIR)/main.o
EXECUTABLE = $(BIN_DIR)/exeWithDynLib
EXECUTABLE2 = $(BIN_DIR)/exeWithStatLib


# Default target
all: $(EXECUTABLE) $(EXECUTABLE2)

# Create executable
$(EXECUTABLE): $(MAIN_OBJ) $(LIB_SO_FILES) $(LIBS) $(LIB_DIR)
	$(CC) -g -o $@ $(MAIN_OBJ) \
	    -I $(LIB_DIR) \
	    $(LIB_SO_FILES) \
	    $(LIBS)

$(EXECUTABLE2): $(MAIN_OBJ) $(LIB_OBJECTS) $(LIB_DIR) $(LIBS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(MAIN_OBJ) \
		-L.$(LIB_DIR) -l:calculatrice.a \
		$(LIBS)


# Main object file
$(BUILD_DIR)/main.o: $(SRC_DIR)/app/main.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LIB_INCLUDES) -c $< -o $@

# evalRpn shared library
$(LIB_SO_FILES): $(BUILD_DIR)/calculatrice.o
	@mkdir -p $(LIB_DIR)
	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)



$(BUILD_DIR)/calculatrice.o: $(INCLUDE)/calculatrice.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(LIB_DIR)/calculatrice.a: $(BUILD_DIR)/calculatrice.o
	@mkdir -p $(LIB_DIR)
	$(AR) $(ARFLAGS) $@ $<

# Run the program
run: $(EXECUTABLE2)
	LD_LIBRARY_PATH=$(LIB_DIR) ./$(EXECUTABLE2)

# Install libraries to system path (optional)
install: $(LIB_SO_FILES)
	@echo "Installing shared libraries to /usr/local/lib/"
	sudo cp $(LIB_DIR)
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
	@echo "Library objects: $(LIB_OBJECTS)"
	@echo "Shared libraries: $(LIB_SO_FILES)"
	@echo "Main object: $(MAIN_OBJ)"
	@echo "Executable: $(EXECUTABLE)"

.PHONY: all run install clean tree debug
