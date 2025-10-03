
; Read Only Memory
ROM0
    ORG $040
    "VBlankInterrupt"

    ORG $100
    "Header"

    ORG $150
    "Init"

    FLOATING
    "MainLoop"

    FLOATING
    "StandardLibrary"

    FLOATING 
    "VBlankHandler"

