#include <string.h>
#include <stddef.h>

char* my_strrchr(char* param_1, char param_2)
{

    for(int i=strlen(param_1)-1; i<strlen(param_1) && i>0; i--)
    {
        if(param_1[i] == param_2)
        {
            return &param_1[i];
        }
    }
    return NULL;
}
