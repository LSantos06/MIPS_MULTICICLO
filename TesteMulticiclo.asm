.data

a:	.word 15		# 1111
b:	.word 10		# 1010

.text

	lw $t1, a		# rt = 9, rs = endereco(a); t1 = 15
	
	lw $t2, b		# rt = 10, rs = endereco(b); t2 = 10
	
	sw $t1, b 		# rt = 9, rs = endereco(b); Mem[endereco(b)] = t1
	
	add $t3, $t1, $t2	# rs = 9, rt = 10, rd = 11; t3 = 25
	
	addi $t3, $t3, 1	# rt = 11, rs = 11; t3 = 26
	
	sub $t3, $t3, $t2	# rs = 11, rt = 10, rd = 11; t3 = 16
	
	and $t4, $t1, $t2	# rs = 9, rt = 10, rd = 12; t4 = 1010
	
	or $t5, $t1, $t2	# rs = 9, rt = 10, rd = 13; t5 = 1111
	
	nor $t6, $t1, $t2	# rs = 9, rt = 10, rd = 14; t6 = 1111 1111 1111 0000
	
	xor $t7, $t1, $t2	# rs = 9, rt = 10, rd = 15; t6 = 0101
	
	slt $s0, $t2, $t1	# rs = 10, rt = 9, rd = 16; s0 = 1
	
	j outro
	
prox:	beq $t6, $t6, fim	# rs = 14, rt = 14; fim
	
outro:	bne $t3, $t2, prox	# rs = 11, rt = 10; prox

fim:
	
	