/*
**
** QWASAR.IO -- my_isspace
**
** @param {char} param_1
**
** @return {int}
**
*/

#include <ctype.h>
int my_isspace(char param_1)
{
    return isspace(param_1)? 1: 0;
}