/*
**
** QWASAR.IO -- reverse_string
**
** @param {char*} param_1
**
** @return {char*}
**
*/

#include <stdio.h>
#include <string.h>

char* reverse_string(char* param_1)
{
    int len ;
    char temp;

    len = strlen(param_1);
    
    for(int i=0; i<len/2; i++)
    {
        temp = param_1[i];
        param_1[i]=param_1[len-i-1];
        param_1[len-i-1]=temp;
    }
    return param_1;
}
