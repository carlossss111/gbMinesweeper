INCLUDE "hardware.inc"

/*******************************************************
* CARTRIDGE HEADER
* Populated by the rgbfix tool
********************************************************/
SECTION "Header", ROM0[$0100]

	jp EntryPoint

	ds $150 - @, 0

ENDSECTION

/*******************************************************
* INITIALISATION
* Copies memory to where it needs to be
********************************************************/
SECTION "Init", ROM0

; Global entrypoint for the program
; @uses all registers
EntryPoint:
    ld sp, $E000                ; set stack pointer

    xor a
	ld [rNR52], a               ; turn off audio

    call SetVBlankInterruptOnly ; set vblank only
    ei                          ; enable interrupts
    
    jp Main                     ; jump to the main loop

ENDSECTION


/*******************************************************
* MAIN LOOP
* The main event loop for the program
********************************************************/
SECTION "MainLoop", ROM0

; Main loop that each game state returns to upon finishing
; @uses all registers
Main:
    halt                        ; wait until a vblank interrupt
    jp Main

ENDSECTION

