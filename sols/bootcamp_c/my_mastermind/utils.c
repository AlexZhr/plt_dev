#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#include "structs.h"

#define EOF (-1)

int my_strcmp(char* param_1, char* param_2){
    int i = 0;
    while (param_1[i] == param_2[i] && param_1[i] != '\0' &&  param_2[i] != '\0') {  
        i++;  
    }
    return param_1[i] - param_2[i] == 0 ? 1 : 0; 
}

void my_strcpy(char* target, char* source) {
    while((*target++ = *source++)) {}
}

char* generate_code(){
    srand(time(NULL));
    static char code[5];
    int min = '0';
    int max = '8';
    for(int i=0; i<4; i++) {
        code[i] = rand() % (max - min + 1) + min;
    }
    return code;
}

int code_check(char* str) {
    int i = 0;
    while(str[i] != '\0') {
        if(str[i] < '0' || str[i] > '8') {
            return 0;
        }
        i++;
    }
    return i == 4 ? 1 : 0;
}

char* ask_code() {
    static char code[5];
    read(0, &code, 5);
    if(code[4] == '\n') {
        code[4] = '\0';
    }
    if(code_check(code) == 0) {
        printf("Wrong input!\n");
        return ask_code();
    }
    return code;
}

struct analytics analyze(char* code , char* entered_code) {
    struct analytics result;

    result.correct = 0;
    result.misplaced = 0;

    int i = 0;
    while (entered_code[i] != '\0') {
        if (code[i] == entered_code[i]) {
            result.correct++;
        } else {
            int j = 0;
            while(code[j] != '\0') {
                if(code[j] == entered_code[i]) {
                    result.misplaced++;
                    break;
                }
                j++;
            }
        }
        i++;
    } 
    return result;
}

