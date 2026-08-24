---
title: "Rodando código em uma máquina de cartão - TOSCONF[6]"
---

TOSCONF[6]

 \>\_ 28/03/2026 

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

Aviso legal / Disclaimer / Descargo de responsabilidad

As apresentações destinam-se apenas a fins educacionais e não substituem o julgamento profissional independente. As declarações de fato e opiniões aqui expressas são de total responsabilidade dos participantes e não representam a opinião ou posição do LHC. Os participantes devem observar que as sessões podem ser gravadas em áudio ou vídeo e podem ser publicadas em diversos meios.

The presentations are intended for educational purposes only and are not a substitute for independent professional judgment. The statements of fact and opinions expressed herein are solely the responsibility of the participants and do not represent the opinion or position of LHC.

Las presentaciones están destinadas únicamente a fines educativos y no sustituyen el juicio profesional independiente. Las declaraciones de hecho y las opiniones aquí expresadas son las de los participantes.

# Rodando código em uma máquina de cartão de crédito

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## quem sou eu

Engenheiro de software com 10+ anos de experiência.  
Ex Hardware Pentester na PRIDE Security, Game  
Engine Developer, e fundador da Teske Virtual System.  
Especialista em quebrar e proteger sistemas, desde  
hardware até software.

 ![Foto Lucas Teske](images/foto-lucas.jpg)
# Lucas Teske

### Hardware Deconstructor

### Teske Virtual System

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

# Rodando código em uma máquina de cartão de crédito

Uma jornada de um processo de engenharia reversa de uma máquina de cartão de crédito PAX D177 para rodar código customizado.

 ![Máquina D177 Customizada](images/slide5-maquina-doom.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## [!] DISCLAIMER

**Todos os procedimentos descritos aqui foram feitos com material disponível publicamente** - Nenhuma falha de segurança foi realmente explorada aqui para obter execução de código. A técnica de troca de processador não contorna as proteções contra violações nem permite que uma máquina falsa efetue pagamentos.

As máquinas de pagamento com cartão de crédito no Brasil geralmente estão no estado da arte em relação às medidas de segurança. Lembro-me uma vez que um funcionário da Elavon me disse que **o Brasil recebeu todos os primeiros lançamentos de máquinas e sistemas de pagamento.** Quando perguntei por que, ele disse: **as fraudes no Brasil são sofisticadas o suficiente, que se o sistema for seguro o suficiente para o Brasil, funciona em qualquer lugar do mundo.**

No futuro, farei um artigo sobre as medidas de segurança que tanto a MegaHunt, quanto a PAX e as empresas brasileiras implementam em suas máquinas para evitar que os sistemas sejam adulterados.

Se você estiver compartilhando / comentando sobre este artigo, por favor coloque o mesmo aviso de isenção de responsabilidade lá. Não me importo de usar as informações aqui para fazer novos artigos, mas o Brasil **sofre** muito com fakenews (especialmente envolvendo hardware de segurança feito aqui) e alguém pode pensar que isso torna possível hackear seus cartões de crédito ou contas.

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Primeiros trabalhos e Identificação de coisas

### Conseguir 3 dispositivos para testes [OK]

1. Vou abrir, e deixar todas proteções dispararem.
2. Vou usar para tentar bypassar todas proteções (caso seja meu objetivo)
3. Vou manter como está, para poder ter um modelo de referência para os estudos.

### O que era esperado: [FAIL]

- Segurança pesada 
  - - Proteção contra tamper
  - - Proteção contra clock-glitching
  - - Proteção contra manipulação de RNG
  - - Assinaturas de código
  - - Criptografia de Código

- Muita frustração

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Alvo

 ![Alvo Máquina PAX D177](images/alvo-pax-d177.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Tamper Points

 ![Tamper Traseira](images/tamper-traseira.jpg)

 ![Tamper Carcaça](images/tamper-carcaca.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Opsss

 ![Tela Switch EXT2/EXT3](images/opsss-tela.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

 ![Mesh In Place](images/meshinplace.jpg)

 ![Mesh Scan](images/meshscan.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

 ![Maquina](images/machine.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

 ![Macro PCB](images/pcb-macro.jpg)

## O que importa pra gente

- **MH1903** - Nosso principal SoC (CPU)
- **NXP 8035S** - PHY de Interface de SmartCard
- **FM17660** - Leitor NFC
- **XM25Q65** - Memória Flash SPI de 16MB

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## A CPU da máquina

 ![Diagrama MH190x](images/mh190x-diagrama.jpg)

 ![Chip MH1903](images/chip-mh1903.jpg)

 ARM Cortex M4F (Especificação SC300)  
 1MB de RAM  
 1MB de Flash  
// Datasheets incompletos, SDKs incompletas espalhadas pela internet

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Irmão "Arduino-like"

 ![Placa AIR105](images/air105-aliexpress.jpg)

 ARM Cortex M4F (Especificação SC300)  
 640KB de RAM  
 4MB de Flash  
// Datasheets incompletos, SDKs incompletas espalhadas pela internet

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Decaps

 ![Microscópio AIR105](images/decaps-air105.jpg) ![Microscópio AIR105](images/decaps-air105-2.jpg)

### AIR105

 ![Microscópio MH1903](images/decaps-mh1903.jpg)

### MH1903

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Descobrindo como as coisas estão conectadas

\> Descobrir onde está a UART ou JTAG/SWD

1. Tirar todos componentes da PCB
2. Escanear a PCB (com scanner doméstico)
3. Mapear os pinos da CPU
4. Seguir as trilhas

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Descobrindo como as coisas estão conectadas

 ![QFN88J](images/qfn88j.jpg)

 ![Trilhas QFN88J](images/trilhasqfn.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Descobrindo como as coisas estão conectadas

 ![UART](images/uart.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

# Trocar CPU ou achar vulnerabilidade?

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Trocando CPU

 ![Anúncio MH1903](images/chip-qixinruite.jpg)

 ![Solda na PCB](images/pcb-solda.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

 ![Trilha da Bateria](images/vbat-trilha.jpg)

[Caminho da bateria moeda para o MH1903]

Para gravar o MH1903, é preciso resetar ele para entrar no bootloader. Um dos jeitos é retirar temporariamente a tensão da bateria moeda causando um soft-tamper.

 ![Tabela Datasheet VBAT33](images/datasheet-vbat.jpg)

Em chinês: Alimentação da bateria, precisa ser energizado caso contrário não funciona.

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

 ![Log Terminal Gravado com Sucesso](images/log-terminal.jpg)

\> Dispositivo gravado com sucesso :)

 ![Fios UART Soldados](images/fios-uart.jpg)

[Fios para expor a UART e o "Reset"]

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

 ![Crasharalho](images/crasharalho.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## MAGIC STUFF

\> Algumas coisas foram omitidas para simplicidade:

- Foi feita engenharia reversa na firmware original do dispositivo e também na bootrom para descobrir os "periféricos ocultos" do MH1903 que controlavam a tela.
- Foi criado um emulador para fazer um trace do que a firmware acessava ou usava.
- A parte da criação do código. Ela é bem simples pois o LCD é um ST7735 rodando via SPI, algo comum para projetos arduino.
- Em breve novidades sobre a engenharia reversa :D
- E OBVIAMENTE, em breve, DOOM no mesmo dispositivo!

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

## Spoilers

 ![MHEmu Emulador](images/mhemu-emulador.jpg)

 ![MHEmu Emulador](images/mhemu-emulador-crasharalho.jpg)

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL

TOSCONF[6]  

\>\_ 28/03/2026

# Perguntas?

## \> entre em contato

# Lucas Teske

in/lucas-teske-8206301b | lucas@teske.com.br

 ![Crasharalho Gambiconf](images/crasharalho-gambiconf.jpg)

 ![QR Code Link](images/qr-code-lucas.png)

https://lucasteske.dev

Podcast Gambiconf:

 ![QR Code GambiConf](images/qrcodegambiconf.jpg)

# Obrigado pela sua atenção

tosconf.lhc.net.br | @lhc

root@lhc:~# LABORATÓRIO HACKER DE CAMPINAS - DESCONFERÊNCIA ANUAL
