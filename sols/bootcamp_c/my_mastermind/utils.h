#ifndef FILE_UTILS_SEEN
#define FILE_UTILS_SEEN

int my_strcmp(char* param_1, char* param_2);
void my_strcpy(char* target, char* source);
int code_check(char* str);
char* generate_code();
char* ask_code();
struct analytics analyze(char* code, char* entered_code);


#endif