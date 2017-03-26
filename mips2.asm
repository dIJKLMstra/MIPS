		.data
msg_s: 		.asciiz "\r\nSuccess!Location:"
msg_f:		.asciiz "\r\nFail!\r\n"
end:		.asciiz "\r\n"
buf:		.space  20

		.text
		.globl main
main:		la $a0,buf
		la $a1,20
		li $v0,8
		syscall
		
inputchar: 	li $v0,12
		syscall
		sub $t0,$v0,63
		beqz $t0,exit
		add $t0,$0,$0
		la $t1,buf

loop:		lb $t2,($t1)
		sub $t3,$v0,$t2
		beq $t3,$0,success
		addi $t0,$t0,1
		slt $t4,$t0,$a1
		beq $t4,$0,fail
		addi $t1,$t1,1
		j loop
		
success:	la $a0,msg_s
		li $v0,4
		syscall
		addi $a0,$t0,1
		li $v0,1
		syscall
		la $a0,end
		li $v0,4
		syscall
		j inputchar
		
fail:		la $a0,msg_f
		li $v0,4
		syscall
		j inputchar
		
exit:		li $v0,10
		syscall
