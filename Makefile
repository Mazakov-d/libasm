LIB_NAME    = libasm.a
EXEC_NAME   = test

NASM        = nasm
LD          = ld
AR          = ar rcs

FLAGS       = -f elf64

SRC_DIR     = src
OBJ_DIR     = .obj

MAIN        = main.asm
SRC         = ft_strlen.asm ft_strcpy.asm ft_write.asm

LIB_OBJ     = $(addprefix $(OBJ_DIR)/, $(SRC:.asm=.o))
EXEC_OBJ    = $(addprefix $(OBJ_DIR)/, $(MAIN:.asm=.o))

GREEN       = \033[32m
RED         = \033[0;31m
RESET       = \033[0m

all: $(LIB_NAME)

$(LIB_NAME): $(LIB_OBJ)
	$(AR) $@ $^
	@echo "$(GREEN)Library created$(RESET)"

exec: $(EXEC_NAME)

$(EXEC_NAME): $(EXEC_OBJ) $(LIB_NAME)
	$(LD) $(EXEC_OBJ) -L. -lasm -o $@
	@echo "$(GREEN)Executable created$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm Makefile
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(FLAGS) $< -o $@

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(RED)Objects removed$(RESET)"

fclean: clean
	@rm -f $(LIB_NAME) $(EXEC_NAME)
	@echo "$(RED)All binaries removed$(RESET)"

re: fclean all

.PHONY: all exec clean fclean re