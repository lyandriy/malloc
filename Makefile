ifeq ($(HOSTTYPE),)
    HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

NAME      := libft_malloc_$(HOSTTYPE).so
LINK      := libft_malloc.so

CC        ?= cc
CFLAGS    := -Wall -Wextra -Werror -fPIC
CPPFLAGS  := -Iinclude -Ilibft -MMD -MP
LDFLAGS   := -shared

LIBFT_DIR := libft
LIBFT     := $(LIBFT_DIR)/libft.a

SRC_DIR   := src
OBJ_DIR   := obj
SRCS      := malloc.c free.c realloc.c calloc.c show_alloc_mem.c
OBJS      := $(addprefix $(OBJ_DIR)/, $(SRCS:.c=.o))
DEPS      := $(OBJS:.o=.d)

all: $(LINK)

$(LINK): $(NAME)
	ln -sf $(NAME) $(LINK)

$(NAME): $(LIBFT) $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) $(LIBFT) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $@

-include $(DEPS)

$(LIBFT): $(wildcard $(LIBFT_DIR)/*.c $(LIBFT_DIR)/*.h)
	$(MAKE) -C $(LIBFT_DIR)

clean:
	$(MAKE) -C $(LIBFT_DIR) clean
	rm -rf $(OBJ_DIR)

fclean: clean
	$(MAKE) -C $(LIBFT_DIR) fclean
	rm -f $(NAME) $(LINK)

re: fclean
	$(MAKE) all

debug: fclean
	$(MAKE) all CFLAGS="$(CFLAGS) -g3"

.PHONY: all clean fclean re debug
