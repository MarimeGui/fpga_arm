.section .text
.global _start

_start:
begin:
    MOV R1, #32 // Gpio address
    MOV R2, #0 // Chaser
    MOV R3, #0 // Chaser counter
loop:
    CMP R3,#32
    BEQ begin
    
    LSL R2,#1
    CMP R3,#16
    BGE skip
    ADD R2,#1
skip:
    ADD R3,#1
    
    STR R2,[R1,#0]
    B loop
halt:
    B halt
