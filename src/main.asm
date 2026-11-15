org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A


start:
	jmp main


;
; Prints a string to the screen.
; Params:
;	- ds:si points to string
;
puts:
	; save registers that will be modified
	push si
	push ax

.loop:
	lodsb 				; loads next char in al
	or al, al 			; verify if next char is null
	jz .done			; jmp if null

	mov ah, 0x0e
	mov bh, 0
	int 0x10

	jmp .loop

.done:
	pop ax
	pop si
	ret


main:
	; ds setup
	mov ax, 0
	mov ds, ax
	mov es, ax

	; stack setup
	mov ss, ax
	mov sp, 0x7C00 		; stack grow downwards, place stack pointer at start of program

	mov si, msg_hello_world
	call puts

	hlt

.halt:
	jmp .halt


msg_hello_world: db 'Hello, World!', ENDL, 0



times 510-($-$$) db 0
dw 0AA55h
