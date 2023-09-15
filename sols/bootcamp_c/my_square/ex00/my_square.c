#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>


void my_putchar(char c) {
    write(1, &c, 1);
}

void my_square(int param_1, int param_2)
{   
    for(int i = 0; i < param_2; i++){
        if(i == 0 || i == param_2-1) {
            for(int j = 0; j < param_1; j++) {
                if(j == 0 || j == param_1-1){
                    my_putchar('o');
                }
                else {
                    my_putchar('-');
                }
            }
            my_putchar('\n');
        }
        else{
            for(int t = 0; t < param_1; t++) {
                if(t == 0 || t == param_1-1) {
                    my_putchar('|');
                }
                else {
                    my_putchar(' ');
                }
            }
            my_putchar('\n');
        }
    }
}

int main(int ac, char **av){
    if (ac != 3) {
        return 0;
    }
    int x = atoi(av[1]);
    int y = atoi(av[2]); 

    my_square(x, y);    
}

