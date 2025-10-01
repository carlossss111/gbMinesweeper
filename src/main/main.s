INCLUDE "hardware.inc"

/*******************************************************
* BOOTROM & CARTRIDGE HEADER
* Populated by the rgbfix tool
********************************************************/
SECTION "BootROM", ROM0[$000]

	ds $100

ENDSECTION


SECTION "Header", ROM0[$100]

	jp EntryPoint

	ds $150 - @, 0

ENDSECTION


/*******************************************************
* INITIALISATION
* Copies memory to where it needs to be
********************************************************/
SECTION "Init", ROM0
EntryPoint:
    ; Turn off audio until I know how to implement it
    xor a
	ld [rNR52], a               ; set audio register

    ; Load title screen
    


    
    halt
ENDSECTION


/*******************************************************
* MAIN LOOP
* The main event loop for the program
********************************************************/
SECTION "MainLoop", ROM0
Main:
    halt
ENDSECTION

