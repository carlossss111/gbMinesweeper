INCLUDE "hardware.inc"

SECTION "FillerBefore", ROM0[$0000]
    ds $40
ENDSECTION

SECTION "FillerAfter", ROM0[$0047]
    ds $100 - $47
ENDSECTION

/*******************************************************
* VBLANK INTERRUPT
* Called when rendering a VBlank (so LCY = 144)
********************************************************/
SECTION "VBlankInterrupt", ROM0[$0040]

; Called when the interrupts are enabled, the rIE register is set and 
; and a VBlank has started
Interrupt:
    push af                     ; store the states of all the registers
    push bc
    push de
    push hl
    jp Handler                  ; start handler code

ENDSECTION

/*******************************************************
* VBLANK HANDLER
* Called by the interrupt
********************************************************/
SECTION "VBlankHandler", ROM0

; Enable the VBlank bit on the interrupt register
; @uses a
SetVBlankInterrupt::
    ld a, [rIE]
    or a, IE_VBLANK             ; sets the VBlank bit
    ld [rIE], a                 ; enables the VBlank interrupt flag
    ret

; Enables the VBlank bit on the interrupt register and disables all others
; @uses a
SetVBlankInterruptOnly::
    xor a                       ; clear all bits
    or a, IE_VBLANK             ; sets the VBlank bit only
    ld [rIE], a                 ; enables the VBlank interrupt flag, disable others
    ret
    
; Disable the VBlank bit on the interrupt register
; @uses a
UnsetVBlankInterrupt::
    ld a, [rIE]
    and a, !IE_VBLANK           ; unsets the VBlank bit
    ldh [rIE], a                ; disables the VBlank interrupt flag
    ret

; Called by the VBlank Interrupt
; Doesn't do anything yet except implicitly wake up the CPU from the halt instr
Handler:
    ; do something here?

    pop hl                      ; restore all register states
    pop de
    pop bc
    pop af
    reti                        ; interrupt return

ENDSECTION

