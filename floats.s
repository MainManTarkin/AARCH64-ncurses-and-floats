.global main    
.align 4                                        //align to 4 bytes
.text                                           //begin code

main:                                           //main function entry point
stp     fp, lr,  [sp,-16]!                      //backup frame pointer and link register
stp     x19, x20, [sp, -16]!                    //backup x19 through x24
stp     x21, x22, [sp, -16]!                    //^
stp     x23, x24, [sp, -16]!                    //^
stp     x25, x26, [sp, -16]!                    //^
stp     x27, x28, [sp, -16]!                    //^

bl      initscr
ldr     x25, =doubleConst
ldr     d0, [x25, 0]
ldr     d1, [x25, 8]
fmul    d19, d0, d1
ldr     d20, [x25, 32]
fmov    d28, d20
fmov    d21, d20
ldr     x27, =LINES
ldr     x26, =COLS
ldr     w1, [x26] 
ucvtf   d2, w1
fdiv    d22, d19, d2


top:
bl      erase
fadd    d20, d20, d22
mov     w23, wzr

sinner:
ldr     w0, [x27]
cmp     w23, w0
bge     bottom
fmov    d21, d28
mov     w24, wzr

tinner:
ldr     w0, [x26]
cmp     w24, w0
bge     binner

binner:	
add     w23, w23, 1

bottom:
mov     x0, x28
mov     x1, xzr
mov     x2, xzr
bl      box
bl      refresh
b  top

bl      endwin
mov     x0, xzr
ldp     x27, x28, [sp], 16
ldp     x25, x26, [sp], 16
ldp     x23, x24, [sp], 16
ldp     x21, x22, [sp], 16
ldp     x19, x20, [sp], 16
ldp     fp, lr, [sp], 16
ret

.data                                           //begin data section

levels:     .asciz		" .:-=+*#%@"
doubleConst:    .double     3.14159265359, 2, 1 , 10 , 0 
.end
