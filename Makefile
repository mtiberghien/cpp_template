# Si la structure des modules change dans le projet changer MODULES en conséquence
MODULES 	:= app io misc model
# Compilateur Système
CC			:= g++
# Extension à compiler
EXT			:= cpp
# Nom de l'exécutable
EXEC		:= app
# Options de compilations
CFLAGS		:= -Wall
# Permet d'inclure des librairie à linker ex -lsqlite3
LINK_LIB	:= 
# Dossier racine des headers
INCLUDE_DIR := src/include
# Dossier racine du code source
SOURCE_DIR	:= src/code
# Dossier de build
BUILD_DIR	:= build
# Dossier racine des fichiers .o
OBJ_DIR		:= obj
# Dossier debug
DEBUG_DIR	:= debug
# Dossier release
RELEASE_DIR	:= release
# Ensemble des sous dossier obj/debug à créer par module
OBJ_DEBUG_DIR := $(foreach module, $(MODULES), $(DEBUG_DIR)/$(module))
# Ensemble des sous dossier obj/release à créer par module
OBJ_RELEASE_DIR := $(foreach module, $(MODULES), $(RELEASE_DIR)/$(module))
# Dossier build/debug
BUILD_DEBUG_DIR	:= $(BUILD_DIR)/$(DEBUG_DIR)
# Dossier build/release
BUILD_RELEASE_DIR := $(BUILD_DIR)/$(RELEASE_DIR)
# Contient les dossier à inclure avec -I dans les commandes de compilation afin de simplifier l'écriture du code
INCLUDE		:= -I./$(INCLUDE_DIR)
INCLUDE	+= $(foreach module, $(MODULES), -I./$(INCLUDE_DIR)/$(module))

# Identifier tpous les fichiers .$(EXT)
SRC	:= $(wildcard $(SOURCE_DIR)/*.$(EXT))
SRC	+= $(foreach module,$(MODULES),$(wildcard $(SOURCE_DIR)/$(module)/*.$(EXT)))

# Créer une liste des fichiers .o liés aux fichiers .$(EXT), pour le debug, une pour la version release
OBJ_DEBUG :=$(addprefix $(OBJ_DIR)/$(DEBUG_DIR)/,$(SRC:$(SOURCE_DIR)/%.$(EXT)=%.o))
OBJ_RELEASE :=$(addprefix $(OBJ_DIR)/$(RELEASE_DIR)/,$(SRC:$(SOURCE_DIR)/%.$(EXT)=%.o))


# Affiche le nom de la source qui doit être compilée
%.$(EXT):
	@echo compiling $(SOURCE_DIR)/$@

# Crée les sous dossiers obj/debug
$(DEBUG_DIR)/%:
	@mkdir -p $(OBJ_DIR)/$@

# Crée les sous dossiers obj/release
$(RELEASE_DIR)/%:
	@mkdir  -p $(OBJ_DIR)/$@

# Crée le dossier build/debug
$(BUILD_DEBUG_DIR):
	@mkdir -p $@

# Compile l'application debug mais également les sources si nécessaire
$(BUILD_DEBUG_DIR)/$(EXEC): $(OBJ_DEBUG)
	$(CC) $(INCLUDE) -o $@ $(OBJ_DEBUG) $(CFLAGS) $(LINK_LIB)

# Crée le dossier build/release
$(BUILD_RELEASE_DIR):
	@mkdir -p $@

# Compile l'application release mais également les sources sin nécessaire
$(BUILD_RELEASE_DIR)/$(EXEC): $(OBJ_RELEASE)
	$(CC) $(INCLUDE) -o $@ $(OBJ_RELEASE) $(CFLAGS) $(LINK_LIB)

# Compile les fichiers sources en mode debug
$(OBJ_DIR)/$(DEBUG_DIR)/%.o: $(SOURCE_DIR)/%.$(EXT)
	$(CC) $(INCLUDE) -o $@ -c $< $(CFLAGS) $(LINK_LIB)

# Compile les fichiers sources en mode release
$(OBJ_DIR)/$(RELEASE_DIR)/%.o: $(SOURCE_DIR)/%.$(EXT)
	$(CC) $(INCLUDE) -o $@ -c $< $(CFLAGS) $(LINK_LIB)

# Lance la compilation en mode debug en changeant les flags de compilation
debug: CFLAGS := $(CFLAGS) -DDEBUG -g

# Les dossiers obj/debugs et build/debug sont créés, puis l'exécutable
debug: $(OBJ_DEBUG_DIR) $(BUILD_DEBUG_DIR) $(BUILD_DEBUG_DIR)/$(EXEC)
	@echo Debug make completed
	
# Lance la compilation en mode release en changeant les flags de compilations
release: CFLAGS := $(CFLAGS) -O2

# Les dossiers obj/debugs et build/debug sont créés, puis l'exécutable
release: $(OBJ_RELEASE_DIR) $(BUILD_RELEASE_DIR) $(BUILD_RELEASE_DIR)/$(EXEC)
	@echo Release make completed

# Supprime le dossier obj
clean:
	@rm -rvf $(OBJ_DIR)

# Supprime le dossier build
mrproper: clean
	@rm -rvf $(BUILD_DIR)

	