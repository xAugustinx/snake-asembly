.global _start
.intel_syntax noprefix

.section .bss
    wszystkieElementyWenza: .space 64
    kierunekWenza: .space 1
    plansza: .space 73
    czyKoniec: .space 1
    japko: .space 1
    input: .space 1


    licznikTestowyMeow: .space 1

.section .data

consoleClear:
        .ascii "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
.section .text

_start:
    MOV byte ptr [rip + licznikTestowyMeow], 49

    ##USTAWIANIE WĘŻA NA ZERO
    LEA rbx, [rip + wszystkieElementyWenza]
    MOV rax, 0

    ustawianieWenszaNaZero:
    MOV byte ptr [rbx + rax], 255
    ADD rax, 1
    CMP rax, 64
    JNE ustawianieWenszaNaZero

    MOV byte ptr [rip + kierunekWenza],20

    ##Zmienne Dodatkowe
    MOV byte ptr [rip + wszystkieElementyWenza],29
    MOV byte ptr [rip + wszystkieElementyWenza+1],38
    MOV byte ptr [rip + wszystkieElementyWenza+2],47
    MOV byte ptr [rip + wszystkieElementyWenza+3],56

    mainPetla:


    jmp wczytywanieZawartosciDoTablicy
    koniecWczytywaniaZawartosciDoTablicy:

    jmp wypisywanieZawartosciTablicy
    koniecWypisywaniaZawartosciTablicy:

    jmp zbieranieInputu
    koniecZbieraniaInputu:

    jmp dodanieNowegoElementuDoWensza
    koniecDodaniaNowegoElementuDoWensza:

    jmp usuniecieOstatniegoElementu
    koniecUsunieciaOstatniegoElementu:

    jmp mainPetla

    jmp koniec

dodanieNowegoElementuDoWensza:
    MOV rax, 62
    LEA rbx, [rip + wszystkieElementyWenza]
    miejsceNaNowyElement:
    MOV al, byte ptr [rbx + rax]
    MOV byte ptr [rbx + rax +1], al

    ADD rax, -1
    CMP rax, -1
    JNE miejsceNaNowyElement


    MOV al, byte ptr [rip + kierunekWenza]
    ADD byte ptr [rip + wszystkieElementyWenza], al

    
    jmp koniecDodaniaNowegoElementuDoWensza

usuniecieOstatniegoElementu:
    MOV rax, -1
    LEA rbx, [rip + wszystkieElementyWenza]

    szukanieOstatniegoElementu33:
    ADD rax, 1
    CMP byte ptr [rbx + rax], 255
    JNE szukanieOstatniegoElementu33

    MOV byte ptr [rbx + rax -1], 255

    ##licznik testowy
    ADD byte ptr [rip + licznikTestowyMeow], 1

    mov rax, 1
	mov rdi, 1
	lea rsi, [rip + licznikTestowyMeow]
	mov rdx, 1
	syscall

    jmp koniecUsunieciaOstatniegoElementu
wczytywanieZawartosciDoTablicy:
    #ustawianie planszy na Zero
    LEA rbx, [rip + plansza]

    MOV rax, 0
    ustawianiePlanszyNaZero:
    MOV byte ptr [rbx + rax], 35

    ADD rax, 1
    CMP rax, 72
    JNE ustawianiePlanszyNaZero
    ##dodanie  \n
    MOV rax, 0
    dodanieN:
    MOV byte ptr [rbx + rax],10
    ADD rax, 9
    CMP rax, 72
    JNE dodanieN

    

    MOV rax, 0
    MOV rcx, 0
    MOV rdx, 0

    LEA rbx, [rip + wszystkieElementyWenza]

    ustawianieWenszaNaPlansze:
    ##MEOW MEOW


    MOVZX rcx, byte ptr [rbx + rax]
    LEA rdx, [rip + plansza]

    MOV byte ptr [rdx + rcx], 79

    ADD rax, 1
    CMP byte ptr [rbx + rax], 255
    JNE ustawianieWenszaNaPlansze

    jmp koniecWczytywaniaZawartosciDoTablicy
wypisywanieZawartosciTablicy:
    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + consoleClear]
    mov rdx, 20
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + plansza]
    mov rdx, 73
    syscall

    jmp koniecWypisywaniaZawartosciTablicy

zbieranieInputu:
    MOV rax, 0
    MOV rdi, 0
    LEA rsi, [rip + input]
    MOV rdx, 2
    syscall
    
    MOV al, byte ptr [rip + wszystkieElementyWenza]
    MOV byte ptr [rip + kierunekWenza], al

    ##  MOV byte ptr [rip + kierunekWenza], byte ptr [rip + wszystkieElementyWenza]

    CMP byte ptr [rip + input], 119
    JE klawiszW

    CMP byte ptr [rip + input], 115
    JE klawiszS

    CMP byte ptr [rip + input], 97
    JE klawiszA

    CMP byte ptr [rip + input], 100
    JE klawiszD

    kontynulujPoSprawdzeniuKlawisza:


    mov rax, 1
    mov rdi, 1
    lea rsi, [rip + input+1]
    mov rdx, 1
    syscall


    jmp koniecZbieraniaInputu
klawiszW:
    MOV byte ptr [rip + kierunekWenza], -9
    jmp kontynulujPoSprawdzeniuKlawisza

klawiszS:
    MOV byte ptr [rip + kierunekWenza], 9
    jmp kontynulujPoSprawdzeniuKlawisza

klawiszA:
    MOV byte ptr [rip + kierunekWenza], -1
    jmp kontynulujPoSprawdzeniuKlawisza

klawiszD:
    MOV byte ptr [rip + kierunekWenza], 1
    jmp kontynulujPoSprawdzeniuKlawisza

koniec:
    MOV rax, 60
    MOV rdi, 60
    syscall
