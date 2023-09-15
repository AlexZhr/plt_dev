/*
**
** QWASAR.IO -- my_isalpha
**
** @param {char} param_1
**
** @return {int}
**
*/
#include <ctype.h>
#include <stdio.h>

int my_isalpha(char param_1)
{
    if(isalpha(param_1))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}