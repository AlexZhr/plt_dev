/*
**
** QWASAR.IO -- my_strlen
**
** @param {char*} param_1
**
** @return {int}
**
*/


int my_strlen(char* param_1)
{
    int i = 0;

    while(*param_1!='\0')
    {
        i++;
        param_1++;
    }

    return i;
}