#include <stdlib.h>
#include <string.h>

char* my_strdup(char* param_1)
{
    char* str = malloc(sizeof(char)*(strlen(param_1)+1));
    for(int i=0; i<=strlen(param_1); i++){
        str[i] = param_1[i];
    }
    return str;
}