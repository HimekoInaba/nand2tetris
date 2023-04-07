// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(LOOP)
  @i
  M=0         // set i = 0
  @8192
  D=A
  @n
  M=D       // set n = 480

  @SCREEN
  D=A
  @addr
  M=D

  @KBD
  D=M
  @key
  M=D

  (FILL_LOOP)
  @i
  D=M
  @n
  D=D-M
  @LOOP
  D;JEQ    // if (i == n) goto LOOP

  @key
  D=M
  @CLEAR
  D;JEQ    // if (key == 0) goto CLEAR
  
  @addr
  A=M
  M=-1      // set RAM[addr] = 1111111111111111
  @NEXT
  0;JMP

  (CLEAR)
    @addr
    A=M
    M=0     // set RAM[addr] = 0000000000000000

  (NEXT)
  @i
  M=M+1   // i++
  @addr
  M=M+1   // addr++

  @FILL_LOOP
  0;JMP
