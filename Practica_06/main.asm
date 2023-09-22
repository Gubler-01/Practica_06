;PRACTICA 06 ENCENDER Y APAGAR 4 LED'S CON DURACION DE 300ms ;
;Realizo:
;Fecha:
;Ver:

;F=16mhz = 16x10^[6]
;T=1/F = 1/16x10^[6] =0.0625

;Defining loop counts for 499,998 cycles

.equ cExter = 100 	; the outer loop count
.equ cMedio = 160 	; the middle loop count
.equ cInter = 99 	; the inner loop count
; Defining register names

.def rExter = R16 	;defining the register for the outer loop
.def rMedio = R17 	;defining the register for the middle loop
.def rInter = R18 	;defining the register for the inner loop


.org 0X00       ;empieza a escribir codigo en la menoria 0 del microprocesador

rjmp inicio     ;Salto hacia la etiqueta //// Tiempo que se tarda en hacer la instruccion 
inicio:

ldi r16,low(RAMEND)			;cada imnediatamente un valor (RAMEND) en el registro (r16)
out SPL,r16					;mueve el valor del registro a la pila (spl)
ldi r16,high(RAMEND)
out SPH,r16

ldi r16, 0xFF			;almacena puros 1 en r16=0B11111111 valor maximo de 64bits (255) 
out DDRB, r16			;todas las terminales van a funcionar como salidas 8-13
out DDRD, r16			;todas las terminales van a funcionar como salidad 0-7

;Inicio del programa

ciclo:
;sbi led encendido y cbi Led apagado

; Encender los led's uno por uno 
sbi PORTD, 5  ; establecer el bit correspondiente al pin 8 en PORTB
rcall Retraso03     ; esperar medio segundo

sbi PORTD, 6  
rcall Retraso03

sbi PORTD, 7  
rcall Retraso03     ; esperar medio segundo

sbi PORTB, 0
rcall Retraso03     ; esperar medio segundo

; Apagar los led's uno por uno 
cbi PORTD, 5  
rcall Retraso03    ; esperar medio segundo
cbi PORTD, 6  
rcall Retraso03     ; esperar medio segundo
cbi PORTD, 7  
rcall Retraso03     ; esperar medio segundo
cbi PORTB, 0
rcall Retraso03     ; esperar medio segundo



rjmp ciclo ; Vuelve al inicio del ciclo


;---------------------------------------------------------------------------------------
;Sub-Rutinas

Retraso03:
	LDI rExter,cExter 	; Set register rOuter to the cOuter count value
LoopOuter:
	LDI rMedio,cMedio 	; Set register rMiddle to the cMiddle count value
LoopMiddle:
	LDI rInter,cInter 	; Set register rInner to the cInner count value
LoopInner:
	DEC rInter 		; Decrease inner loop counter
	BRNE LoopInner 		; Jump back to the inner label if not zero
	DEC rMedio 		; Decrease middle loop counter
	BRNE LoopMiddle 	; Jump back to the middle label if not zero
	DEC rexter 		; Decrease outer loop counter
	BRNE LoopOuter 		; Jump back to the outer label if not zero
	RET