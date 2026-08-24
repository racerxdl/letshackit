---
title: "Início | Lets Hack It"
description: "October 16, 2011 Interruptor MIDI Polifônico com PIC 16F628A (Interface) Neste tópico colocarei apenas como é a interface do interruptor descrito anteriormente. Para um interruptor monofônico, ligamos o Enable em Vcc e ignoramos o BUSY. Para polifônicos, colocamos o Enable do primeiro no Vcc, e nos seguintes ligamos no BUSY do anterior. Nas saídas fazemos..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

October 16, 2011
# [Interruptor MIDI Polifônico com PIC 16F628A (Interface)](/pt/2011/10/interruptor-midi-polifonico-com-pic-16f628a-interface/)

Neste tópico colocarei apenas como é a interface do interruptor descrito anteriormente. Para um interruptor&nbsp;monofônico, ligamos o Enable&nbsp;em Vcc e ignoramos o BUSY. Para&nbsp;polifônicos, colocamos o Enable&nbsp;do primeiro no Vcc, e nos seguintes ligamos no BUSY&nbsp;do anterior. Nas saídas fazemos uma operação OR, e as entradas MIDI são ligadas todas juntas. O Gate OR pode ser&nbsp;substituído&nbsp;por dois diodos para esse uso sem problemas, como mostrado abaixo: Boa sorte na montagem! Código fonte completo: MIDI INT.rar&nbsp;ou Project Source Créditos ao Uzzors2k&nbsp;pela ideia de cascatear microprocessadores para polifonia.

October 16, 2011
# [Interruptor MIDI Polifônico com PIC 16F628A](/pt/2011/10/interruptor-midi-polifonico-com-pic-16f628a/)

– Introdução Bom, muitos sabem que eu fiz um Interruptor MIDI (ou sintetizador como preferir) com um FPGA. Porém poucos tem acesso a um FPGA principalmente para fazer algo tão \*simples\*, então resolvi fazer um com PIC 16F628A. No começo queria fazer com um PIC menor, mas os menores não tem Receptor Serial via hardware, então ficaria mais complicado implementar. Outro ponto, é que o preço dos PIC’s menores são praticamente os mesmos, então era só uma questão de espaço mesmo. Usando um PIC maior, fica mais espaço livre para futuras modificações caso seja necessário. O PIC 16F628A tem 2KB...

October 13, 2011
# [Amostra de Memória MRAM da Everspin](/pt/2011/10/amostra-de-memoria-mram-da-everspin/)

Há muito tempo atrás pedi amostras de uma memória magnética da Everspin&nbsp;para fazer testes aqui, porém depois me deparei com o problema de que ela é 3.3V. De qualquer maneira agora tenho um FPGA para brincar com ela. O modelo de amostra é a MR2A16AYS35, uma MRAM de 1M de endereço e 16 Bits de “palavra”, totalizando 16Mbit ou 2 Mbytes. MRAM é um acrônimo para&nbsp;Magneto-resistive Random Access Memory, que é uma memória RAM não-volátil&nbsp;(não perde os dados quando se desliga). Ela é considerada a chave para o futuro da computação, principalmente&nbsp;portátil. Com ela vem o conceito de “boot-instantâneo” onde...

October 13, 2011
# [Fonte 3v3 do FPGA](/pt/2011/10/fonte-3v3-do-fpga/)

Bom, alguns talvez lembrem que um pouco antes do Flisol de Salto uma das minhas placas de Desenvolvimento Xilinx Spartan 3A Evaluation Kit parou de funcionar. Descobri que era o regulador de 3.3V da placa que havia queimado (bom, eu meti em curto várias vezes sem querer, apesar de ele ter proteção, nunca é a prova de falhas). Por sorte eu tinha outra e pude apresentar o projeto. Mas ontem resolvi arrumar a placa de algum jeito. Infelizmente o regulador 3.3V apesar de não ser caro, tem algo em torno de 2mm² &nbsp;e é em QFN, um SMD que os...

October 13, 2011
# [Electronics Hacking](/pt/2011/10/electronics-hacking/)

Bom, decidi postar hacks de eletrônica aqui também. Até por que são mais&nbsp;frequentes&nbsp;que os meus hacks. Ai vai umas fotos de um sensor CMOS que soldei numa placa pra facilitar, e verei um dia de brincar com ela: É um Sensor CMOS VGA Colorido, que roda em 3.3V. A sua interface também é CMOS (muitas vezes o sensor é cmos, mas a interface é analógica) e como o nível de tensão é 3v3 é&nbsp;fácil&nbsp;de eu trabalhar com um FPGA. Devo ter tirado isso de uma webcam ou câmera de vigilância, não lembro. A resolução é 644×484 pixels, porém ela tem...
