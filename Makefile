NAME = libasm.a
CC = gcc
NASM = nasm
AR = ar rcs
RM = rm -f

ASM_SRCS = src/list.S
C_SRCS = src/main.c

ASM_OBJS = $(ASM_SRCS:.S=.o)

all: $(NAME)
	$(CC) $(C_SRCS) -L. -lasm -o test_prog

$(NAME): $(ASM_OBJS)
	$(AR) $(NAME) $(ASM_OBJS)

%.o: %.S
	$(NASM) -f elf64 $< -o $@

clean:
	$(RM) $(ASM_OBJS)

fclean: clean
	$(RM) $(NAME) test_prog

re: fclean all
