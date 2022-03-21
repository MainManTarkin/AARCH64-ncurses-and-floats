.global main    
.align 4                                        //align to 4 bytes
.text                                           //begin code section

main:                                           //main function entry point
stp     fp, lr,  [sp,-16]!                      //backup frame pointer and link register
stp     x19, x20, [sp, -16]!                    //backup x19 through x24
stp     x21, x22, [sp, -16]!                    //^
stp     x23, x24, [sp, -16]!                    //^
stp     x25, x26, [sp, -16]!                    //^
stp     x27, x28, [sp, -16]!                    //^

bl      initscr                                 //initiate ncurses
ldr     x25, =doubleConst                       //aquire pointer to stored double constants used in program store in x25
ldr     x19, =levels                            //aquire pointer to string of random chars store in x19
ldr     d0, [x25, 0]                            //get the const pi value from x25 array store in scratch d0
ldr     d1, [x25, 8]                            //get const value 2(double) from x25 array store in scratch d1
fmul    d4, d0, d1                              //do some floating multiplication on stored pi value and 2 store in scratch d4
ldr     d20, [x25, 32]                          //load d20 with double 0 value from const pool x25
fmov    d28, d20                                //store this zero float value in d28 register for faster access later into the program
fmov    d21, d20                                //set d21 to zero double value from d20
ldr     x27, =LINES                             //save pointer to external LINES symbol
ldr     x26, =COLS                              //save pointer to external COLS symbol
ldr     w1, [x26]                               //load intger value from Cols pointer saved in x26
ucvtf   d2, w1                                  //convert intger w1 to a float in d2
fdiv    d22, d4, d2                             //floating point diviion between d4 and d2 stored in d22 which is backed up


top:
bl      erase                                   //erase screen
fadd    d20, d20, d22                           //float add d20 and d22 place into d20
mov     w23, wzr                                //zero w23 register

sinner:
ldr     w0, [x27]                               //load value of LINES into w0
cmp     w0, w23                                 //compare if w23 is greater then or equal to w0 if so then branch to binner
bge     bottom                                  //^   
fmov    d21, d28                                //move zero double register d28 to double d21
mov     w24, wzr                                //zero register w24

tinner:
ldr     w0, [x26]                               //load COLS into w0
cmp     w0, w24                                 //compare if w24 is greater then or equal to 20 if so then branch to binner
bge     binner                                  //^

fadd    d0, d20, d21
bl      sin
fmov    d3, #1.0
fmov    d4, #2.0
fmov    d5, #10.0
fadd    d0, d0, d3
fmul    d1, d4, d5
fdiv    d0, d0, d1
FCVTZU  x3, d0

mov     w0, w23                                 //move w23 to w0
mov     w1, w24                                 //move w24 to w1 
add     x2, x19, x3                             //add x3 to x19 to get the offset of char
bl      mvaddch                                 //run some ncurses function that adds a char
fadd    d21, d21, d22                           //float addition d21 adds to d22 then stores in d21
add     w24, w24, 1                             //increment w24 by 1
b       tinner

binner:	
add     w23, w23, 1                             //increment w23 by 1
b       sinner

bottom:
ldr     x3, =stdscr                             //gets pointer to stdscr store int scratch x0     
ldr     x0, [x3]           
mov     x1, xzr                                 //zero x1 and x2
mov     x2, xzr                                 //^
bl      box                                     //run ncurse box function
bl      refresh                                 //refresh window
b  top

bl      endwin                                  //run endwin function
mov     x0, xzr                                 //zero x0 register for return val
ldp     x27, x28, [sp], 16                      //offload used values off the stack
ldp     x25, x26, [sp], 16                      //^
ldp     x23, x24, [sp], 16                      //^
ldp     x21, x22, [sp], 16                      //^
ldp     x19, x20, [sp], 16                      //^
ldp     fp, lr, [sp], 16                        //^
ret

.data                                           //begin data section

levels:     .asciz		" .:-=+*#%@"            
doubleConst:    .double     3.14159265359, 2, 1 , 10 , 0 
.end
