PROG_NAME = my_mastermind
SOURCES = $(PROG_NAME).c utils.c

default: 
	gcc -Wall -Wextra -Werror $(SOURCES) -o $(PROG_NAME)

clean:
	@rm $(PROG_NAME)

fclean: clean
	rm -f $(PROG_NAME)

re: fclean $(PROG_NAME)