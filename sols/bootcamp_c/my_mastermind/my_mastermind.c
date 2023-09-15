#include <stdio.h>
#include <stdlib.h>

#include "structs.h"
#include "utils.h"


int main(int argc, char** argv)
{
    int attempts = 10;
    char code[5];

    my_strcpy(code, generate_code());

    for(int i = 1; i < argc; i++) {
        if(i + 1 <= argc) {
            if(my_strcmp(argv[i], "-t") == 1) {
                int value = atoi(argv[i + 1]);
                if (value != 0) {
                    attempts = value;
                }
            }
            
            if(my_strcmp(argv[i], "-c") == 1) {
                if(code_check(argv[i + 1])==1) {
                    my_strcpy(code, argv[i + 1]);
                }
            }
        }
    }

    printf("Will you find the secret code?\nPlease enter a valid guess\n");

    char entered_code[5];
    for(int attempt = 0; attempt < attempts; attempt++) {
        printf("---\nRound %d\n", attempt);
        my_strcpy(entered_code, ask_code());
        if (my_strcmp(code, entered_code) == 1) {
            printf("Congratz! You did it!\n");
            return 0;
        } else {
            struct analytics result = analyze(code, entered_code);
            printf("Well placed pieces: %d\nMisplaced pieces: %d\n", result.correct, result.misplaced);
        }
    }
    return 0;
}