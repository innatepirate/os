;;kernel.asm
bits 32
section .text
	align 4
	dd 0x1BADB002		;magic
	dd 0x00			;flags
	dd - (0x1BADB002 + 0x00);checksum
global start
extern kmain

global idt_load
extern idtp
idt_load:
	lidt [idtp]
	ret

global gdt_flush
extern gp
gdt_flush:
	lgdt [gp]   ;loads gdt with [gp]
	mov ax, 0x10 ; 0x10 is the offset in GDT to our segment
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	jmp 0x08:flush2
flush2:
	ret
start:
	cli
	call kmain
	hlt

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

isr0:
	cli
	push byte 0
	push byte 0
	jmp isr_common_stub
isr1:
	cli
	push byte 0
	push byte 0
	jmp isr_common_stub
isr2:
        cli
        push byte 0
        push byte 0
        jmp isr_common_stub
isr3:
        cli
        push byte 0
        push byte 0
        jmp isr_common_stub
isr4:
        cli
        push byte 0
        push byte 0
        jmp isr_common_stub
isr5:
        cli
        push byte 0
        push byte 0
        jmp isr_common_stub
isr6:
        cli
        push byte 0
        push byte 0
        jmp isr_common_stub
isr7:
        cli
        push byte 0
        push byte 0
        jmp isr_common_stub
isr8:
	cli
	push byte 8
	jmp isr_common_stub

isr9:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub

isr10:
        cli
        push byte 8
        jmp isr_common_stub
isr11:
        cli
        push byte 8
        jmp isr_common_stub
isr12:
        cli
        push byte 8
        jmp isr_common_stub
isr13:
        cli
        push byte 8
        jmp isr_common_stub
isr14:
        cli
        push byte 8
        jmp isr_common_stub
isr15:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr16:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr17:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr18:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr19:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr20:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr21:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr22:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr23:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr24:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr25:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr26:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr27:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr28:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr29:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr30:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub
isr31:
        cli
        push byte 0
		push byte 0
        jmp isr_common_stub


extern fault_handler
isr_common_stub:
	pusha
	push ds
	push es
	push fs
	push gs
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov eax, esp
	push eax
	mov eax, fault_handler
	call eax
	pop eax
	pop gs
	pop fs
	pop es
	pop ds
	popa
	add esp,8
	iret
