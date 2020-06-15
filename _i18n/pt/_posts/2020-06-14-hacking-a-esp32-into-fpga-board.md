---
title: Hackeando um ESP32 num FPGA
date: 2020-06-14T16:17:00-03:00
author: Lucas Teske
layout: post
guid: https://medium.com/@lucasteske/hacking-a-esp32-into-fpga-board-65a933cbaff
image: /assets/posts/medium/1_ALnLx9L06FSciqeEV5OCuQ.png
categories:
  - English
  - Hacking
  - Linux
  - FPGA
  - ESP32

tags:
  - Hacking
  - FPGA
  - ICEWolf
  - IceStick
  - ECP5
  - Lattice
  - ESP32
  - Colorlight

translated-by: Lucas Teske
---

# Hackeando um ESP32 num FPGA

No ano passado eu vi um cara russo que viu que essa placa barata (US$15) tinha um FPGA da Lattice ECP5, o qual é compatível com as toolchains opensource para síntese. Ele estava rodando um RISC-V dentro e enviando a saída serial pela rede usando uma das portas de rede. Eu queria conseguir uma e começar a brincar. Essas placas são relativamente baratas (mais ou menos US$15) e tem um FPGA da Lattice ( LFE5U-25F-6BG381C ), 4MB DRAM, duas portas gigabit e vários level shifters. Isso é bom por que:

1. É uma placa barata pelas especificações
2. Você pode usar uma toolchain opensource
3. Tem MUITOS level-shifter para 5V e eles são bi-direcionais.

Eu decidi tentar comprar uma do Aliexpress, mas por causa da pandemia do COVID-19, o pacote está super atrasado (ele ainda não chegou, mesmo 3 meses depois de ter pedido). Por sorte eu achei no Mercado Livre para vender por um preço razoável (R$220).

Quando chegou, eu tentei rodar o clássico Hello World para Hardware: O Led Blink. Para isso eu usei este projeto para testar: [https://github.com/antonblanchard/ghdl-yosys-blink](https://github.com/antonblanchard/ghdl-yosys-blink)

Eu fiz um fork e adicionei as configurações da placa e também a configuração para usar um adaptador FR232R no modo bitbang com o OpenOCD (por que era o único método possível de JTAG disponível no momento). [https://github.com/racerxdl/ghdl-yosys-blink](https://github.com/racerxdl/ghdl-yosys-blink)

Eu não precisei fazer engenharia reversa na placa pois já tinham feito: [https://github.com/q3k/chubby75/blob/master/5a-75b/hardware_V6.1.md](https://github.com/q3k/chubby75/blob/master/5a-75b/hardware_V6.1.md)

Como dá pra ver, os headers JTAG são de fácil acesso e todos os pinos estão mapeados. Excelente!

Depois de alguns minutos brincando com o ghdl-yosis-blink eu consegui fazer funcionar na minha placa. Porém ele ainda estava rodando na RAM do FPGA e eu queria gravar na memória flash. Então eu comecei a procurar pela internet alguma ferramente que conseguisse converter o bitstream para programar a memória flash. Depois de testar muitas ferramentas, eu achei uma simples que faz o trabalho: [https://github.com/f32c/tools/tree/master/ujprog](https://github.com/f32c/tools/tree/master/ujprog)

Só era nescessário rodar:

```bash
ujprog -d -j flash -s vhdl_blink-flash.svf vhdl_blink.bit
```

E o arquivo gerado vhdl_blink-flash.svf estava persistindo o bitstream na memoria flash.

<center>
  <blockquote class="twitter-tweet"><p lang="en" dir="ltr">After few days I managed to write thr SPI Flash using FT232H. Full <a href="https://twitter.com/hashtag/opensource?src=hash&amp;ref_src=twsrc%5Etfw">#opensource</a> stuff to program that board. Also only US$15. <a href="https://t.co/RujsOGwH1D">pic.twitter.com/RujsOGwH1D</a></p>&mdash; Cybernetic Lover (@lucasteske) <a href="https://twitter.com/lucasteske/status/1268616857583419393?ref_src=twsrc%5Etfw">June 4, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</center>

Agora que tudo estava funcionando, eu decidi ir para o hack maior: Eu queria um ESP32 ligado na placa e gravar o FPGA via rede. E também seria legal se eu conseguisse redirecionar uma porta serial para rede (bom para depurar).

A primeira coisa que fiz foi escolher um par de GPIO para ser o TX/RX da porta serial. O ESP32 tem três portas seriais, porém na minha placa apenas dois são expostos (Serial 0 e 2). A porta serial 0 está ligada ao conversor USB-Serial, então eu decidi usar a porta Serial 2 para comunicar com FPGA. Após olhar a pinagem da placa FPGA, eu vi que a maioria dos pinos dos level-shifters são comuns (as linhas de endereço são responsáveis pela metade dos pinos) e os level-shifters próximos da borda inferior da placa eram da linha de endereço. Depois de procurar um pouco, eu decidi remover o conector J4 da placa e o level-shifter U23 (o ESP32 é 3.3V, lembre-se disso!).

![U23 e J4 removidos](/assets/posts/medium/0_wK9QPXyVChE4n8py.jpeg)*U23 e J4 removidos*

Eu também decidi remover o J3 para facilitar a solda dos fios de bypass no conector. Então eu soldei todos fios para fazer o conector ser 3.3V ao invés de 5V.

![Fios soldados no U23](/assets/posts/medium/1_tT_gWmR6KPWXKKoewW-KDQ.png)*Fios soldados no U23*

Os resistores de 33 Ohm são bons, pois eles evitam curto-circuitos caso os pinos associados a porta serial estejam errados. Então decidi deixar eles como estão. Após checar que todos os pinos estavam ok e não estavam em curto, eu decidi usar cola quente para prender eles:

![Pedaços de cola quente](/assets/posts/medium/1_53DN-rC8MrNRfFdVmzN-Uw.png)*Pedaços de cola quente*

Eu sempre preferi usar um soprador térmico a 200ºC ao invés da pistola de cola quente. Isso também evita que eu super-aqueça a placa e os fios saiam.

![Soprador térmico e cola quente](/assets/posts/medium/1_7O77I22KdFxtNz4-G2cSeA.png)*Soprador térmico e cola quente*

Depois de esfriar os resultados ficaram bons!

![Cola quente e os fios de bypass](/assets/posts/medium/1_sCDf7DO_2mY2FoOTLN357Q.png)*Cola quente e os fios de bypass*

Então comecei a trabalhar na parte de trás da placa soldando o pair VCC/GND e o par TX/RX. Por sorte o conector de energia nessa placa aceita de 3.6V até 6V então eu posso usar o pino VIN do ESP32 (que está conectado aos +5V da porta USB) para alimentar a placa. O conector de energia também está perto do J4 que removemos.

![Conector de energia e porta serial](/assets/posts/medium/1_sADN_JL_MLf9TP5r7FVymQ.png)*Conector de energia e porta serial*

Então com uma fita dupla-face, prendi o ESP32 na placa e soldei os fios nos pinos certos.

![ESP32 preso com fita dupla-face e os fios soldados](/assets/posts/medium/1_86Ir5XIqvHCLbMsbWxs5MA.png)*ESP32 preso com fita dupla-face e os fios soldados*

Agora eu só precisava escolher os pinos para o JTAG e estaria pronto para o código! Depois de procurar quais pinos "seguros" eu poderia usar no ESP32, eu escolhi estes pinos:

* TDI => D33
* TDO => D32
* TCK => D27
* TMS => D26

E soldei do melhor jeito que pude.

![Pinos JTAG soldados](https://cdn-images-1.medium.com/max/2544/0_ERp9fzhTj8EL0i1G)

Eu também tive que soldar o pino GND do ESP32 no pino GND do JTAG (Eu tive um problema com FT232R que foi solucionado soldando o GND)

![Alimentação do JTAG](/assets/posts/medium/1_Ltxy34-3hHoAalgDOHqG7A.png)*Alimentação do JTAG*

![Fio GND soldado](/assets/posts/medium/1_Sae7vuGGrvCUuYZdOiGPVA.png)*Fio GND soldado*

Com todos os fios soldados, eu podia começar a brincar com software!

Primeiro eu tentei usar a função Remote Bitbang do OpenOCD, o qual conecta em um socket TCP e começa a emitir comandos de bitbang usando um caracter ASCII. Por alguma razão, eu não consegui fazer funcionar. Se você quiser tentar, esse foi o código rodando no ESP32:

```cpp
#include <WiFi.h>

const char* ssid     = "XX";
const char* password = "XX";

WiFiServer server(3335);

#define PIN_SRST 21
#define PIN_TDI 33
#define PIN_TDO 32
#define PIN_TCK 27
#define PIN_TMS 26
#define PIN_LED 2

void setup() {
    Serial.begin(115200);
    delay(10);

    pinMode(PIN_SRST, OUTPUT);
    pinMode(PIN_TDI, OUTPUT);
    pinMode(PIN_TDO, INPUT_PULLUP);
    pinMode(PIN_TCK, OUTPUT);
    pinMode(PIN_TMS, OUTPUT);
    pinMode(PIN_LED, OUTPUT);
    digitalWrite(PIN_SRST, HIGH);
    digitalWrite(PIN_TDI, HIGH);
    digitalWrite(PIN_TCK, LOW);
    digitalWrite(PIN_TMS, HIGH);
    digitalWrite(PIN_LED, HIGH);
    // We start by connecting to a WiFi network

    Serial.println();
    Serial.println();
    Serial.print("Connecting to ");
    Serial.println(ssid);

    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }

    Serial.println("");
    Serial.println("WiFi connected.");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
    server.begin();
}

void loop() {
    WiFiClient client = server.available();
    if (client) {                     // if you get a client,
        Serial.println("New Client.");  // print a message out the serial port
        while (client.connected()) {
            if (client.available()) {
                char c = client.read();
                switch (c) {
                    case 'B':
                      digitalWrite(PIN_LED, HIGH);
                      break;
                    case 'b':
                      digitalWrite(PIN_LED, LOW);
                      break;
                    case 'R':
                      client.print((digitalRead(PIN_TDO) == HIGH) ? '1' : '0');
                      break;
                    case 'Q':
                      break;
                    case '0':
                      digitalWrite(PIN_TMS, LOW);
                      digitalWrite(PIN_TDI, LOW);
                      digitalWrite(PIN_LED, LOW);
                      digitalWrite(PIN_TCK, LOW);
                      break;
                    case '1':
                      digitalWrite(PIN_TMS, LOW);
                      digitalWrite(PIN_TDI, HIGH);
                      digitalWrite(PIN_LED, LOW);
                      digitalWrite(PIN_TCK, LOW);
                      break;
                    case '2':
                      digitalWrite(PIN_TMS, HIGH);
                      digitalWrite(PIN_TDI, LOW);
                      digitalWrite(PIN_LED, LOW);
                      digitalWrite(PIN_TCK, LOW);
                      break;
                    case '3':
                      digitalWrite(PIN_TMS, HIGH);
                      digitalWrite(PIN_TDI, HIGH);
                      digitalWrite(PIN_LED, LOW);
                      digitalWrite(PIN_TCK, LOW);
                      break;
                    case '4':
                      digitalWrite(PIN_TMS, LOW);
                      digitalWrite(PIN_TDI, LOW);
                      digitalWrite(PIN_LED, HIGH);
                      digitalWrite(PIN_TCK, HIGH);
                      break;
                    case '5':
                      digitalWrite(PIN_TMS, LOW);
                      digitalWrite(PIN_TDI, HIGH);
                      digitalWrite(PIN_LED, HIGH);
                      digitalWrite(PIN_TCK, HIGH);
                      break;
                    case '6':
                      digitalWrite(PIN_TMS, HIGH);
                      digitalWrite(PIN_TDI, LOW);
                      digitalWrite(PIN_LED, HIGH);
                      digitalWrite(PIN_TCK, HIGH);
                      break;
                    case '7':
                      digitalWrite(PIN_TMS, HIGH);
                      digitalWrite(PIN_TDI, HIGH);
                      digitalWrite(PIN_LED, HIGH);
                      digitalWrite(PIN_TCK, HIGH);
                      break;
                    case 'r':
                    case 't':
                      // SRST=0, which confusingly means to *exit* reset (as /RESET and /TRST are active-low)
                      // We don't have a TRST connection, so 'r' and 't' do the same thing.
                      digitalWrite(PIN_SRST, HIGH);
                      //digitalWrite(PIN_CHIP_EN, HIGH);
                      break;
                    case 's':
                    case 'u':
                      // SRST=1 -- enter RESET state
                      // Likewise for 's' and 'u'.
                      digitalWrite(PIN_SRST, LOW);
                      //digitalWrite(PIN_CHIP_EN, LOW);
                      break;
                }
            }
        }
        Serial.println("Client disconnected");
    }
}
```

Ontem alguém me mandou um link que não era relacionado ao tópico, mas me fez encontrar essa biblioteca:
[**Lib(X)SVF - A library for implementing SVF and XSVF JTAG players**
*JTAG (IEEE 1149.1, aka "Boundary Scan") is a standard IC testing, debugging and programming port. SVF (Serial Vector…*www.clifford.at](http://www.clifford.at/libxsvf/)

Basicamente ela foi escrita pela mesma pessoa que fez a engenharia reversa do bistream dos FPGA ICE40 (e muitos outros) e era uma biblioteca para reproduzir arquivos SVF e XSVF. Foi bem simples implementar um programador usando o ESP32. Você apenas precisava implementar algumas funções e tudo funcionava.

Teve muito trabalho para deixar legal de usar, então eu não vou explicar em detalhes aqui. Porém o código fonte está disponível aqui: [https://github.com/racerxdl/esp32-rjtag](https://github.com/racerxdl/esp32-rjtag)

Você roda:

```bash
upload.py /dev/ttyUSB0 file.svf
```

E ele irá gravar o FPGA para você. Aqui está um video disso funcionando:

<center>
  <blockquote class="twitter-tweet"><p lang="en" dir="ltr">FINALLY. Now I can use the ESP32 as JTAG programmer for Lattice FPGA. Soon I will able to program through wifi and pipe a serial debug port as well. <a href="https://t.co/zs41v47BvU">pic.twitter.com/zs41v47BvU</a></p>&mdash; Cybernetic Lover (@lucasteske) <a href="https://twitter.com/lucasteske/status/1272019368617095173?ref_src=twsrc%5Etfw">June 14, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</center>

Eu também adicionei um comando para fazer o ESP32 mudar do modo de programação para o passthorugh serial. Desta maneira, após a gravação do FPGA, todas as chamadas serial seriam redirecionadas para o FPGA. Para testar eu fiz esse pequeno Hello World Serial:
[**racerxdl/fpga-serial-hello**](https://github.com/racerxdl/fpga-serial-hello)

O qual fica enviando a mensagem "Hello World" pela porta serial para sempre. E funciona!
Which basically keeps sending Hello World through the serial port forever.

![Saída do Hello World do FPGA](/assets/posts/medium/1_Z8RdW5i7NQh7KUEC5v5NFg.png)*Saída do Hello World do FPGA*

Meu próximo passo é fazer funcionar via rede. Vai ser muito bom poder gravar o FPGA via rede e usar a porta serial.
