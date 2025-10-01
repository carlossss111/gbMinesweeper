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

