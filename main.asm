.global _start
.intel_syntax noprefix

.section .bss
    wszystkieElementyWenza: .space 64
    kierunekWenza: .space 1
    plansza: .space 73
    input: .space 1
    czyKoniec: .space 1
    czyUsunoc: .space 1
    japko: .space 1


    licznikTestowyMeow: .space 1

.section .data

consoleClear:
        .ascii "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
.section .text

_start:
    MOV byte ptr [rip + czyUsunoc], 1
    MOV byte ptr [rip + japko], 69

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
    #MOV byte ptr [rip + wszystkieElementyWenza+3],56

    mainPetla:


    jmp wczytywanieZawartosciDoTablicy
    koniecWczytywaniaZawartosciDoTablicy:

    jmp wypisywanieZawartosciTablicy
    koniecWypisywaniaZawartosciTablicy:

    jmp zbieranieInputu
    koniecZbieraniaInputu:
    
    CMP byte ptr [rip + czyUsunoc], 1

    JE usuniecieOstatniegoElementu
    koniecUsunieciaOstatniegoElementu:

    MOV byte ptr [rip + czyUsunoc], 1

    jmp dodanieNowegoElementuDoWensza
    koniecDodaniaNowegoElementuDoWensza:

    jmp czyGraSieKonczyLubCzyJapko
    koniecCzyGraSieKonczy:

    jmp sprawdzanieCzySciana
    koniecSprawdzaniaCzySciana:
    

    jmp mainPetla

    jmp koniec

dodanieNowegoElementuDoWensza:
    ##jmp koniecDodaniaNowegoElementuDoWensza
    MOV rax, 62
    LEA rbx, [rip + wszystkieElementyWenza]
    miejsceNaNowyElement:

    breakPointMeow:
    MOV cl, byte ptr [rbx + rax]
    MOV byte ptr [rbx + rax +1], cl

    MOVZX rcx, byte ptr [rbx + rax +1]

    ADD rax, -1
    CMP rax, -1
    JNE miejsceNaNowyElement

    MOV byte ptr [rbx + 63], 255

    MOV cl, byte ptr [rip + kierunekWenza]
    ADD byte ptr [rip + wszystkieElementyWenza], cl

    
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


    MOVZX rax, byte ptr [rip + japko]

    LEA rbx, [rip + plansza]
    MOV byte ptr [rbx + rax], '.'

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


czyGraSieKonczyLubCzyJapko:
    MOV rax, 0
    LEA rbx, [rip + wszystkieElementyWenza]
    MOV cl, byte ptr [rip + wszystkieElementyWenza]
    czyGraSieKonczyLoop:

    MOV dl, byte ptr [rip + japko]

    ADD rax, 1

    CMP cl, byte ptr [rbx + rax]
    JE koniec

    CMP dl, byte ptr [rbx]
    JE japkoZnalezione


    CMP rax, 63
    JNE czyGraSieKonczyLoop

    jmp koniecCzyGraSieKonczy

japkoZnalezione:
    MOV byte ptr [rip + czyUsunoc], 0
    MOV rax, 0
    lea rbx, [rip + plansza]

    noweMiejsceNaJapko:

    CMP byte ptr [rbx + rax], '#'
    JE ustawienieNowego

    ADD rax, 1
    CMP rax, 73
    JNE noweMiejsceNaJapko

    jmp koniecCzyGraSieKonczy

ustawienieNowego:
    MOV byte ptr [rip + japko], al
    jmp koniecCzyGraSieKonczy
    
sprawdzanieCzySciana:
    MOV al, 0
    mainPetlaSprawdzaniaCzySciana:
    
    CMP al, byte ptr [rip + wszystkieElementyWenza]
    JE koniec

    ADD al, 9
    CMP al, 72
    JNE mainPetlaSprawdzaniaCzySciana

    MOV al, byte ptr [rip + wszystkieElementyWenza]
    MOV bl, -1

    CMP bl, al
    jg koniec

    CMP al, 71
    jg koniec

    jmp koniecSprawdzaniaCzySciana
koniec:
    MOV rax, 60
    MOV rdi, 60
    syscall
