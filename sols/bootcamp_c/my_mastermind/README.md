# Welcome to My Mastermind
***

## Task
Challenge was to write a program called "mastermind" that should be an implementation of the famous game where players have 10 attempts to gues a right code that consist of 4 pieces, each is random from 9 different collors(characters from '0' to '8' in our case) and create a makefile to run and clean the program.

## Description
Initialy I've decided to splite the project for 2 files. The first(my_mastermind.c) is the file that consist of description of the process and the second(utils.c) carry functions(utilites) that used in the main file with help of using header files that #include in files for reference. First of all, I've declared variables "attempts" and code[5](array fot five items), then I wrote the funtion my_strcpy(implementation of strcpy()) and ganerate_code function(srand() for declare the pseudo-random number generator with time(0) as the seed and produce code values from '0' to '8' using loop with rand()%(max-min+1)+min;). The next step was create loop to search arguments "-t"(set count of attempts), "-c"(set a secret code), for comparing with these strings I used my_strcmp as implementation of the strcmp() and strcpy(). Afterwards it prints required text "Will you find the secret code?\nPlease enter a valid guess\n". Then declere entered_code[5] array and wrote the loop with attempts as the limit, print "---\nRound #\n" and copy ask_code()(function that use read(0, &entered_code, 5) for character-by-character reading from stdin, also it checkes entered_code for right format intput using code_check function with loop for comparing inside for entered characters in code to be from '0' to '8'). After correct format input, for calcuclate well placed and misplaced pieces I have used "struct analytics()" wich was decared in the file sturct.h., it contains 2 variables - missplaced and wellplace, calcs realised with help of 2 loops. After every attemp results prints. 

## Installation
Project can be compiled with "make" command. Also, there other ruls descrted in the makefile.

## Usage
For start the program input :./my_mastermind -c "nnnn"(if needed to set the code) -t "n"(if needed to set count of attempts).
```
./my_project argument1 argument2
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
