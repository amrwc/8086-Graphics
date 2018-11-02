; Input:
; x0: [bp + 4]  -> [bp + x0]
; y0: [bp + 6]  -> [bp + y0]
; x1: [bp + 8]  -> [bp + x1]
; y1: [bp + 10] -> [bp + y1]

%assign x0      4
%assign y0      6
%assign x1      8
%assign y1      10
%assign px_set  12                      ; Pixel settings

Graphics_Line_Main:
    push	bp
	mov		bp, sp
    push    ax

    call    Main_Menu

;____________________
main_menu_get_key:
    xor     ah, ah                      ; Get a keystroke
    int     16h

    cmp     ah, 01h                     ; exit
    jne     main_menu_option1
    call    Halt

main_menu_option1:
    cmp     ah, 02h
    jne     main_menu_option2
    mov     [bp + x0], word 10d
    mov     [bp + y0], word 20d
    mov     [bp + x1], word 310d
    mov     [bp + y1], word 180d
    jmp     end_main_menu

main_menu_option2:
    cmp     ah, 03h
    jne     main_menu_option3
    mov     [bp + x0], word 280d
    mov     [bp + y0], word 15d
    mov     [bp + x1], word 40d
    mov     [bp + y1], word 195d
    jmp     end_main_menu

main_menu_option3:
    cmp     ah, 04h
    jne     main_menu_option4
    mov     [bp + x0], word 200d
    mov     [bp + y0], word 120d
    mov     [bp + x1], word 15d
    mov     [bp + y1], word 5d
    jmp     end_main_menu

main_menu_option4:
    cmp     ah, 05h
    jne     main_menu_option5
    mov     [bp + x0], word 32d
    mov     [bp + y0], word 175d
    mov     [bp + x1], word 182d
    mov     [bp + y1], word 3d
    jmp     end_main_menu

main_menu_option5:
    cmp     ah, 06h
    jne     main_menu_option6

    call    Graphics_Set_Display_Mode

    push    word 0C0Ah
    push    word 180d
    push    word 310d
    push    word 20d
    push    word 10d
    call    Bresenham_Main

    push    word 0C0Ch
    push    word 195d
    push    word 40d
    push    word 15d
    push    word 280d
    call    Bresenham_Main

    push    word 0C0Eh
    push    word 5d
    push    word 15d
    push    word 120d
    push    word 200d
    call    Bresenham_Main

    push    word 0C0Fh
    push    word 3d
    push    word 182d
    push    word 175d
    push    word 32d
    call    Bresenham_Main

    call    Graphics_Done               ; Skip colour menu and tests.
    mov     ax, 0003h
    int     10h

    pop     ax
    leave
    ret 8
    
main_menu_option6:                      ; Use default coordinates
    cmp     ah, 07h
    jne     main_menu_get_key

;____________________
end_main_menu:
    mov     ax, 0003h
    int     10h

    push    word 0C00h                  ; Default pixel settings. Push for easier colour setup in subsequent menu.
    push    word [bp + y1]
    push    word [bp + x1]
    push    word [bp + y0]
    push    word [bp + x0]

    call    Graphics_Line_Colour_Menu
    call    Test_Boundaries
    call    Test_Straight

    pop     ax
    leave
    ret 8

;____________________
Main_Menu:
    push    bp
    mov     bp, sp
    push    si

    mov     si, graphics_line_main_menu_prompt
    call    Console_WriteLine_16

    mov     si, graphics_line_main_menu_option1
    call    Console_WriteLine_16
    mov     si, graphics_line_main_menu_option2
    call    Console_WriteLine_16
    mov     si, graphics_line_main_menu_option3
    call    Console_WriteLine_16
    mov     si, graphics_line_main_menu_option4
    call    Console_WriteLine_16
    mov     si, graphics_line_main_menu_option5
    call    Console_WriteLine_16
    mov     si, graphics_line_main_menu_option6
    call    Console_WriteLine_16

    call    New_Line_16
    mov     si, graphics_line_menu_prompt_exit
    call    Console_WriteLine_16

    pop     si
    leave
    ret

;____________________
; Data
graphics_line_main_menu_prompt: db 'Choose one of the options below:', 0
graphics_line_main_menu_option1: db '1: (10, 20) -> (310, 180)', 0
graphics_line_main_menu_option2: db '2: (280, 15) -> (40, 195)', 0
graphics_line_main_menu_option3: db '3: (200, 120) -> (15, 5)', 0
graphics_line_main_menu_option4: db '4: (32, 175) -> (182, 3)', 0
graphics_line_main_menu_option5: db '5: Draw all of the above.', 0
graphics_line_main_menu_option6: db '6: Use default coordinates.', 0