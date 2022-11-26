; Set BX to a pointer to a null terminated string
print_loop:
    pusha
start:
    mov al, [bx]

    cmp al, 0x00
    jz done

    int 0x10
    add bx, 0x01

    jmp start
done:
    popa
    ret

print:
    pusha
    mov ah, 0x0e
    mov al, bh
    int 0x10
    mov al, bl
    int 0x10
    popa
    ret

init_stack:
    mov bp, 0x8000 ; This is an address far away from 0x7c00 so that we don't get overwritten
    mov sp, bp ; If the stack is empty then sp points to bp
    ret

clear_screen:
    pusha
    mov ah, 0x00 ; Clear screen
    mov al, 0x02
    int 0x10
    popa
    ret

reset_cursor:
    mov ah, 0x02 ; Move cursor to top
    mov bh, 0x00 ; Page
    mov dh, 0x00 ; Row
    mov dl, 0x00 ; Column
    int 0x10
    ret

save_hdd_number:
    disk_num: db 0
    mov [disk_num], dl
    ret
