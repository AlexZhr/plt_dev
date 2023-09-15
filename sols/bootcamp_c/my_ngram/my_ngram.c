#include <stdio.h>
#include <stdlib.h>

#define MAX_ARRAY_SIZE 128


void fill_array(int* array, char* str) {
    int i = 0;

    while(str[i] != '\0'){
        if (str[i] != '"') {
        array[(int)str[i]]++ ;
        }
        i++;
    }
}

void print_array(int* array, int array_size) {
    int i = 0;

    while (i < array_size) {
        if(array[i] > 0) {
            printf("%c:%d\n", i, array[i]);
        }
        i += 1;
    }
}

int main(int ac, char** av) {   
    int index = 1;
    int array[MAX_ARRAY_SIZE] = {0};

    while(index < ac) {
        fill_array(&array[0], av[index]);
        index ++;
    }
    print_array(&array[0], MAX_ARRAY_SIZE);
    return EXIT_SUCCESS;
}