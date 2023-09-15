#include <stdlib.h>
#include <string.h>
#include <stdio.h>
char* my_spaceship(char* param_1)
{
    int x = 0;
    int y = 0;
    char* drctn = "up";
    

    for(int i = 0; i < strlen(param_1); i++) {

        if(param_1[i] =='A') {
            if(strcmp(drctn, "up") == 0){
                y--;
            }
            else if(strcmp(drctn, "down") == 0){
                y++;
            }
            else if(strcmp(drctn, "right") == 0){
                x++;
            }
            else if(strcmp(drctn, "right") == 0){
                x--;
            }
        }

        else if(param_1[i] == 'R') {
            if(strcmp(drctn, "up") == 0){                
                drctn = malloc(6);
                strcpy(drctn,"right");
            }
            else if(strcmp(drctn, "right") == 0){
                drctn = malloc(5);
                strcpy(drctn,"down");
            }
            else if(strcmp(drctn, "down") == 0){
                drctn = malloc(5);
                strcpy(drctn,"left");
            }   
            else if(strcmp(drctn, "left") == 0){
                drctn = malloc(3);
                strcpy(drctn,"up");
            }             
        }

        else if(param_1[i] == 'L') {
            if(strcmp(drctn, "right") == 0){
                drctn = malloc(3);
                strcpy(drctn,"up");
            }
            else if(strcmp(drctn, "up") == 0){
                drctn = malloc(5);
                strcpy(drctn,"left");
            }
            else if(strcmp(drctn, "left") == 0){
                drctn = malloc(5);
                strcpy(drctn,"down");
            }   
            else if(strcmp(drctn, "down") == 0){
                drctn = malloc(6);
                strcpy(drctn,"right");
            }
        }
    }

    char* result = malloc(sizeof(char)*(23+strlen(drctn))+sizeof(int)*2);
    sprintf(result,"{x: %d, y: %d, direction: '%s'}", x, y, drctn);
    return result;
}