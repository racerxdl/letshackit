---
title: "Interruptor MIDI Polifônico com PIC 16F628A (Interface) | Lets Hack It"
description: "Monte um interruptor MIDI polifônico com PIC 16F628A. Veja a interface, código fonte e como cascatear microprocessadores."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Interruptor MIDI Polifônico com PIC 16F628A (Interface)

Escrito por Lucas Teske   
em 16 Outubro 2011

Neste tópico colocarei apenas como é a interface do interruptor descrito anteriormente.

![image](https://media.tumblr.com/tumblr_lt6aefLJaO1qh7srd.png)

Para um interruptor&nbsp;monofônico, ligamos o _Enable_&nbsp;em Vcc e ignoramos o _BUSY_. Para&nbsp;polifônicos, colocamos o _Enable_&nbsp;do primeiro no Vcc, e nos seguintes ligamos no _BUSY_&nbsp;do anterior. Nas saídas fazemos uma operação OR, e as entradas MIDI são ligadas todas juntas.

![image](https://media.tumblr.com/tumblr_lt6agxX4g21qh7srd.png)

O Gate OR pode ser&nbsp;substituído&nbsp;por dois diodos para esse uso sem problemas, como mostrado abaixo:

![image](https://media.tumblr.com/tumblr_lt6ahypyo11qh7srd.png)

Boa sorte na montagem!

Código fonte completo: [MIDI INT.rar](http://www.energylabs.com.br/el/pr/get.php?arquivo=1536)&nbsp;ou [Project Source](http://www.energylabs.com.br/el/documento/PIC:_Interruptor_MIDI_Polifonico?dir=Meus%20Documentos/PIC%20Interruptor%20MIDI%20Polifonico/src)

Créditos ao [Uzzors2k](http://uzzors2k.4hv.org/index.php?page=midiinterrupter)&nbsp;pela ideia de cascatear microprocessadores para polifonia.

## Cite este artigo

### Citação sugerida

Lucas Teske. “Interruptor MIDI Polifônico com PIC 16F628A (Interface).” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/10/interruptor-midi-polifonico-com-pic-16f628a-interface/](https://lucasteske.dev/pt/2011/10/interruptor-midi-polifonico-com-pic-16f628a-interface/).

### BibTeX

```
@misc{teske2011interruptormidipolifonicocompic16f62,
  author = {Lucas Teske},
  title = {Interruptor MIDI Polifônico com PIC 16F628A (Interface)},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/10/interruptor-midi-polifonico-com-pic-16f628a-interface/}
}
```
