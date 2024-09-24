.section .text
.global _start

_start:
    MOV R0, #0

loop:
    ADD R0, #1
    CMP R0, #100
    BNE loop

halt:
    B halt

