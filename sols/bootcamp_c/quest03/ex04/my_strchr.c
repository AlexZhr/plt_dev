#include <string.h>
#include <stddef.h>

char* my_strchr(char* param_1, char param_2)
{

    for(int i=0; i < strlen(param_1); i++)
    {
        if(param_1[i] == param_2)
        {
            return &param_1[i];
        }
    }
    return NULL;
}
