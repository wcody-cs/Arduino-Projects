#program to decode morse code

.macro pushall
push r16
push r17
push r18
push r19
push r20
push r21
push r22
push r23
push r24
push r25
push r26
push r27
push r28
push r29
push r30
push r31
.endm ; of pushall

.macro popall
pop r31
pop r30
pop r29
pop r28
pop r27
pop r26
pop r25
pop r24
pop r23
pop r22
pop r21
pop r20
pop r19
pop r18
pop r17
pop r16
.endm ; of popall

#--------------------------------------------------------------------
    .data
morse_table: # binary representation of Morse code: 0: dot; 1: dash
    .byte 0b01, 0b1000, 0b1010, 0b100, 0b0, 0b0010, 0b110, 0b0000, 0b00, 0b0111, 0b101, 0b0100, 0b11, 0b10, 0b111, 0b0110, 0b1101, 0b010, 0b000, 0b1, 0b001, 0b0001, 0b011, 0b1001, 0b1011, 0b1100
morse_width: # the number of binary digits in each character
    .byte 2, 4, 4, 3, 1, 4, 3, 4, 2, 4, 3, 4, 2, 2, 3, 4, 4, 3, 3, 1, 3, 4, 3, 4, 4, 4
ascii_table: # the English symbols encoded by the above Morse code 
    .byte 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
table_length:
    .byte 26
 
    .comm val, 1
    .comm width, 1
    .comm ascii, 1
    .global val, ascii, width

#---------------------------------------------------------------------
    .text
    .global decode_morse

decode_morse:

    pushall
    
    LDI R31, hi8(morse_table) //initialize high byte of Z
    LDI R30, lo8(morse_table) //initialize low byte of Z

    
    LDI R29, hi8(ascii_table) //initialize high byte of Y
    LDI R28, lo8(ascii_table) //initialize low byte of Y

    
    LDI R27, hi8(morse_width) // initialize high byte of X
    LDI R26, lo8(morse_width) // initialize low byte of X

    
    # ENTER YOUR CODE BELOW
    LDS r25, table_length

L1:    
    dec r25
    breq exitall
    
    LD r20, X+
    LD r21, Y+    
    LD r22, Z+
    lds r23, val
    lds r24, width
    

    
    cp r22, r23 //compare binary address to val
    BRNE L1
    cp r20, r24 //compare width to width of binary
    BRNE L1

    STS ascii, r21
    
exitall:
    popall
    ret
    
