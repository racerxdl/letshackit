---
title: "Fonte 3v3 do FPGA | Lets Hack It"
description: "Arrumei a placa de FPGA Xilinx substituindo o regulador de 3.3V queimado por um modelo mais robusto. Veja o resultado."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Fonte 3v3 do FPGA

Escrito por Lucas Teske   
em 13 Outubro 2011

Bom, alguns talvez lembrem que um pouco antes do Flisol de Salto uma das minhas placas de Desenvolvimento Xilinx Spartan 3A Evaluation Kit parou de funcionar. Descobri que era o regulador de 3.3V da placa que havia queimado (bom, eu meti em curto várias vezes sem querer, apesar de ele ter proteção, nunca é a prova de falhas). Por sorte eu tinha outra e pude apresentar o projeto.

Mas ontem resolvi arrumar a placa de algum jeito. Infelizmente o regulador 3.3V apesar de não ser caro, tem algo em torno de 2mm² &nbsp;e é em QFN, um SMD que os pinos dele são em baixo do chip.

Ou seja, era um mísero quadrado minúsculo que mesmo que tivesse seus pinos para o lado seria quase humanamente impossível de soldar. Então resolvi apelar. Tinha um Regulador de 3.3V 3A aqui num canto, uma placa boa e bem feita (vinda da China) e resolvi ligar no lugar do regulador 3.3V.

Não ficou tão bonito, mas está funcionando perfeitamente, e agora tenho um regulador mais robusto também de 3.3V para o que eu precisar:

![image](https://media.tumblr.com/tumblr_lt0oi5atqO1qh7srd.jpg)

## Cite este artigo

### Citação sugerida

Lucas Teske. “Fonte 3v3 do FPGA.” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/10/fonte-3v3-do-fpga/](https://lucasteske.dev/pt/2011/10/fonte-3v3-do-fpga/).

### BibTeX

```
@misc{teske2011fonte3v3dofpga,
  author = {Lucas Teske},
  title = {Fonte 3v3 do FPGA},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/10/fonte-3v3-do-fpga/}
}
```
