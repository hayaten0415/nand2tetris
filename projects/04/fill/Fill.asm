// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.

// 512px * 256px / 16 = 8192

(LOOP)
    @KBD
    D=M              // D = キー入力の状態
    @BLACK
    D;JNE            // D ≠ 0 → BLACK へジャンプ

(WHITE)
    @0
    D=A              // D = 0（白）
    @COLOR
    M=D
    @DRAW
    0;JMP

(BLACK)
    @0
    D=A
    D=!D             // D = -1（0xFFFF）黒
    @COLOR
    M=D

(DRAW)
    @SCREEN
    D=A
    @addr
    M=D              // addr = SCREEN 開始位置

    @8192
    D=A
    @end
    M=D              // end = 8192 ワード

(CLEAR_LOOP)
    @addr
    A=M
    D=M              // 現在の内容（無視）

    @COLOR
    D=M
    @addr
    A=M
    M=D              // 塗りつぶし

    @addr
    M=M+1            // 次のワードへ

    @end
    D=M
    @addr
    D=M-D
    @LOOP
    D;JEQ            // 全て塗り終わったらループへ戻る

    @CLEAR_LOOP
    0;JMP