/*
**
** QWASAR.IO -- my_islower
**
** @param {char} param_1
**
** @return {int}
**
*/

#include <ctype.h>

int my_islower(char param_1)
{
    return islower(param_1)? 1: 0;
}