
CC			:= g++
EXT			:= cpp
EXEC		:= app
INCLUDE		:= -I./src/include/ -I./src/include/app -I./src/include/misc
CFLAGS		:= -Wall
LIB			:= 
SOURCE_DIR	:= src/code
BUILD_DIR	:= build
OBJ_DIR		:= obj
DEBUG_DIR	:= debug
RELEASE_DIR	:= release
OBJ_DEBUG_DIR	:= $(OBJ_DIR)/$(DEBUG_DIR)
OBJ_RELEASE_DIR := $(OBJ_DIR)/$(RELEASE_DIR)
BUILD_DEBUG_DIR	:= $(BUILD_DIR)/$(DEBUG_DIR)
BUILD_RELEASE_DIR := $(BUILD_DIR)/$(RELEASE_DIR)

#Identifier tpous les fichiers .$(EXT)
SRC= $(wildcard $(SOURCE_DIR)/*.$(EXT)) \
	 $(wildcard $(SOURCE_DIR)/app/*.$(EXT))

#Créer une liste des fichiers .o liés aux fichiers .$(EXT) 

OBJ_DEBUG :=$(addprefix $(OBJ_DEBUG_DIR)/,$(SRC:$(SOURCE_DIR)/%.$(EXT)=%.o))
OBJ_RELEASE :=$(addprefix $(OBJ_RELEASE_DIR)/,$(SRC:$(SOURCE_DIR)/%.$(EXT)=%.o))

print:
	@echo debug: $(OBJ_DEBUG)
	@echo release: $(OBJ_RELEASE)


all: $(OBJ_DIR) $(BUILD_DIR) $(BUILD_DIR)$(EXEC)

$(OBJ_DEBUG_DIR)/%.o: %.$(EXT)
	$(CC) $(INCLUDE) -o $@ -c $(SOURCE_DIR)/$< $(CFLAGS) $(LIB)

$(OBJ_RELEASE_DIR)/%.o: %.$(EXT)
	$(CC) $(INCLUDE) -o $@ -c $(SOURCE_DIR)/$< $(CFLAGS) $(LIB)

%.$(EXT):
	@echo compiling $(SOURCE_DIR)/$@


$(OBJ_DEBUG_DIR):
	@mkdir -p $(OBJ_DEBUG_DIR)/app

$(OBJ_RELEASE_DIR):
	@mkdir -p $(OBJ_RELEASE_DIR)/app

$(BUILD_DEBUG_DIR):
	@mkdir -p $(BUILD_DEBUG_DIR)

$(BUILD_RELEASE_DIR):
	@mkdir -p $(BUILD_RELEASE_DIR)



debug: CFLAGS := $(CFLAGS) -DDEBUG -g
debug: $(OBJ_DEBUG_DIR) $(BUILD_DEBUG_DIR) $(OBJ_DEBUG)
	$(CC) $(INCLUDE) -o $(BUILD_DEBUG_DIR)/$(EXEC) $(OBJ_DEBUG) $(CFLAGS) $(LIB)



release: CFLAGS := $(CFLAGS) -O2
release: $(OBJ_RELEASE_DIR) $(BUILD_RELEASE_DIR) $(OBJ_RELEASE)
	$(CC) $(INCLUDE) -o $(BUILD_RELEASE_DIR)/$(EXEC) $(OBJ_RELEASE) $(CFLAGS) $(LIB)

clean:
	@rm -rvf $(OBJ_DIR)

mrproper: clean
	@rm -rvf $(BUILD_DIR)

	