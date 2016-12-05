# MIPS_MULTICILO
### Projeto Final de Organizacão e Arquitetura de Computadores 2/2016

## Objetivo
Montar e simular uma versão do processador MIPS Muticilo, no ambiente *Quartus* / *ModelSim-Altera*.

<p align="center">
  <img src="mips_multiciclo.png">
  <br>
  <t><b>MIPS Multiciclo</b></t>
  <br>
</p>

## Descrição
O diagrama acima não suporta a execução de todas as instruções do MIPS. As instruções
básicas a serem implementadas são as seguintes:
  - [ ] LW;
  - [ ] SW;
  - [ ] ADD;
  - [ ] ADDi;
  - [ ] SUB;
  - [ ] SUBi;
  - [ ] AND;
  - [ ] NAND;
  - [ ] OR;
  - [ ] NOR;
  - [ ] XOR;
  - [ ] SLT;
  - [ ] J;
  - [ ] BEQ;
  - [ ] BNE.

As instruções adicionais a serem implementadas são as seguintes:
  - [ ] ORi;
  - [ ] ANDi;
  - [ ] SLL;
  - [ ] SRL;
  - [ ] BGEZ;
  - [ ] BLTZ;
  - [ ] SLTI;
  - [ ] JAL;
  - [ ] JR.

O processador deve ser simulado no *ModelSim* e implementado em *FPGA*. Neste caso, para verificação de seu funcionamento, deve-se observar o **PC**, o **RI**, o **RDM** e a **SaidaALU** através dos mostradores de 7 segmentos.

Para entrada e saída de dados deve-se utilizar:
 - Botão para acionar o relógio;
 - Mostrador de 7 segmentos para exibir conteúdo de **RI** e **SaidaALU**.
 
O **PC** deve ter 32 bits. A memória tem apenas 256 palavras de 32 bits, de forma que apenas 8 bits do **PC** devem ser utilizados no seu endereçamento. 

Para executar um programa gerado pelo *MARS*, devem ser carregados o código e os dados do programa.

Os endereços da área de dados devem ser mapeados para a região de memória que
começa no endereço **128** no *FPGA*. Assim, o endereço de dado deve ser gerado
concatenando os bits [8 dowto 2] do **SaidaALU** com o bit ‘1’ na
posição mais significativa: ‘1’ & alu_out(8 downto 2).

Um arquivo comprimido com todos os módulos VHDL do MIPS multiciclo é
disponibilizado no Moodle. O código MIPS a ser carregado na memória está contido no
arquivo **mem.mif**.

Para exibição dos dados nos mostradores, utilizar os acionadores de display de 7
segmentos feito na primeira aula de laboratório.

A verificação do processador consistirá na execução de programas gerados a partir do
MARS.

## Entrega
15 de dezembro. Apresentar o código VHDL simulando no *ModelSim* e
executando em *FPGA*.
