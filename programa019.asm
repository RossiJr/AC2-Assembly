.text
.globl main
j main

multiplicar:
#a0 -> multiplicado
#a1 -> multiplicador

or $t1, $a1, $zero				#copia o valor do argumento 1 para registrador temporario
or $t2, $zero, $zero				#resultado

forMultiplicar:
beq $t1, $zero, finalForMultiplicar		#caso o multiplicador seja 0, encerra o loop
add $t2, $t2, $a0				#adiciona o multiplicado ao resultado
add $t1, $t1, -1				#decrementa um do multiplicador
j forMultiplicar
finalForMultiplicar:

or $v0, $zero, $t2				#copia o valor do retorno para variavel de retorno
jr $ra

main:
#Inicializa o registrador t0 para referenciar o primeiro endereco de memoria de .data
ori $t0, $zero, 0x1001
sll $t0, $t0, 16

lw $s0, 0($t0)					#le da memoria o valor de x
lw $s1, 4($t0)					#le da memoria o valor de y
ori $s2, $zero, 1				#valor de k inicializado com 0

beq $s1, $zero, fim				#retorna 1 para x^0

or $t1, $zero, $s1				#copia o valor de y para o temporario 1

or $a1, $zero, $s0				#copia o valor de x para a1, x nunca ira variar o valor
forExponencial:
beq $t1, $zero, fim				#caso o y esteja valendo 0, finaliza a execucao

or $a0, $zero, $s2				#copia resultado anterior para o a0
addi $sp, $sp, -8				#desce em 2 posicoes a pilha de alocacao
sw $t1, 8($sp)					#salva o valor de temporario 1 na pilha
sw $t2, 4($sp)					#salva o valor de temporario 2 na pilha

jal multiplicar

lw $t1, 8($sp)					#recupera o valor de t1 na pilha
lw $t2, 4($sp)					#recupera o valor de t2 na pilha
addi $sp, $sp, 8				#volta a pilha ao normal
or $s2, $zero, $v0				#salva o novo resultado em s2

addi $t1, $t1, -1				#decrementa em 1 o valor do y
j forExponencial

fim:
sw $s2, 8($t0)					#salva o resultado em k
.data
x: .word 9
y: .word 5
k: .word
