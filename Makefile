NAME		= libasm.a

NASM		= nasm
NASMFLAGS	= -f elf64
CC			= gcc
CFLAGS		= -Wall -Wextra -Werror
AR			= ar rcs
RM			= rm -rf

SRC_DIR		= src
BUILD_DIR	= build
INC_DIR		= include

ASM_SRCS	= $(SRC_DIR)/ft_string.S

ASM_OBJS	= $(ASM_SRCS:$(SRC_DIR)/%.S=$(BUILD_DIR)/%.o)

all: $(NAME)

$(NAME): $(ASM_OBJS)
	@echo "Creating library $(NAME)..."
	$(AR) $(NAME) $(ASM_OBJS)
	@echo "Done."

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.S
	@mkdir -p $(BUILD_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

test: $(NAME) main.c
	@echo "Compiling tester..."
	$(CC) $(CFLAGS) main.c -L. -lasm -o tester
	@echo "Running tester..."
	@./tester

clean:
	@echo "Cleaning object files..."
	$(RM) $(BUILD_DIR)

fclean: clean
	@echo "Removing library and tester..."
	$(RM) $(NAME) tester

re: fclean all

.PHONY: all clean fclean re test