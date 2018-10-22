; Prevent drawing beyond boundaries.
    cmp     word [x0], 0                ; 0 <= x0 <= 319
    jg      is_x0_over_319
    je      is_x1_below_0
    mov     [x0], word 0
    jmp     is_x1_below_0
is_x0_over_319:
    cmp     word [x0], 319d
    jle     is_x1_below_0
    mov     [x0], word 319d

is_x1_below_0:                          ; 0 <= x1 <= 319
    cmp     word [x1], 0
    jg      is_x1_over_319
    je      is_y0_below_0
    mov     [x1], word 0
    jmp     is_y0_below_0
is_x1_over_319:
    cmp     word [x1], 319d
    jle     is_y0_below_0
    mov     [x1], word 319d

is_y0_below_0:                          ; 0 <= y0 <= 199
    cmp     word [y0], 0
    jg      is_y0_over_199
    je      is_y1_below_0
    mov     [y0], word 0
    jmp     is_y1_below_0
is_y0_over_199:
    cmp     word [y0], 199d
    jle     is_y1_below_0
    mov     [y0], word 199d

is_y1_below_0:                          ; 0 <= y1 <= 199
    cmp     word [y1], 0
    jg      is_y1_over_199
    je      end_tests
    mov     [y1], word 0
    jmp     end_tests
is_y1_over_199:
    cmp     word [y1], 199d
    jle     end_tests
    mov     [y1], word 199d

end_tests: