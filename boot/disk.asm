disk_init:
    mov ah, 2           ; Instruction
    mov al, 1           ; Sectors to read
    mov ch, 0           ; Cylinder
    mov cl, 2           ; Sector
    mov dh, 0           ; Header
    mov dl, [disk_num]  ; Drive number

    pusha
    mov ax, 0
    mov es, ax           ; ES:BX
    popa

    mov bx, KERNEL_OFFSET      ; ES:BX

    int 0x13
    ret