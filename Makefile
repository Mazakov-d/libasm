LIB_NAME    = libasm.a
EXEC_NAME   = test
EXEC_BONUS  = test_bonus

NASM        = nasm
CC          = gcc -g3
AR          = ar rcs

FLAGS       = -f elf64 -g -F dwarf
CFLAGS      = -Wall -Wextra

SRC_DIR     = src
OBJ_DIR     = .obj

MAIN        = main.c
MAIN_BONUS  = main_bonus.c

SRC         = ft_strlen.asm ft_strcpy.asm ft_write.asm ft_strcmp.asm ft_strdup.asm ft_read.asm
SRC_BONUS   = ft_atoi_base.asm

LIB_OBJ         = $(addprefix $(OBJ_DIR)/, $(SRC:.asm=.o))
LIB_BONUS_OBJ   = $(addprefix $(OBJ_DIR)/, $(SRC_BONUS:.asm=.o))

MAIN_OBJ        = $(OBJ_DIR)/main.o
MAIN_BONUS_OBJ  = $(OBJ_DIR)/main_bonus.o

GREEN       = \033[32m
RED         = \033[0;31m
RESET       = \033[0m

all: $(LIB_NAME)

$(LIB_NAME): $(LIB_OBJ)
	$(AR) $@ $^
	@echo "$(GREEN)Library created$(RESET)"

bonus: $(LIB_NAME) $(LIB_BONUS_OBJ)
	$(AR) $(LIB_NAME) $(LIB_BONUS_OBJ)
	@echo "$(GREEN)Bonus objects added to library$(RESET)"

exec: $(EXEC_NAME)

$(EXEC_NAME): $(MAIN_OBJ) $(LIB_NAME)
	$(CC) -no-pie $(MAIN_OBJ) -L. -lasm -o $@
	@echo "$(GREEN)Executable created$(RESET)"

exec_bonus: bonus $(EXEC_BONUS)

$(EXEC_BONUS): $(MAIN_BONUS_OBJ) $(LIB_NAME)
	$(CC) -no-pie $(MAIN_BONUS_OBJ) -L. -lasm -o $@
	@echo "$(GREEN)Bonus executable created$(RESET)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm Makefile
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(FLAGS) $< -o $@

$(OBJ_DIR)/main.o: $(MAIN) Makefile
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/main_bonus.o: $(MAIN_BONUS) Makefile
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(RED)Objects removed$(RESET)"

fclean: clean
	@rm -f $(LIB_NAME) $(EXEC_NAME) $(EXEC_BONUS)
	@echo "$(RED)All binaries removed$(RESET)"

re: fclean all

.PHONY: all bonus exec exec_bonus clean fclean re