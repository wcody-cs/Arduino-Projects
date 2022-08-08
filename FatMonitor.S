 // Body Fat Monitor: A program written in assembly that blinks lights 
 // corresponding to BMI given in a table
 // Cody Wilson
 // 8/16/19
 // Input: Three 2-digit hexadecimal numbers
 // Output: Blue, Green, or red blinking lights, or all on with no blinking   
 // The input will be a value less than 256 due to the variable only being one byte.
 //
 // Gender | Hex | Age | Hex | Body Fat | Hex | Light 
 //    F   |  1  | 42  | 2A  |    32    | 20  | Green   
 //    M   |  0  | 25  | 19  |    48    | 30  | All    
 //    F   |  1  | 30  | 1E  |    21    | 15  | Green   
 //    M   |  0  | 23  | 17  |    17    | 11  | Blue   

 
    .data
    
    //global variables entered from c program
    .comm gender, 1
    .global gender
    .comm age, 1
    .global age
    .comm fat, 1
    .global fat
    //create variables for each light + all lights
    .comm green, 1
    .comm red, 1
    .comm blue, 1
    .comm allc, 1 //all colors
    
    //create a variable to hold the current blink color
    .comm blinkcolor, 1
    
    .text
    .global lightup

lightup:

    //initialize each variable to its corresponding port
    LDI  r18, 0b00010000
    STS  green, r18
    
    LDI  r18, 0b00000001
    STS  red, r18
    
    LDI  r18, 0b00100000
    STS  blue, r18
    
    LDI  r18, 0b000110001
    STS  allc, r18

        

//--Check the gender--\\
    LDS  R20, gender
    CPI  R20, 0
    BRNE female
    jmp male


female:

    //find the age group
    LDS  R21, age
    CPI  R21, 20
    BRLT fdonothing
    jmp fage20


//--DETERMINE AGE--\\

//check if 20-40
fage20:
    LDS  R21, age
    CPI  R21, 40
    BRSH fage40
    jmp fbfat2040b //jump to fat 20-40
    
fage40:
    LDS  R21, age
    CPI  R21, 60
    BRSH fage60
    jmp fbfat4060b //jump to fat if 40-60
    
fage60:
    LDS  R21, age
    CPI  R21, 80
    BRSH fdonothing
    jmp fbfat6080b //jump to fat if 60-80

//--DETERMINE FAT--\\

//fat for 20-40 range
//blue light
fbfat2040b:
    LDS  R22, fat
    CPI  R22, 21
    BRSH fbfat2040g
    LDS R23, blue
    STS blinkcolor, R23
    JMP doblink
    
//green light
fbfat2040g:
    LDS  R22, fat
    CPI  R22, 33
    BRSH fbfat2040r
    LDS R23, green
    STS blinkcolor, R23
    JMP doblink
    
//red light
fbfat2040r:
    LDS  R22, fat
    CPI  R22, 25
    BRSH fdoall
    LDS  R23, red
    STS  blinkcolor, R23
    JMP  doblink

//extra leaps to make the branch
fdonothing:
    JMP donothing
fdoall:
    JMP doall

//fat for 40-60 range
//blue light
fbfat4060b:
    LDS  R22, fat
    CPI  R22, 23
    BRSH fbfat4060g
    LDS R23, blue
    STS blinkcolor, R23
    JMP doblink
    
//green light
fbfat4060g:
    LDS  R22, fat
    CPI  R22, 34
    BRSH fbfat4060r
    LDS R23, green
    STS blinkcolor, R23
    JMP doblink
    
//red light
fbfat4060r:
    LDS  R22, fat
    CPI  R22, 40
    BRSH fdoall
    LDS R23, red
    STS blinkcolor, R23
    JMP doblink


//fat for 60-80 range
//blue light
fbfat6080b:
    LDS  R22, fat
    CPI  R22, 24
    BRSH fbfat6080g
    LDS R23, blue
    STS blinkcolor, R23
    JMP doblink
    
//green light
fbfat6080g:
    LDS  R22, fat
    CPI  R22, 36
    BRSH fbfat6080r
    LDS R23, green
    STS blinkcolor, R23
    JMP doblink
    
//red light
fbfat6080r:
    LDS  R22, fat
    CPI  R22, 42
    BRSH doall
    LDS R23, red
    STS blinkcolor, R23
    JMP doblink

//------------------------ v Operations v ------------------------\\

//turn all lights off
donothing:
    LDS R18, allc
    OUT 0x04, R18
    LDI R18, 0
    OUT 0x05, r18
    ret

//blink the lights
doblink:
      lds    r17, allc
      out    0x04, r17
      ldi    r16, 50
all:  lds    r17, blinkcolor
      out    0x05, r17
      ldi    r18, 0xff
dl1:  ldi    r19, 0xff
dl2:  nop
      nop
      nop
      nop
      dec    r19
      brne   dl2
      dec    r18
      brne   dl1
      ldi    r17, 0x00
      out    0x05, r17
      ldi    r18, 0xff
dl3:  ldi    r19, 0xff
dl4:  nop
      nop
      nop
      nop
      dec    r19
      brne   dl4
      dec    r18
      brne   dl3
      dec    r16
      brne   all
      ret

//turn all lights on, no blinking
doall:
    LDI R17, 0b000110001
    OUT 0x04, R17
    LDI R17, 0b000110001
    OUT 0x05, R17
    ret

//------------------------ ^ Operations ^ ------------------------\\


male:

    //find the age group
    LDS  R21, age
    CPI  R21, 20
    BRLT donothing
    jmp mage20


//--DETERMINE AGE--\\

//check if 20-40
mage20:
    LDS  R21, age
    CPI  R21, 40
    BRSH mage40
    jmp mbfat2040b //jump to fat 20-40
    
mage40:
    LDS  R21, age
    CPI  R21, 60
    BRSH mage60
    jmp mbfat4060b //jump to fat if 40-60
    
mage60:
    LDS  R21, age
    CPI  R21, 80
    BRSH mdonothing
    jmp mbfat6080b //jump to fat if 60-80

//--DETERMINE FAT--\\

//fat for 20-40 range
//blue light
mbfat2040b:
    LDS  R22, fat
    CPI  R22, 8
    BRSH mbfat2040g
    LDS R23, blue
    STS blinkcolor, R23
    JMP doblink
    
//green light
mbfat2040g:
    LDS  R22, fat
    CPI  R22, 20
    BRSH mbfat2040r
    LDS R23, green
    STS blinkcolor, R23
    JMP doblink
    
//red light
mbfat2040r:
    LDS  R22, fat
    CPI  R22, 25
    BRSH mdoall
    LDS  R23, red
    STS  blinkcolor, R23
    JMP  doblink

//extra leaps to make the branch
mdonothing:
    JMP donothing
mdoall:
    JMP doall
    
//fat for 40-60 range
//blue light
mbfat4060b:
    LDS  R22, fat
    CPI  R22, 11
    BRSH mbfat4060g
    LDS  R23, blue
    STS  blinkcolor, R23
    JMP  doblink
    
    
//green light
mbfat4060g:
    LDS  R22, fat
    CPI  R22, 22
    BRSH mbfat4060r
    LDS  R23, green
    STS  blinkcolor, R23
    JMP  doblink
    
//red light
mbfat4060r:
    LDS  R22, fat
    CPI  R22, 28
    BRSH mdoall
    LDS  R23, red
    STS  blinkcolor, R23
    JMP  doblink


//fat for 60-80 range
//blue light
mbfat6080b:
    LDS  R22, fat
    CPI  R22, 13
    BRSH mbfat6080g
    LDS  R23, blue
    STS  blinkcolor, R23
    JMP  doblink
    
//green light
mbfat6080g:
    LDS  R22, fat
    CPI  R22, 25
    BRSH mbfat6080r
    LDS  R23, green
    STS  blinkcolor, R23
    JMP  doblink
    
//red light
mbfat6080r:
    LDS  R22, fat
    CPI  R22, 30
    BRSH mdoall
    LDS  R23, red
    STS  blinkcolor, R23
    JMP  doblink

    
