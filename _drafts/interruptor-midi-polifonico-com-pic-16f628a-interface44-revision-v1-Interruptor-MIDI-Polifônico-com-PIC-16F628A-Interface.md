---
id: 115
title: Interruptor MIDI Polifônico com PIC 16F628A (Interface)
date: 2016-01-24T23:26:27-03:00
author: racerxdl
layout: revision
guid: http://www.teske.net.br/lucas/2016/01/44-revision-v1/
permalink: /2016/01/44-revision-v1/
---
Neste tópico colocarei apenas como é a interface do interruptor descrito anteriormente.

![image](https://media.tumblr.com/tumblr_lt6aefLJaO1qh7srd.png) 

Para um interruptor monofônico, ligamos o _Enable_ em Vcc e ignoramos o _BUSY_. Para polifônicos, colocamos o _Enable_ do primeiro no Vcc, e nos seguintes ligamos no _BUSY_ do anterior. Nas saídas fazemos uma operação OR, e as entradas MIDI são ligadas todas juntas.

<!--more-->

![image](https://media.tumblr.com/tumblr_lt6agxX4g21qh7srd.png) 

O Gate OR pode ser substituído por dois diodos para esse uso sem problemas, como mostrado abaixo:

![image](https://media.tumblr.com/tumblr_lt6ahypyo11qh7srd.png) 

Boa sorte na montagem!

Código fonte completo: <a href="http://www.energylabs.com.br/el/pr/get.php?arquivo=1536" target="_blank">MIDI INT.rar</a> ou [Project Source](http://www.energylabs.com.br/el/documento/PIC:_Interruptor_MIDI_Polifonico?dir=Meus%20Documentos/PIC%20Interruptor%20MIDI%20Polifonico/src)

Créditos ao [Uzzors2k](http://uzzors2k.4hv.org/index.php?page=midiinterrupter) pela ideia de cascatear microprocessadores para polifonia.