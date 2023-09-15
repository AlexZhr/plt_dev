/*
**
** QWASAR.IO -- my_isdigit
**
** @param {char} param_1
**
** @return {int}
**
*/

#include <ctype.h>

int my_isdigit(char param_1)
{
    return isdigit(param_1)? 1: 0;
}