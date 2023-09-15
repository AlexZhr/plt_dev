#include <stdbool.h>
#ifndef STRUCT_INTEGER_ARRAY
#define STRUCT_INTEGER_ARRAY
typedef struct s_integer_array
{
    int size;
    int* array;
} integer_array;
#endif


bool my_is_sort(integer_array* param_1)
{
    for (int i = 1; i < param_1->size-1; i++) {
        if(param_1->array[i] > param_1->array[i-1] && param_1->array[i] > param_1->array[i+1]) {
            return false;
        }
        else if(param_1->array[i] < param_1->array[i-1] && param_1->array[i] < param_1->array[i+1]) {
            return false;
        }
    }
    return true;
}
