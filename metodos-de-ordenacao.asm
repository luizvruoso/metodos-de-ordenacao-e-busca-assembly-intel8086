TITLE OCLM: OCLM
	.MODEL SMALL
	.STACK 1110H
	.DATA    

	VET DW 7530H DUP(?)
	tamvet DW 0
	tamexibicao DW 9d
	valorbusca DW 0
	ENDRETORNO DW 0 
	ENDF1 DW 0 
	CTRLEND1 DW 0
	CONT DW 0
	A DW 0
	B DW 0
	C DW 0
	I DW 0
	J DW 0 
	D3 DW 2D    
	esquerdaBusca DW 0
	direitaBusca DW 0
	resultbusca DW 0
	pivoBusca DW 0
	tipopreenchimento DW 0 
	CONTESPACO DW 0
	semente DW 0
	contal DW 1   
	COMP DW 0
	COMPORD DW 0
	TROCAS DW 0 
	NENCONTRado DW 0
	pivoordenacao DW 0
	msg1 DB "DIGITE O TAMANHO FISICO DE SEU VETOR - LIMITE 20.000 - PARA BUSCA ATE 16.384$"     
	msg10 DB "EXIBICAO DE VETOR PADRONIZADA ATE 10 POSICOES PARA MELHOR APRESENTACAO$"
	msg2 DB "VETOR LIDO......: $"
	msg3 DB "VETOR ORDENADO..: $"               	
	msg4 DB "DIGITE OS VALORES DO VETOR: $"   
	msg5 DB "PARA VETOR ORDENADO - 1 INVERSAMENTE ORDENADO - 2 ALEATORIO - 3: $" 
	msg6 DB "COMPARACOES.....: $"        
	msg7 DB "TROCAS..........: $"     
	msg8 DB "POSICAO BUSCA...: $"  
	msg9 DB "QUAL VALOR DESEJA BUSCAR? $"   
	msg11 DB "VALOR NAO ENCONTRADO $"   
	msg12 DB "DESEJA CONTINUAR A PROCURAR? 0-SIM 1-NAO$" 
	CTRLEXECUCAOBUSCA DW 0
	.CODE
	.STARTUP
	
	MOV CX, 0D
	MOV AH, 0
	MOV AL,0
	MOV DX, 0D
	 
	
	 
	 
	 
	 
	 
	 
	CALL exmsg1
	CALL pularlinha
	CALL exmsg10
	CALL pularlinha
	CALL lertamvet
	CALL pularlinha
	CALL exmsg5  
	CALL pularlinha 
	CALL lertipodepreenchimento   
	CALL pularlinha
	   
	   ;ajustando exibicao tam vetor    
	    MOV AX, 9D
	    CMP tamvet, AX
	    JLE FIMCONFTAMVET
	        
	        MOV AX, 9D
	        MOV tamexibicao, AX
	        JMP FIMPTFIMCONF
	    FIMCONFTAMVET: 
	        
	        MOV AX, tamvet
	        MOV tamexibicao, AX
	    FIMPTFIMCONF:NOP
	   
	   
	   ;fim
	   
	   
	CMP tipopreenchimento, 1
	JNE FIMPREE1
	    CALL ordenado
	FIMPREE1:NOP    
	CMP tipopreenchimento, 2
	JNE FIMPREE2
	    CALL invordenado
	FIMPREE2:NOP           
	CMP tipopreenchimento, 3
	JNE FIMPREE3
	    CALL aleatorio
	FIMPREE3:NOP
   ;CALL lervetor


	MOV AX, 0D
	MOV C, AX 
	MOV DI, AX
	XOR AX, AX  
	MOV SI, offset VET
	CALL exmsg2   
	CALL pularlinha 
	CALL pularlinha 
	CALL escrevervetor 
	CALL pularlinha 
;-----------------------------    
    MOV CX, 16835d
    CMP tamvet,CX
    JL FIMPROX
       MOV AX, 0	                     
	    MOV esquerdaBusca, AX    
	    MOV AX, tamvet    
	    ;MOV BX, 2D
	    ;MUL BX               
	    ;SUB AX, 1
	    MOV direitaBusca, AX           
	    PUSH direitaBusca
	    PUSH esquerdaBusca
	    CALL quicksortngrande
        JMP CONTINUACAO
    FIMPROX:NOP
        MOV AX, 0	                     
	    MOV esquerdaBusca, AX    
	    MOV AX, tamvet  
	    MOV DX,0  
	    MOV BX, 2D
	    MUL BX               
	    SUB AX, 2
	    MOV direitaBusca, AX 

	
	           
	    PUSH direitaBusca
	    PUSH esquerdaBusca
	    CALL quicksort
	 
    
    
    
    
	 
	
	
CONTINUACAO:	  
	MOV AX, 0
	MOV ENDRETORNO, AX     
	MOV CTRLEND1, AX
	MOV ENDF1, AX
	MOV SI, AX
	MOV DI, AX
	MOV DX, AX
	MOV CX, AX     
	
	
    CALL PULARLINHA
    
   

;----------------------------
	 
	CALL zerarvariaveis 
	CALL pularlinha
	CALL exmsg3
	CALL pularlinha 
	CALL pularlinha 
	CALL escrevervetor
	CALL pularlinha  
	
	
	CALL pularlinha
	CALL exmsg7    
	PUSH TROCAS
    CALL preparacaoescrita
    POP CONT
    PUSH CONT 
    CALL ESCRITA
    MOV AX, 0
    MOV CONT,AX
       
    CALL pularlinha  
    CALL exmsg6 
    PUSH COMPORD
    CALL preparacaoescrita
    POP CONT
    PUSH CONT 
    CALL ESCRITA
    MOV AX, 0
    MOV CONT,AX
    CALL PULARLINHA
    CALL PULARLINHA
	
	

	CALL exmsg9  
	CALL pularlinha  
	CALL lervalorbusca


	MOV CX, 16834d
    CMP tamvet,CX
	JNL FIMPROX2
	
;inicio busca binaria
    MOV AX, 0	                     
	MOV esquerdaBusca, AX    
	MOV AX, tamvet  
	MOV DX,0  
	MOV BX, 2D
	MUL BX               
	SUB AX, 1
	MOV direitaBusca, AX
	
	PUSH direitaBusca
	PUSH esquerdaBusca
	;PUSH resultbusca
    CALL BIN
	
	JMP CONTINUACAO2
	
	FIMPROX2:NOP
		MOV AX, 0	                     
		MOV esquerdaBusca, AX    
		MOV AX, tamvet  
		MOV DX,0  
		MOV BX, 2D
		MUL BX               
		SUB AX, 2
		MOV direitaBusca, AX
	
		PUSH direitaBusca
		PUSH esquerdaBusca
		;PUSH resultbusca
		CALL BINNGRANDE
		
CONTINUACAO2:

;fim busca binaria  
    CALL exmsg8  
    MOV AX, resultbusca
    ADD AX,2
    MOV BX, 2
    MOV DX, 0
    DIV BX
    MOV resultbusca,AX
    MOV AX, 0
    MOV BX,0
    
    
    
    PUSH resultbusca
    CALL preparacaoescrita
    POP CONT
    PUSH CONT
    CALL ESCRITA
    CALL pularlinha
    CALL exmsg6 
    
    MOV AX, 0
    MOV CONT, AX
    MOV DX, AX
          
    PUSH COMP
    CALL preparacaoescrita
    POP CONT
    PUSH CONT
    CALL ESCRITA 
        
    CALL PULARLINHA
    CMP NENCONTRADO, 1
    JNE ENDDOEND  
    
       CALL exmsg11
    
    ENDDOEND:NOP   
     

 ;--------------
   
	
	MOV AH, 4CH
	INT 21H
	
	
	
	
	
	
; PROCEDIMENTO UNIVERSAIS
;-----------------------------------------------------------------------
bin PROC  
    POP ENDRETORNO  
    POP AX ;ESQ
    POP BX  ;DIR   
        
    CMP CTRLEND1, 1D
    JE FIMCRTLEN1
       MOV CX, ENDRETORNO
       MOV ENDF1, CX 
       MOV CTRLEND1, 1D
    FIMCRTLEN1:NOP     
    
    PUSH ENDRETORNO
    
    CMP AX, BX 
    JLE FIMB1 
      INC COMP
      MOV resultbusca, -1   
      MOV AX, 1
      MOV NENCONTRado,1
      JMP FIMG
    FIMB1: NOP     
    
    
    
    
     
    MOV pivobusca, AX
    ADD pivobusca, BX   
    PUSH BX
    PUSH AX
    MOV BX, 0
    MOV BX, 2
    MOV DX, 0 
    MOV AX, pivobusca
    DIV BX          
    MOV pivobusca, AX   
        
    CMP AX, 1D
    JNE FIMTB3
       ADD AX, 1D
       MOV pivobusca, AX
    FIMTB3:NOP
    MOV DX, 0
    DIV BX
    CMP DX, 1
    JNE FIMTB4
      MOV AX, pivobusca
      SUB AX, 1
      MOV pivobusca, AX
    FIMTB4:NOP
    
    
    MOV AX, 0
    MOV BX, 0
    POP AX
    POP BX
    
    MOV SI, pivobusca 
    MOV DX, valorbusca  
    
    CMP VET[SI], DX
    JNE FIMB2
      INC COMP      
      MOV CX, pivobusca
      MOV resultbusca, CX   
      PUSH ENDF1    
      JMP FIMG
    FIMB2:NOP    
               
    MOV SI, pivobusca 
    MOV DX, valorbusca 
    
    
    CMP DX, VET[SI]      
    JNL FIMB3 
        INC COMP         
       MOV BX, pivobusca
       SUB BX, 2
       PUSH BX
       PUSH AX  
       CALL bin
    FIMB3:            
       
       MOV SI, pivobusca
       CMP DX, VET[SI] 
       JL FIMG
       INC COMP
       PUSH BX
       MOV AX, pivobusca
       ADD AX, 2
       PUSH AX  
       CALL bin
    
    
 FIMG:   
     
    RET 
bin ENDP

;----------------------------------------------------------------------------------------
binngrande PROC  
    POP ENDRETORNO  
    POP AX ;ESQ
    POP BX  ;DIR   
        
    CMP CTRLEND1, 1D
    JE FIMCRTLEN9
       MOV CX, ENDRETORNO
       MOV ENDF1, CX 
       MOV CTRLEND1, 1D
    FIMCRTLEN9:NOP     
    
    PUSH ENDRETORNO
    
    CMP AX, BX 
    JLE FIMB9 
      INC COMP
      MOV resultbusca, -1 
      JMP FIMG9
    FIMB9: NOP     
    
    
    
    
     
    MOV pivobusca, AX
    ADD pivobusca, BX   
    PUSH BX
    PUSH AX
    MOV BX, 0
    MOV BX, 2
    MOV DX, 0 
    MOV AX, pivobusca
    DIV BX          
    MOV pivobusca, AX   
        
    CMP AX, 1D
    JNE FIMTB11
       ADD AX, 1D
       MOV pivobusca, AX
    FIMTB11:NOP
    MOV DX, 0
    DIV BX
    CMP DX, 1
    JNE FIMTB12
      MOV AX, pivobusca
      SUB AX, 1
      MOV pivobusca, AX
    FIMTB12:NOP
    
    
    MOV AX, 0
    MOV BX, 0
    POP AX
    POP BX
    
    MOV SI, pivobusca 
    MOV DX, valorbusca  
    
    CMP VET[SI], DX
    JNE FIMB13
      INC COMP      
      MOV CX, pivobusca
      MOV resultbusca, CX   
      PUSH ENDF1    
      JMP FIMG
    FIMB13:NOP    
               
    MOV SI, pivobusca 
    MOV DX, valorbusca 
    
    
    CMP DX, VET[SI]      
    JNL FIMB14 
        INC COMP         
       MOV BX, pivobusca
       SUB BX, 2
       PUSH BX
       PUSH AX  
       CALL binngrande
    FIMB14:            
       
       MOV SI, pivobusca
       CMP DX, VET[SI] 
       JL FIMG9
       INC COMP
       PUSH BX
       MOV AX, pivobusca
       ADD AX, 2
       PUSH AX  
       CALL binngrande
    
    
 FIMG9:   
     
    RET 
binngrande ENDP

;----------------------------------------------------------------------------------------

leitura PROC
		MOV AX, 0
		MOV A, 0
		POP ENDRETORNO
		POP BX
	FIM9:
	WHILE1:
		CMP BX, 013d
		JLE FIM1 ; A<=C?
		SUB BX, 048D
		MOV B, BX
		MOV BX, 010D
		MOV AX, A
		MUL BX 
		ADD AX, B 
		MOV A, AX
		MOV AH, 1
		INT 21H
		MOV AH,0
		MOV BX, AX
		JMP WHILE1
		
	FIM1: NOP
		PUSH A
		PUSH ENDRETORNO
		RET
leitura ENDP	

;-----------------------------------------------------------------------

preparacaoescrita PROC
		POP ENDRETORNO
		POP A
		
		MOV BX,0
		MOV BX, A
		MOV AX, 0
		MOV AX, A
	WHILE2:
		MOV BX, AX
		CMP BX, 00D
		JE FIM2
		MOV BX, 010D
		MOV DX, 0
		DIV BX
		PUSH DX
		MOV BX, AX
		INC CONT	
		JMP WHILE2
		
	FIM2:NOP
		PUSH CONT
		PUSH ENDRETORNO 
		RET
preparacaoescrita ENDP

;----------------------------------------------------------------------------
escrita PROC
		POP ENDRETORNO
		POP CONT
		SUB CONT, 01D     
		MOV AX, CONT 
		MOV BX, 3 
		SUB BX, AX
		MOV CONTESPACO, BX
		MOV AX, 0
		MOV BX, 0      
    WHILEESPACO:
        MOV CX, 0
        CMP CX, CONTESPACO
        JNLE FIMWHILEESPACO
        MOV AH, 2
		MOV DX, 30H
		
		INT 21H
        
        DEC CONTESPACO
        JMP WHILEESPACO
        
    FIMWHILEESPACO:NOP
		
		
	WHILE3:
		MOV CX, 0
		CMP CX, CONT
		JNLE FIM3
		  
		  
		  
		POP AX
		ADD AX, 048D
		
		MOV AH, 2
		MOV DX, AX
		
		INT 21H
		DEC CONT
		
	JMP WHILE3

	FIM3: NOP

		PUSH ENDRETORNO
		RET
escrita ENDP
;----------------------------------------------------------------------------
pularlinha PROC
		;PULA LINHA
    MOV AH, 2
    MOV DX, 13
    INT 21H
    MOV dx,10
    MOV ah,2
    INT 21h
    	;FIM PULA LINHA 	
	RET
pularlinha ENDP
;----------------------------------------------------------------------------
espaco PROC
		;PULA LINHA   
	;MOV AH, 2
    ;MOV dx, 3
    ;INT 21H
	MOV AH, 2
    MOV dx, 32
    INT 21H
    	;FIM PULA LINHA 	
	RET
espaco ENDP
;----------------------------------------------------------------------------
lertamvet PROC
	MOV AH, 1
	INT 21H
	MOV AH,0
	MOV BX, AX
	PUSH BX
	CALL leitura
	POP tamvet
	RET
lertamvet ENDP
;----------------------------------------------------------------------------    
quicksortNgrande PROC
    POP ENDRETORNO  
    POP AX ;ESQ
    POP BX ;DIR   
        
    CMP CTRLEND1, 1D
    JE FIMCRTLEN5
       MOV CX, ENDRETORNO
       MOV ENDF1, CX 
       MOV CTRLEND1, 1D
    FIMCRTLEN5:NOP     
    
    PUSH ENDRETORNO  
    
    MOV pivoordenacao, AX
    ADD pivoordenacao, BX   
    PUSH BX
    PUSH AX
    MOV BX, 0
    MOV BX, 2
    MOV DX, 0 
    MOV AX, pivoordenacao
    DIV BX 
    
    MUL BX             
    MOV pivoordenacao, AX   
    
    
    MOV AX, 0
    MOV BX, 0 
    
    MOV SI, pivoordenacao   
    MOV pivoordenacao, AX
    MOV AX, VET[SI]
    MOV pivoordenacao, AX
    
    
    
                 
    POP AX
    POP BX    
    
    MOV I, AX ;ESQ
    MOV J, BX ;DIR
    MOV DX,0
    MOV SI, 0
    MOV DI, 0
    WHILEORD5:
        MOV CX, J
        CMP I, CX
        JNBE FIMWHILEORD5
        
        WHILEORD6: 
            PUSH BX
            PUSH AX
            
            CALL MULTSI1
            POP AX
            POP BX 
            CMP VET[SI], DX
            JNl FIMWHILEORD6
           INC COMPORD
            INC I
            
            JMP WHILEORD6
        FIMWHILEORD6:NOP   
        WHILEORD7:   
            PUSH BX
            PUSH AX
            
            MOV BX, 2
            MOV AX, 0
            MOV DX, 0
            MOV AX, J
            MUL BX
            MOV SI,AX
            MOV DX, 0
            MOV DX, pivoordenacao
            POP AX
            POP BX 

            CMP VET[SI], DX
            JBE FIMWHILEORD7
            INC COMPORD
              DEC J
            JMP WHILEORD7
        FIMWHILEORD7:NOP
        
        MOV CX, J
        CMP I,CX
        JNBE FIMIFORD8      
        
            PUSH BX
            PUSH AX
            
            CALL MULT 
                       
            POP AX
            POP BX 
        

            MOV DX, VET[SI] 
            PUSH AX
            MOV AX, VET[DI]
			MOV VET[SI], AX
			MOV VET[DI], DX
			POP AX
			MOV DX, 0D  
			INC TROCAS  
			INC I

			DEC J

           
        FIMIFORD8:NOP
        
      JMP WHILEORD5 
    FIMWHILEORD5:NOP
    
     
     
     CMP AX, J
     JNB FIMFIM3
        PUSH I
        PUSH BX   
        PUSH J
        PUSH AX
        
        CALL quicksortNGRANDE
        POP BX
        POP I  

     FIMFIM3:NOP  
     
     CMP I, BX
     JNB FIMFIM4
        PUSH AX
        PUSH J 
        PUSH BX
        PUSH I  
        
        CALL quicksortNGRANDE
        
        POP AX
        POP J  
        
     FIMFIM4:NOP
     
         
      

      ;PUSH ENDRETORNO


      RET 
quicksortNgrande ENDP

MULT PROC
     MOV BX, 2
            MOV AX, 0
            MOV DX, 0
            MOV AX, I
            MUL BX
            MOV SI,AX  
            MOV AX, 0
            MOV DX, 0
            MOV AX, J
            MUL BX
            MOV DI,AX
    RET
ENDP 

MULTSI1 PROC
      MOV BX, 2
            MOV AX, 0
            MOV DX, 0
            MOV AX, I
            MUL BX
            MOV SI,AX
            MOV DX, 0
            MOV DX, pivoordenacao
    
    RET
ENDP
   
    
;----------------------------------------------------------------------------
escrevervetor PROC  
    CALL PULARLINHA  
   CALL PONTAESQUERDA
WHILEDISPLAY: 
    MOV CX, tamexibicao
	CMP C, CX
	JNL WHILEDISPLAYFIM    
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL 
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL 
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTALCRUZ
	INC C   
	JMP WHILEDISPLAY
WHILEDISPLAYFIM:NOP 
CALL PULARLINHA 
MOV C, 0
WHILE92: 
    MOV CX, TAMEXIBICAO
	CMP C, CX
	JNL FIM92
	MOV BX, C
	MOV AX, VET[DI]
	PUSH AX
	CALL preparacaoescrita
	POP CONT
	PUSH CONT    
	
	CALL tracovertical
	CALL espaco
	CALL escrita
	CALL espaco 
	
	MOV AX, 0
	MOV CONT, AX  
	INC DI
	INC DI
	INC C
	JMP WHILE92
FIM92:NOP
CALL tracovertical 
CALL PULARLINHA  
CALL PONTAESQUERDABAIXO
MOV C, 0
WHILEDISPLAY1: 
    MOV CX, tamexibicao
	CMP C, CX
	JNL WHILEDISPLAYFIM1    
  
	
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL 
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTAL
	CALL TRACOHORIZONTAL   
	CALL TRACOHORIZONTALCRUZBAIXO
	   
	
	INC C   
	JMP WHILEDISPLAY1
WHILEDISPLAYFIM1:NOP
	RET
escrevervetor ENDP  
;----------------------------------------------------------------------------
zerarvariaveis PROC
    MOV AX, 0
	MOV A, AX
	MOV B, AX
	MOV C, AX
	MOV I, AX
	MOV J, AX  
	MOV DI, AX
	MOV SI, AX
	MOV ENDRETORNO, AX
    RET
zerarvariaveis ENDP       
;-----LerVetorINICIO----------
lervetor PROC
    
      WHILE91:  
    MOV CX, tamvet
	CMP C, CX
	JNL FIM91
	
	MOV AH, 1
	INT 21H
	MOV AH,0
	MOV BX, AX
	PUSH BX
	CALL leitura
	POP AX
	MOV VET[DI], AX
	INC DI   
	INC DI
	INC C
	CALL pularlinha
	JMP WHILE91
FIM91:NOP

RET
    lervetor ENDP
;lervalordeBusca-------------------------------------------------------------------------               
lervalorbusca PROC
	MOV AH, 1
	INT 21H
	MOV AH,0
	MOV BX, AX
	PUSH BX
	CALL leitura
	POP valorbusca
	RET
lervalorbusca ENDP
;---------------------------------------------------------------------------------------
lertipodepreenchimento PROC
	MOV AH, 1
	INT 21H
	MOV AH,0
	MOV BX, AX
	PUSH BX
	CALL leitura
	POP tipopreenchimento
	RET
lertipodepreenchimento ENDP
;---------------------------------------------------------------------------------------
ordenado PROC
        MOV CX, 1  
        MOV DI, 0  
             
    
    WHILEPREEORDENADO:        
        CMP CX, tamvet
        JNLE FIMWHILEPREEORDENADO
           MOV VET[DI], CX 
        INC DI
        INC DI  
        INC CX
        JMP WHILEPREEORDENADO
        FIMWHILEPREEORDENADO:
    RET 
ordenado ENDP
;---------------------------------------------------------------------------------------
invordenado PROC
        MOV CX, tamvet 
        MOV DI, 0
    WHILEPREEINVORDENADO:        
        CMP CX, 0
        JE INVFIMWHILEPREEORDENADO
           MOV VET[DI], CX 
        INC DI
        INC DI  
        DEC CX
        JMP WHILEPREEINVORDENADO
        INVFIMWHILEPREEORDENADO:
    RET 
invordenado ENDP     
;-----------------------------------------------------------
geranrandom PROC 
    INC CONTAL
    MOV AX, semente
    MOV BX, tamvet
    SUB BX, CONTAL 
    CMP BX, 0
    JNE FIMTRE1
     MOV CONTAL, 1D   
     INC BX
    FIMTRE1:NOP 
    MOV DX, 0
    IDIV BX  
    
    CMP DX, 0
    JNE FIMRANDOM
      ADD DX, CONTAL
      INC CONTAL
    FIMRANDOM:NOP
   
      
    POP ENDRETORNO
    CMP DX, 29999
    JLE FIMOVERFLOWRANDOM
        MOV AX, 30000
        SUB AX, DX
        SUB DX, AX
        
    FIMOVERFLOWRANDOM:NOP
    
    PUSH DX     
    PUSH ENDRETORNO
       
    INC SEMENTE 

    RET
geranrandom ENDP  

;-----------------------------------------------------------------------  
aleatorio PROC
    MOV CX, 1  
    MOV DI, 0   
    
    MOV AH, 2CH
    INT 21H
    MOV AH, 0
    MOV DH, 0  
    MOV CX, 1      
    MOV semente, DX
    WHILEPREEALEATORIO:        
        CMP CX, tamvet
        JNLE FIMWHILEPREEALEATORIO 
            PUSH CX     
            CALL geranrandom
            POP BX 
            POP CX
            MOV VET[DI], BX 
        INC DI
        INC DI  
        INC CX
        JMP WHILEPREEALEATORIO
        FIMWHILEPREEALEATORIO:
    
    
    RET
aleatorio ENDP       
 quicksort PROC
    POP ENDRETORNO  
    POP AX ;ESQ
    POP BX ;DIR   
        
    CMP CTRLEND1, 1D
    JE FIMCRTLEN2
       MOV CX, ENDRETORNO
       MOV ENDF1, CX 
       MOV CTRLEND1, 1D
    FIMCRTLEN2:NOP     
    
    PUSH ENDRETORNO  
    
    MOV pivoordenacao, AX
    ADD pivoordenacao, BX   
    PUSH BX
    PUSH AX
    MOV BX, 0
    MOV BX, 2
    MOV DX, 0 
    MOV AX, pivoordenacao
    DIV BX              
    MOV pivoordenacao, AX   
        
    CMP AX, 1D
    JNE FIMTB5
       ADD AX, 1D
       MOV pivoordenacao, AX
    FIMTB5:NOP
    MOV DX, 0
    DIV BX
    CMP DX, 1
    JNE FIMTB6
      MOV AX, pivoordenacao
      ADD AX, 1
      MOV pivoordenacao, AX
    FIMTB6:NOP
    
    
    MOV AX, 0
    MOV BX, 0 
    
    MOV SI, pivoordenacao   
    MOV pivoordenacao, AX
    MOV AX, VET[SI]
    MOV pivoordenacao, AX
                 
    POP AX
    POP BX    
    
    MOV I, AX ;ESQ
    MOV J, BX ;DIR
    MOV DX,0
    MOV SI, 0
    MOV DI, 0
    WHILEORD1:
        MOV CX, J
        CMP I, CX
        JNLE FIMWHILEORD1
        
        WHILEORD2:
            MOV DX, pivoordenacao 
            MOV SI, I
            CMP VET[SI], DX
            JNL FIMWHILEORD2
            INC COMPORD
            INC I
            INC I
            JMP WHILEORD2
        FIMWHILEORD2:NOP   
        WHILEORD3:
            MOV DX, pivoordenacao 
            MOV SI, J
            CMP VET[SI], DX
            JLE FIMWHILEORD3
            INC COMPORD
            DEC J
            DEC J
            JMP WHILEORD3
        FIMWHILEORD3:NOP
        
        MOV CX, J
        CMP I,CX
        JNLE FIMIFORD1
            MOV SI, I
            MOV DX, VET[SI] 
            MOV DI, J 
            PUSH AX
            MOV AX, VET[DI]
			MOV VET[SI], AX
			MOV VET[DI], DX
			POP AX
			MOV DX, 0D  
			INC TROCAS  
			INC I
			INC I
			DEC J
			DEC J
           
        FIMIFORD1:NOP
        
      JMP WHILEORD1 
    FIMWHILEORD1:NOP
    
     
     
     CMP AX, J
     JNL FIMFIM1
        PUSH I
        PUSH BX   
        PUSH J
        PUSH AX
        
        CALL quicksort
        POP BX
        POP I  

     FIMFIM1:NOP  
     
     CMP I, BX
     JNL FIMFIM2
        PUSH AX
        PUSH J 
        PUSH BX
        PUSH I  
        
        CALL quicksort
        
        POP AX
        POP J  
        
     FIMFIM2:NOP
     
         
      

      ;PUSH ENDRETORNO

      RET 
quicksort ENDP
;--MENSAGENS INCIO---------------------------------------------------------------------        
      
exmsg1 PROC
	MOV AH,9 
    MOV DX, offset msg1
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg1 ENDP

exmsg2 PROC
	MOV AH,9 
    MOV DX, offset msg2
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg2 ENDP 
exmsg3 PROC
	MOV AH,9 
    MOV DX, offset msg3
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg3 ENDP 
exmsg4 PROC
	MOV AH,9 
    MOV DX, offset msg4
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg4 ENDP  

exmsg5 PROC
	MOV AH,9 
    MOV DX, offset msg5
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg5 ENDP 
exmsg6 PROC
	MOV AH,9 
    MOV DX, offset msg6
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg6 ENDP 
exmsg7 PROC
	MOV AH,9 
    MOV DX, offset msg7
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg7 ENDP  
exmsg8 PROC
	MOV AH,9 
    MOV DX, offset msg8
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg8 ENDP 
exmsg9 PROC
	MOV AH,9 
    MOV DX, offset msg9
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg9 ENDP 
exmsg10 PROC
	MOV AH,9 
    MOV DX, offset msg10
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg10 ENDP  
exmsg11 PROC
	MOV AH,9 
    MOV DX, offset msg11
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg11 ENDP  
exmsg12 PROC
	MOV AH,9 
    MOV DX, offset msg12
    INT 21H
    MOV AH, 0
    MOV DX, 0
	RET
exmsg12 ENDP 
tracohorizontal PROC
    MOV AH,2
    MOV DX, 0C4H
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
tracohorizontal ENDP  
tracohorizontalcruz PROC
    MOV AH,2
    MOV DX, 0C2H
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
tracohorizontalcruz ENDP 
tracohorizontalcruzbaixo PROC
    MOV AH,2
    MOV DX, 0C1H
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
tracohorizontalcruzbaixo ENDP

pontaesquerda PROC
    MOV AH,2
    MOV DX, 0DAH
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
pontaesquerda ENDP     
pontadireita PROC
    MOV AH,2
    MOV DX, 0BFH
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
pontadireita ENDP 
pontadireitabaixo PROC
    MOV AH,2
    MOV DX, 0D9H
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
pontadireitabaixo ENDP  
pontaesquerdabaixo PROC
    MOV AH,2
    MOV DX, 0C0H
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
pontaesquerdabaixo ENDP   
tracovertical PROC
    MOV AH,2
    MOV DX, 0b3H
    INT 21H
    MOV AH, 0
    MOV DX, 0
    
    RET
tracovertical ENDP 

END