	    .data
u_word:     .asciiz
            "Alpha ","Bravo ","China ","Delta ","Echo ","Foxtrot ",
            "Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ",
            "Mary ","November ","Oscar ","Paper ","Quebec ","Research ",
            "Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ",
            "Yankee ","Zulu "
uw_offset:  .word
            0,7,14,21,28,34,43,49,56,63,71,
            77,83,89,99,106,113,121,131,
            139,146,155,163,171,178,186
l_word:     .asciiz
            "alpha ","bravo ","china ","delta ","echo ","foxtrot ",
            "golf ","hotel ","india ","juliet ","kilo ","lima ",
            "mary ","november ","oscar ","paper ","quebec ","research ",
            "sierra ","tango ","uniform ","victor ","whisky ","x-ray ",
            "yankee ","zulu "
lw_offset:  .word
            0,7,14,21,28,34,43,49,56,63,71,
            77,83,89,99,106,113,121,131,
            139,146,155,163,171,178,186
number:     .asciiz
            "zero ", "First ", "Second ", "Third ", "Fourth ",
            "Fifth ", "Sixth ", "Seventh ","Eighth ","Ninth "
n_offset:   .word
            0,6,13,21,28,36,43,50,59,67

		.text
		.globl main
main: 		li $v0,12
		syscall
		sub $t0,$v0,63  #if input is '?'
		beqz $t0,exit
		sub $t0,$v0,48  
		slt $t1,$t0,$0  #if v0 < '0' set t1 = 1
		bnez $t1,others
		# if input is a number
		sub $t0,$v0,58
		slt $t1,$t0,$0  #if v0 <= '9' set t1 = 1
		bnez $t1,getnum
		# if input is ABCD...
		sub $t0,$v0,64
		sgt $t1,$t0,$0  #if v0 >= 'A' set t1 = 1
		sub $t2,$v0,91 
		slt $t3,$t2,$0  #if v0 <= 'Z' set t3 = 1
		and $t4,$t1,$t3
		bnez $t4,getuword
		#if input is abcd...
		sub $t0,$v0,96
		sgt $t1,$t0,$0
		sub $t2,$v0,123
		slt $t3,$t2,$0
		and $t4,$t1,$t3
		bnez $t4,getlword
		j others

getnum: 	sub $t0,$v0,48
		sll $t0,$t0,2
		la $t1,n_offset
		add $t1,$t1,$t0
		lw $t2,($t1)
		la $a0,number
		add $a0,$a0,$t2
		li $v0,4
		syscall
		j main
		
getuword:	sub $t0,$v0,65
		sll $t0,$t0,2
		la $t1,uw_offset
		add $t1,$t1,$t0
		lw $t2,($t1)
		la $a0,u_word
		add $a0,$a0,$t2
		li $v0,4
		syscall
		j main
	
getlword:	sub $t0,$v0,97
		sll $t0,$t0,2
		la $t1,lw_offset
		add $t1,$t1,$t0
		lw $t2,($t1)
		la $a0,l_word
		add $a0,$a0,$t2
		li $v0,4
		syscall
		j main
		
others:		and $a0,$0,$0
		add $a0,$a0,42
		li $v0,11
		syscall
		j main		

exit:		li $v0,10
		syscall
