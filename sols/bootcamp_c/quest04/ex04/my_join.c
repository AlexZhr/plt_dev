#ifndef STRUCT_STRING_ARRAY
#define STRUCT_STRING_ARRAY
#include <stdlib.h>
#include <string.h> 

typedef struct s_string_array
{
    int size;
    char** array;
} string_array;
#endif


char* my_join(string_array* param_1, char* param_2)
{
    if(param_1->size <= 0) return NULL;
    int new_len = strlen(param_2)*(param_1->size-1);

    for(int i = 0; i<param_1->size; i++){
        new_len += strlen(param_1->array[i]);
    }
    new_len++;
    char* new_str = malloc(sizeof(char)*new_len);

    strcpy(new_str, param_1->array[0]);
    for(int i=1; i<param_1->size; i++){
        strcat(new_str, param_2);
        strcat(new_str, param_1->array[i]);
    }
    return new_str;
}