str_trim PROC
        PUSH     {r4,lr}
        MOVS     r4,r0
; R4=s
        BL       strlen        ; strlen() prend la valeur de "s" dans R0
; R0=str_len
        MOVS     r3,#0
; R3 contiendra toujours 0
        B        |L0.24|
|L0.12|
        CMP      r1,#0xd       ; est-ce que l'octet §chargé§ est '\r'?
        BEQ      |L0.20|
        CMP      r1,#0xa       ; est-ce que l'octet §chargé§ est '\n'?
        BNE      |L0.38|       ; sauter §à§ la sortie si non
|L0.20|
        SUBS     r0,r0,#1      ; R0-- ou str_len--
        STRB     r3,[r2,#0x1f] ; stocker 0 §à§ l'adresse R2+0x1F=s+str_len-0x20+0x1F=s+str_len-1
|L0.24|
        CMP      r0,#0         ; str_len==0?
        BEQ      |L0.38|       ; oui? sauter §à§ la sortie
        ADDS     r2,r4,r0      ; R2=R4+R0=s+str_len
        SUBS     r2,r2,#0x20   ; R2=R2-0x20=s+str_len-0x20
        LDRB     r1,[r2,#0x1f] ; charger l'octet §à§ l'adresse R2+0x1F=s+str_len-0x20+0x1F=s+str_len-1 dans R1
        CMP      r1,#0         ; est-ce que l'octet §chargé§ est 0?
        BNE      |L0.12|       ; sauter au §début§ de la boucle, si ce n'est pas 0
|L0.38|
; renvoyer "s"
        MOVS     r0,r4
        POP      {r4,pc}
        ENDP
