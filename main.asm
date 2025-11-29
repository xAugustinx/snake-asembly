.global _start
.intel_syntax noprefix

.section .bss
    input: .space 1
    plansza: .space 71
    japki: .space 2
    wonszPlace: .space 128
    ##bools
    czyKoniecGry: .space 1
    czyUsunacOstatniElement: .space 1
    #Parzyste + 0 to Y 
    #Nieparzyste to X
    tymczasowaPozycjaWensza: .space 2
    


.section .data
consoleClear:
        .ascii "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
enter:
    .ascii "\n"
.section .text
_start:
    ##PLANSZA NA ZERO + granice
    MOV eax, 0
    lea rbx, [rip + plansza]

    planszaNaZero:
    MOV byte ptr [rbx + rax], 35
    ADD rax, 1
    CMP rax, 71
    JNE planszaNaZero
    
    MOV rax, 8

    granicePlanszy:
    MOV byte ptr [rbx + rax], 10
    ADD rax, 9
    CMP rax, 71
    JNE granicePlanszy


    ##WONSZ NA ZERO
    MOV eax, 4
    lea rbx, [rip + wonszPlace]

    wonszNaZero:
    MOV byte ptr [rbx + rax], 255
    ADD rax, 1
    CMP rax, 128
    JNE wonszNaZero

    MOV byte ptr [rip + wonszPlace],5
    MOV byte ptr [rip + wonszPlace+1],5
    MOV byte ptr [rip + wonszPlace+2],5
    MOV byte ptr [rip + wonszPlace+3],6

    #USTAWIE PSEUDO ZMIENNYCH
    MOV byte ptr [rip + input], 1
    MOV byte ptr [rip + japki], 3
    MOV byte ptr [rip + japki + 1], 3
    MOV byte ptr [rip + czyKoniecGry], 0
    MOV byte ptr [rip + czyUsunacOstatniElement], 0

    petlaGry:
        jmp zbieranieInputu
        koniecZbieraniaInputu:

        jmp zmienianieKierunkuWensza
        koniecZmienianiaKierunkuWensza:

        jmp wypisywanieZawartosciTablicy
        koniecWypisywaniaZawartosciTablicy:

        CMP byte ptr [rip + czyKoniecGry],1
    JNE petlaGry
    
    mov rax, 60
    mov rdi, 60
    syscall


wypisywanieZawartosciTablicy:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + consoleClear]
    mov rdx, 20
    syscall


    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + plansza]
    mov rdx, 71
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, enter
    mov rdx, 1
    syscall

    jmp koniecWypisywaniaZawartosciTablicy

zbieranieInputu:
    MOV rax, 0
    MOV rdi, 0
    LEA rsi, [rip + input]
    MOV rdx, 1
    syscall
    jmp koniecZbieraniaInputu


zmienianieKierunkuWensza:
    MOV al, byte ptr [rip + wonszPlace]
    MOV byte ptr [rip + tymczasowaPozycjaWensza], al

    MOV al, byte ptr [rip + wonszPlace +1]
    MOV byte ptr [rip + tymczasowaPozycjaWensza + 1], al

    CMP byte ptr [rip + input], 119
    JNE klawiszW

    CMP byte ptr [rip + input], 115
    JNE klawiszS

    CMP byte ptr [rip + input], 97
    JNE klawiszA

    CMP byte ptr [rip + input], 100
    JNE klawiszD

    kontynulujPoSprawdzeniuKlawisza:

    jmp koniecZmienianiaKierunkuWensza

klawiszW:
    ADD byte ptr [rip + tymczasowaPozycjaWensza], -1
    jmp kontynulujPoSprawdzeniuKlawisza

klawiszS:
    ADD byte ptr [rip + tymczasowaPozycjaWensza], 1
    jmp kontynulujPoSprawdzeniuKlawisza

klawiszA:
    ADD byte ptr [rip + tymczasowaPozycjaWensza+1], -1
    jmp kontynulujPoSprawdzeniuKlawisza

klawiszD:
    ADD byte ptr [rip + tymczasowaPozycjaWensza+1], 1
    jmp kontynulujPoSprawdzeniuKlawisza


