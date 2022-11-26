[bits 16]
enter_protected_mode:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:protected_mode

[bits 32]
KERNEL_OFFSET equ 0x1000
protected_mode:
    ; mov ax, DATA_SEG
    ; mov ds, ax
    ; mov ss, ax
    ; mov es, ax
    ; mov fs, ax
    ; mov gs, ax

    mov ebp, 0x90000		; 32 bit stack base pointer
    mov esp, ebp

    call KERNEL_OFFSET
    jmp $
[bits 16] ; reset to 16 bits for rest of MBR