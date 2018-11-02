%include "graphics_rectangle_main.asm"
%include "graphics_colour_menu.asm"
%include "graphics_rectangle_algorithm.asm"

Graphics_Rectangle:
    push    150d   ; y1               ; Default arguments
    push    190d   ; x1
    push    50d    ; y0
    push    50d    ; x0
    call    Graphics_Rectangle_Main

    ret

;____________________
Graphics_Rectangle_Setup:
    mov     cx, word [bp + rect_x0]     ; Column start
    mov     dx, word [bp + rect_y0]     ; Row start
    mov     ax, word [bp + px_set]      ; AH: 0Ch, AL: colour
    ret