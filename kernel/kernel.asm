[bits 32]
; [org 0x1000]
[extern kernel_main]

call kernel_entry

kernel_entry:
    call kernel_main
    jmp $

    call clear_screen

    mov dx, 0x3D4
    mov al, 0xA     ; low cursor shape register
    out dx, al

    inc dx
    mov al, 0x20    ; bits 6-7 unused, bit 5 disables the cursor, bits 0-4 control the cursor shape
    out dx, al

    jmp $

clear_screen:
    pusha
    last_character: equ 0xbb000
    mov ebx, last_character
    clear_screen_loop:
        mov al, ' '
        mov ah, 0b00001010
        mov [ebx], ax
        cmp ebx, 0xb8000
        jz done
        sub ebx, 2
        jmp clear_screen_loop
    done:
        popa
        ret

times 512-($-$$) db 0   ; Fill with 512 zeros minus the size of the previous code
