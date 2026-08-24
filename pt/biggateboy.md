---
title: "Gameboy Gigante | Lets Hack It"
description: "Um experimento aberto de Game Boy em FPGA, construído em torno de um Lattice ECP5, uma CPU em Verilog e seis painéis de LED submetidos a engenharia reversa."
image: "https://lucasteske.dev/assets/lyd6168/20201029_001922.jpg"
---

Escrito por Lucas Teske   
em 16 Janeiro 2021

# Gameboy Gigante

Um experimento aberto em FPGA que reconstrói o Game Boy em lógica programável e mira em uma gloriosa tela gigante de seis painéis.

Hardware aberto · FPGA · Verilog
## Game Boy, reconstruído porta por porta.

O Big Gate Boy explora uma CPU compatível com Game Boy em Verilog para um Lattice ECP5, tendo seis painéis de LED como tela gigante. O código, os testes, as lives e a engenharia reversa dos painéis estão reunidos aqui.

[Explorar o código](https://github.com/racerxdl/biggateboy/)[Assistir à construção](https://www.youtube.com/playlist?list=PLEP_M2UAh9q7uSd0U_beeeF6FGvOSb_zy)

 ![Game Boy graphics running across a large LED panel](/assets/lyd6168/20201029_001922.jpg)

1. [CPU e mapa de opcodes](/pt/biggateboy/microcode)
2. [Testes em Assembly](https://github.com/racerxdl/biggateboy/tree/main/testdata)
3. [Engenharia reversa dos painéis](/pt/lyd6168)
4. Meta: tela de seis painéis

Referência do processador
### CPU e mapa de instruções

Consulte as convenções de opcode, grupos de registradores, operações da ALU e o mapa de instruções usados na implementação.

[Abrir a referência de microcódigo](/pt/biggateboy/microcode)

Hardware da tela
### Pesquisa sobre os painéis LYD6168

Acompanhe a investigação que identificou os painéis LYD6168 sem documentação como hardware compatível com o MBI5153.

[Ler a investigação dos painéis](/pt/lyd6168)

Construído em público
### Sessões de desenvolvimento

Veja o projeto tomar forma nas lives gravadas, do trabalho na CPU aos experimentos com o hardware.

[Abrir a playlist no YouTube](https://www.youtube.com/playlist?list=PLEP_M2UAh9q7uSd0U_beeeF6FGvOSb_zy)

Código aberto
### Verilog, testes e ferramentas

Explore os módulos da CPU, test benches da ALU e do banco de registradores, testes em Assembly, constraints e ferramentas de build.

[Ver o repositório](https://github.com/racerxdl/biggateboy/)

- [Identificar e testar o controlador](/pt/lyd6168/testing-ic)Um caminho passo a passo pelo software do fabricante e pelo processo de detecção do CI controlador.
- [Alterar o firmware FPGA da placa receptora](/pt/lyd6168/upgrade-fpga)Notas para carregar o firmware com suporte a S-PWM exigido por estes painéis.
- [Datasheet do controlador MBI5153](/assets/lyd6168/MBI-MBI5153GP_C183654.pdf)A referência que tornou compreensível o comportamento do LYD6168.

Estado do projeto

Este é um projeto realmente em andamento. As notas da CPU, o código, os testes e a pesquisa dos painéis estão publicados como existem; a documentação de temporização ainda incompleta não é apresentada como pronta.
