[org 0x7c00] ; Move all labels up to 0x7c00

; Initialize the stack. Can't be done in a function easily.
mov bp, 0x8000 ; This is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; If the stack is empty then sp points to bp

call main

%include "boot/util.asm"
%include "boot/disk.asm"
%include "boot/protected-mode.asm"
%include "boot/gdt.asm"
%include "boot/locale-en.asm"

main:
    call save_hdd_number
    call clear_screen

    ; Print welcome message
    mov ah, 0x0e
    mov bx, msg
    call print_loop

    ; call reset_cursor

    call disk_init

    call enter_protected_mode

    jmp $

times 510-($-$$) db 0   ; Fill with 510 zeros minus the size of the previous code
dw 0xaa55               ; Boot sect
