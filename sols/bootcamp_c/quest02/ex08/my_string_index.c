/*
**
** QWASAR.IO -- my_string_index
**
** @param {char*} param_1
** @param {char} param_2
**
** @return {int}
**
*/

int my_string_index(char* param_1, char param_2)
{
    int index=-1;
    for(int i=0; param_1[i] !='\0'; i++) 
    {
        if(param_1[i] == param_2)
        {
            index = i;
            break;
        }
    }

    return index;

}