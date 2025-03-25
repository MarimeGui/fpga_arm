package Utilities;

    typedef enum bit [4:0] {
        NOP = 0,
        ADD = 1,
        SUB = 2,
        AND = 3,
        EOR = 4,
        CMP = 5,
        LSL = 6,
        LSR = 7,
        MOV = 8,
        STR = 9,
        LDR = 10
        // PUSH = 11,
        // POP = 12
    } Uop;

    typedef struct packed {
        bit Z; // Zero
        bit C; // Carry
        bit N; // Negative
        bit V; // Overflow
    } Flags;

endpackage
