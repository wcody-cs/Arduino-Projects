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
    
    .extern delay
    .comm val, 1
    .global val
    
    .text
    .global GoAggies


GoAggies:

    pushall
    
    ldi r21, 0b00100000  // yellow light port bit set
    ldi r20, 0
    out 0x04, r21        // yellow light port on
    out 0x05, r20        // light off

    call g
    call chardelay
    call o
    call chardelay
    
    call a
    call chardelay
    call g
    call chardelay
    call g
    call chardelay
    call i
    call chardelay
    call e
    call chardelay
    call s
    call chardelay

    ret


shorton:

    ldi r21, 0b00100000 ; yellow light port on
    
    out 0x05, r21 ; turn on
    
    ldi  r22, 0xa0 ; set duration to short (160 ms)
    ldi  r23, 0x00
    ldi  r24, 0x00
    ldi  r25, 0x00 ; make it stay on for 160 ms

    call delay
    
    ret
    
shortoff:

    ldi r20, 0 ; yellow light port off
    
    out 0x05, r20 ; turn off
    
    ldi  r22, 0xa0 ; set duration to short (160 ms)
    ldi  r23, 0x00
    ldi  r24, 0x00
    ldi  r25, 0x00 ; make it stay off for 160 ms

    call delay
    
    ret

longon:

    ldi r21, 0b00100000 ; yellow light port on
    out 0x05, r21       ; light on

    ldi  r22, 0xc8 ; set duration to long (456 ms)
    ldi  r23, 0x01
    ldi  r24, 0x00
    ldi  r25, 0x00 ; make it stay on for 456 ms
    
    call delay
    
    ret

longoff:

    ldi r20, 0 ; yellow light port off
    out 0x05, r20       ; light off

    ldi  r22, 0xc8 ; set duration to long (456 ms)
    ldi  r23, 0x01
    ldi  r24, 0x00
    ldi  r25, 0x00 ; make it stay on for 456 ms
    
    call delay
    
    ret

chardelay:


    ldi  r22, 0xff ; set duration to long (511 ms)
    ldi  r23, 0x01
    ldi  r24, 0x00
    ldi  r25, 0x00 ; make it stay on for 511 ms
    
    call delay
    
    ret



#--------------------------G----------------------------- 
g:
#
#Long blink
#   
    call longon
    call longoff

#
#long blink
#
  call longon
  call longoff

    
#
#short blink
#

    call shorton
    call shortoff
ret





#--------------------------O----------------------------- 
o:

#
#long blink
#
   call longon
   call longoff

#
#long blink
#
    call longon
    call longoff



#
#long blink
#
    call longon
    call longoff

    ret

   

#--------------------------A----------------------------- 
a:

#
#short blink
#    
    call shorton
    call shortoff    


#
#long blink
#
    call longon
    call longoff
    
    ret

 

#--------------------------I-----------------------------
i:
#
#short blink
#    
    call shorton
    call shortoff   


#
#short blink
#    
    call shorton
    call shortoff
    ret    



#--------------------------E-----------------------------
e:
#
#short blink
#    
    call shorton
    call shortoff
    ret  
    

   

#--------------------------S-----------------------------
s:

#
#short blink
#    
    call shorton
    call shortoff
#
#short blink
#    
    call shorton
    call shortoff
#
#short blink
#    
    call shorton
    call shortoff

    popall
    
    ret
