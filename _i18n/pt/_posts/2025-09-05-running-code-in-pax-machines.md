---
title: 'Rodando código em uma máquina de cartão de crédito PAX (parte 1)'
date: 2025-09-05T16:30:00-03:00
author: Lucas Teske
layout: post
image: /assets/Running code in a PAX Credit Card Payment Machine/7383f9c5e7832856c90b25549fb08115_MD5.jpeg
categories:
  - Reverse Engineering
  - Payment Machines
tags:
  - Flash
  - PAX
  - Hardware Hacking
  - RE
  - Reverse Engineering
  - D177
  - D188
  - Minizinha
  - Moderninha
  - Smart
  - Sunmi
  - TecToy
  - Transire
  - Megahunt
  - MH1903
  - Air105
  - LuatOS

---

## Disclaimer

**Todos os procedimentos descritos aqui foram feitos com material disponível publicamente** - Nenhuma falha de segurança foi realmente explorada aqui para obter execução de código. A técnica de troca de processador **não contorna as proteções contra violações nem permite que uma máquina falsa efetue pagamentos.**

As máquinas de pagamento com cartão de crédito no Brasil _geralmente_ estão no estado da arte em relação às medidas de segurança. Lembro-me uma vez que um funcionário da Elavon me disse que **o Brasil recebeu todos os primeiros lançamentos de máquinas e sistemas de pagamento**. Quando perguntei por que, ele disse: **as fraudes no Brasil são sofisticadas o suficiente, que se o sistema for seguro o suficiente para o Brasil, funciona em qualquer lugar do mundo**.

No futuro, farei um artigo sobre as medidas de segurança que tanto a MegaHunt, quanto a PAX e as empresas brasileiras implementam em suas máquinas para evitar que os sistemas sejam adulterados.

Se você estiver compartilhando / comentando sobre este artigo, por favor coloque o mesmo aviso de isenção de responsabilidade lá. Não me importo de usar as informações aqui para fazer novos artigos, mas o Brasil sofre **muito** com fake news (especialmente envolvendo hardware de segurança feito aqui) e alguém pode pensar que isso torna possível hackear seus cartões de crédito ou contas (você sabe, pessoas sem conhecimento suficiente para realmente entender o que está envolvido).

### Notas iniciais

Este artigo está meio incompleto. Ainda vou publicar a engenharia reversa do boot rom e como criei um emulador para mapear melhor o que os firmwares fazem. Aqui eu apenas menciono brevemente que fiz um emulador e acho que isso merece seu próprio artigo. Vou atualizar esta nota inicial quando eles forem publicados.

Eu quero agradecer ao [Gutem](https://www.linkedin.com/in/gutem/) e ao [Penegui](https://www.instagram.com/penegui) por uma revisão técnica rápida do conteúdo do artigo, e a Pag, a qual deu uma resposta super rápida e amigável quando enviei este artigo a eles. Uma pequena linha do tempo de como rolou o processo está no fim da página.

## Máquinas de pagamento com cartão de crédito

Aqui no Brasil, existem várias empresas que atuam como gateways de pagamento e esse tipo de coisa. Eu diria que as maiores são [PagSeguro](https://pagbank.com.br/) e [MercadoPago](https://mercadopago.com.br/). Enquanto o PagSeguro é originalmente do Brasil, o MercadoPago é da Argentina e veio de um negócio completamente diferente (MercadoLivre, que é basicamente o equivalente sul-americano do eBay).

Há também muitos bancos que hoje em dia possuem máquinas de pagamento, mas eu diria que a maioria deles, senão todos, compram as máquinas de um fabricante brasileiro chamado [TecToy](https://www.tectoy.com.br/) (o que anteriormente era feito pela [Transire](https://www.transire.com/), mas agora eles fundiram e são a mesma empresa).

E eu acho muito engraçado, porque a TecToy é uma fabricante de brinquedos, mas eles são enormes e antigos e uma das poucas empresas sobreviventes que **realmente fabricam hardware** no Brasil. Vale ressaltar que as máquinas não são projetadas por eles, mas principalmente por OEMs chineses como a [PAX](https://www.paxglobal.com.hk/) ou [Sunmi](https://www.sunmi.com/).

No Brasil, é muito fácil e barato para conseguir estas máquinas basicamente em qualquer lugar. Você consegue achar as máquinas descritas aqui no próprio site das empresas de pagamento (tente procurar Máquinas de Cartão no mercado livre ou google ;D )

Em resumo: Geralmente elas são máquinas baseadas na PAX, com o mesmo "Sistema Operacional" mas uma aplicação especifica customizada. Além disso a Pag também faz serviço de "OEM" e **muitas** empresas de pagamento usam as máquinas deles como base. Então basicamente, se você comprar uma máquina de cartão qualquer, a grande chance é que seja indiretamente deles também.

Pra simplificar, aqui estão as correspondências dos modelos para a PAX:

- Mini Chip 3 - PAX D188 (Baremetal)
- Moder Plus 2 - PAX D195 (Linux OS)
- Moder Pro 2 - PAX Q92S (Linux OS)
- Mini NFC 2 - PAX D177 (Baremetal)
- Mini Smart 2 - Sunmi P2 (Android)

Pra esse artigo eu acabei usando uma NFC2 que é uma simples e barata PAX D177. Vale notar que a D188 parece uma máquina completamente diferente, mas usa o mesmo processador (apenas em formato BGA e não QFN88), tem um modem 4G a mais e uma tela maior. A firmware que roda em ambas **é a mesma** (runtime selection).

## Primeiros trabalhos e Identificação de coisas

Geralmente quando estou fazendo engenharia reversa em hardwares considerados seguros, eu peço **pelo menos** três máquinas quando possível. Por que geralmente rola da seguinte maneira:

1. Vou abrir, e deixar **todas** proteções dispararem.
2. Vou usar para **tentar** bypassar todas proteções (caso seja meu objetivo)
3. Vou manter como está, para poder ter um modelo de referência para os estudos.

Nesse cenário específico, eu apenas queria rodar DOOM nela. Por que, se compute, ela precisa de DOOM.

Baseado nas minhas experiencias anteriores fazendo engenharia reversa nestas maquinas, eu já sabia o que esperar. Este artigo é apenas um resumo do caminho (dado que levei alguns anos pra chegar ao estado atual) que me lembro que segui. Então o que eu estava esperando era basicamente isso:

1. Segurança pesada
    1. Proteção contra tamper
    2. Proteção contra clock-glitching
    3. Proteção contra manipulação de RNG
    4. Assinaturas de código
    5. Criptografia de Código
2. Muita frustração

Eu podia seguir dois caminhos: exploitar o código que roda, ou trocar a CPU. Para exploitar, eu teria que achar uma falha de segurança que permitisse execução de código via Bluetooth, SmartCard, NFC ou USB, dado que estas são as únicas interfaces disponíveis. Para isso, eu teria que ter todo código, e como vocês vão ver mais pra frente, para esta máquina em específico, isso não era exatamente possível.

Segundo jeito era basicamente ver qual CPU estava na placa, comprar uma nova e trocar. O problema mesmo, é achar a CPU pra vender.

Mas, de um jeito ou de outro, eu precisaria abrir e identificar como as coisas estão ligadas e o que é usado. De referência, esta é a maquina que usei:

![](/assets/Running code in a PAX Credit Card Payment Machine/cb3d6416e80906d1e1a3cfa7c27ec46c_MD5.jpeg)

No lado de trás, alguns parafusos que são facilmente removidos. Eu geralmente faço isso com a **máquina ligada**, pois desta maneira consigo ver que ações minhas acionam as proteções anti-tamper.

![](/assets/Running code in a PAX Credit Card Payment Machine/942368afcd3a8b5c2f6280b0686279ad_MD5.jpeg)

Remover os parafusos, porém, não disparou nenhuma proteção. Apesar disso, assim que a tampa é removida, a tela indica que duas proteções foram acionadas.

![](/assets/Running code in a PAX Credit Card Payment Machine/9a88c682e238fdb16c61122c76c2e14c_MD5.jpeg)

na parte de trás do case, há alguns pontos de borracha-carbono, que encostam nos pontos de detecção na PCB. Eles funcionam basicamente da mesma maneira que os botões de um controle de video-game funcionam, só que neste caso, eles só garantem que "o botão está sempre apertado".

![](/assets/Running code in a PAX Credit Card Payment Machine/3744913eb7cc7b866b64eb363d6fbbe5_MD5.jpeg)

E por alguma razão, a máquina decidiu falar pra gente quais pontos de tamper foram acionados :)

![](/assets/Running code in a PAX Credit Card Payment Machine/9b728a005ceb00f991633d8d6ece65ed_MD5.jpeg)

Ah, isso também resetar pelo boot, então se você soldar os pinos de tamper (pra forçar eles a ficarem em contato) você consegue identificar os nomes de cada um hehe :)

Então, isso é a parte de baixo. Podemos ver algumas coisas, por exemplo a bateria-moeda na esquerda e uma grande PCB verde que parece inútil. Ela basicamente está em cima de todo circuito de leitura do cartão e os controladores da máquina.

![](/assets/Running code in a PAX Credit Card Payment Machine/4454b7008ef72e53db283abd4afafb86_MD5.jpeg)

Porém, mesmo que pareça inútil esta PCB, não a subestime: ela é basicamente uma PCB de 4 layers com uma mesh DENSA dentro dela. Qualquer dano ou remoção, aciona outro ponto de tamper. Só pra ter uma ideia, isso daqui é a PCB escaneada:

![](/assets/Running code in a PAX Credit Card Payment Machine/930418d0ee33dd3362d0ac27de43fa8e_MD5.jpeg)

Removendo todo plástico e a PCB, chegamos a placa principal:
![](/assets/Running code in a PAX Credit Card Payment Machine/1d47f48f4cf614dd72e26c37c839895c_MD5.jpeg)

E temos muitas coisas aqui, mas as coisas que nos importam estão na parte de baixo.

![](/assets/Running code in a PAX Credit Card Payment Machine/e808d21c32ba0866a386d155077709e4_MD5.jpeg)

Aqui conseguimos ver algumas coisas interessantes:

* MH1903 - Nosso principal SoC (CPU)
* NXP 8035S - PHY de Interface de SmartCard
* FM17660 - Leitor NFC
* XM25Q65 - Memória Flash SPI de 16MB

(E como você adivinhou, ativamos quase todos os pontos de tamper na parte de trás)

![](/assets/Running code in a PAX Credit Card Payment Machine/55e76a7d0d22410d56bada5afad18bd8_MD5.jpeg)

A memória flash, conseguimos dumpa-la. Eu tenho amostras tanto com tamper quanto sem tamper. O bypass da detecção de tamper fica como exercício ao leitor :) - Mas se você quiser entender como funciona, você pode dumpar ela diretamente mesmo com tamper, por que o tamper não apaga a memória flash inteira, apenas a porção onde tem conteúdo sensível para comunicação com os servidores de pagamento.

Eu estava esperando que a memória flash fosse sempre criptografada, mas não é. Apesar disso, não dá pra mudar os conteúdos (código) dela pois é tudo assinado. então conseguimos usar para engenharia reversa, mas não para execução de código. Ainda assim, é massa. Temos 16MB de flash, então podemos colocar um WAD inteiro do DOOM nela! :D

## O que sabemos sobre o MH1903

Aqui é quando bicho pega. O SoC está por trás de um véu de obscuridade. O núcleo é feito pela Megahunt, que basicamente só provê essas informações:

![](/assets/Running code in a PAX Credit Card Payment Machine/cf4f007fbd8b87c83cb0e4f3c3560cc7_MD5.jpeg)
(veja <https://www.megahuntmicro.com/en/index.php?catid=5> )

Indo um pouco mais a fundo no google, a gente consegue achar algumas informações a mais de alguns vendedores. Ele tem **muitas** variações, mas em resumo, o núcleo é o mesmo. Só mudando quantos pinos estão expostos, quantidade de memória flash, ram etc... Essa versão especifica é a QFN88, que tem essas especificações:

* RAM: 1MB
* FLASH: 1MB
* SPI: 4
* ADC: 5
* DAC: 1
* GPIO: 64
* USB: 1
* Serial: 4

Como vocês podem ver, essa versão tem uma memória flash inteira, o que é uma pena pra mim. Ainda estou montando meu equipamento para inspeções diretas no chip. Eu já fiz alguns decaps, e a memória flash não está embutida no mesmo silício, mas apenas colada em cima do chip principal e ligada através de fios. Eu ouvi alguns amigos da indústria de semicondutores dizer, que a razão disso é que o processo de fabricação entre memórias flash e CPUs diferente um pouco e é difícil unificar ambos. Por isso, geralmente é preferível fazê-los separados (especialmente caso precise de uma densidade muito alta).

Uma coisa pra se notar, as versões BGA do SoC não tem memória flash embutida, então elas são obrigadas a carregar de uma flash externa. Spoiler: A D188 tem duas memórias flash na placa :)

E também temos uma variante MH1903S, que tem mais flash, mas menos RAM / GPIO / SPI

* RAM: 640KB
* FLASH: 4MB
* SPI: 3
* ADC: 6
* DAC: 1
* GPIO: 56
* USB: 1
* Serial: 3

Então, o google não me deu muita informação sobre, apesar de eu ter achado _algumas_ SDK no github (a maioria mirror dos git chinês) e eu tive que recorrer ao Baidu. Essa parte levou um bom tempo, por que muitas informações não estão disponível fora da china continental, e existem muitas variações do MH1903. Eu achei vários datasheets com informações conflitantes, e boa parte deles eu tive que pagar para baixar do CSDN. Por sorte, existem alguns brokers que fazem isso por você. No fim desta página há um link com todos os datasheets relevantes que eu achei, caso você precise. Só esteja avisado: Mesmo neles, há muita informação omitida e conflitante.

Tá, mas como testei então todas as suposições que fiz sobre o chip? Bom, eu achei _por um acaso_ que existe uma placa chinesa similar ao Arduino, feito pela LUAT chamada AIR105. Parece nada a ver, mas uma pesquisa no baidu indicou que o AIR105 usa um núcleo MH1903S. E o lado bom, AIR105 é facilmente comprável na Aliexpress: <https://s.click.aliexpress.com/e/_oBLNTrc>

![](/assets/Running code in a PAX Credit Card Payment Machine/427a383619233fb72eef5161e05511e8_MD5.jpeg)

Eu comprei alguns, decapei alguns e adivinha só: realmente é um MH1903S :D

![](/assets/Running code in a PAX Credit Card Payment Machine/9138886ea831b06c18888099fd0e26a6_MD5.jpeg)

Pra comparação, eu também decapei um SoC da máquina, e a escrita indicava 1903A:

![](/assets/Running code in a PAX Credit Card Payment Machine/feb55758da95a7ecb62f02451c058606_MD5.jpeg)

Ah, e lembra que falei que a memoria flash era colada no chip principal? Aqui tá uma foto mostrando ambos (E malz, eu ainda não fiz um equipamento pra focus stacking). A memória flash está fora de foco na direita. Os boundwires estão mortos por que usei ácido nítrico 78% e os fios eram de cobre.

![](/assets/Running code in a PAX Credit Card Payment Machine/551efee7006a314cf9d0b9257bb61edc_MD5.jpeg)

![](/assets/Running code in a PAX Credit Card Payment Machine/4fd85cc5f052df9b22c267e7559b0af5_MD5.jpeg)

Então basicamente, eu poderia assumir que eles são pelo menos similares. Os Datasheets de ambos também dizem a mesma coisa (única diferença mesmo é flash e ram).

O diagrama de blocos pra essa CPU está no datasheet, e é basicamente **a única** informação que bate em relação a todos datasheets:

![](/assets/Running code in a PAX Credit Card Payment Machine/8cd0cc82e5b752464a0617442e0c765f_MD5.jpeg)

O SC300 é na verdade uma especificação de ARM chamada **SecurCore**. É um Cortex M3 (no caso do MH190x é um M4F) com alguns recursos de segurança. Por exemplo, mesmo eles sendo simples processadores ARM de 32 bit, eles tem algumas proteções de memória para restringir acessos entre OS <> APP (uma versão primitiva do TrustZone). Ah e claro, as especificações oficiais só estão disponíveis através de NDA, então só podemos deduzir o que exatamente a especificação diz. Pra uma ideia: As CPUs no seu cartão de crédito, seguem a mesma especificação.

Os datasheets também especificam um mapa da memória, o qual todos datasheets concordam. Porém, **claramente** não é tudo que o dispositivo tem. Por exemplo, a MH diz que a CPU tem acelerador de RSA, AES e hashes via hardware, mas não existe nenhuma descrição deles no datasheet. Depois eu descobri que eles só estão obscurecendo o conteúdo ou precisam de um NDA. Eu vou eventualmente fazer engenharia reversa de todos aplicativos que eu dumpei e também de uns binários de SDK que eu achei pela internet. Ah, e por favor, se esses endereços baterem com algum dispositivo que você usa, me avise. Na minha experiência os dispositivos chineses tentam ser compatíveis com alguma coisa do mercado, mas nada que achei indica ser um clone direto de algum SoC do mercado. (Eu especulei ser um STM32 ou ATMSAMD, mas não bate).


| Address Range           | Peripheral name | Bus Name |
| ----------------------- | --------------- | -------- |
| 0x4000_0000-0x4000_03FF | SSC             | AHB      |
| 0x4000_0800-0x4000_0BFF | DMA             | AHB      |
| 0x4000_0C00-0x4000_0FFF | USB             | AHB      |
| 0x4000_1000-0x4000_13FF | LCD             | AHB      |
| 0x4000_8000-0x4000_BFFF | OTP             | AHB      |
| 0x4006_0000-0x4006_FFFF | DCMI            | AHB      |
| 0x4008_0000-0x4008_FFFF | CACHE           | AHB      |
| 0x400A_2000-0x400A_2FFF | QSPI            | AHB      |
| 0x400A_3000-0x400A_3FFF | SPIM5           | AHB      |
| 0x4001_0000-0x4001_0FFF | SCI0            | APB0     |
| 0x4001_2000-0x4001_2FFF | CRC             | APB0     |
| 0x4001_3000-0x4001_3FFF | Timer0          | APB0     |
| 0x4001_4000-0x4001_4FFF | ADC             | APB0     |
| 0x4001_5000-0x4001_5FFF | SCI2            | APB0     |
| 0x4001_6000-0x4001_6FFF | UART0           | APB0     |
| 0x4001_7000-0x4001_7FFF | UART1           | APB0     |
| 0x4001_8000-0x4001_8FFF | SPIM1           | APB0     |
| 0x4001_9000-0x4001_9FFF | SPIM2           | APB0     |
| 0x4001_A000-0x4001_AFFF | SPIM0           | APB0     |
| 0x4001_B000-0x4001_BFFF | SPIS0           | APB0     |
| 0x4001_C000-0x4001_CFFF | Watchdog        | APB0     |
| 0x4001_D000-0x4001_DFFF | GPIO            | APB0     |
| 0x4001_E000-0x4001_EFFF | TRNG            | APB0     |
| 0x4001_F000-0x4001_FFFF | SYS_CTRL        | APB0     |
| 0x4002_0000-0x4002_FFFF | MSR             | APB1     |
| 0x4003_0000-0x4003_7FFF | BPU             | APB2     |
| 0x4004_4000-0x4004_4FFF | UART2           | APB3     |
| 0x4004_5000-0x4004_5FFF | UART3           | APB3     |
| 0x4004_8000-0x4004_8FFF | KEYBOARD        | APB3     |
| 0x4004_9000-0x4004_9FFF | I2C0            | APB3     |

A RAM está mapeada no lugar esperado pra esses ARM Cortex. Começa em 0x2000_0000 e vão até o tamanho máximo da RAM (640KB pro MH1903S e 1MB pro MH1903). As bit-bands também estão no lugar esperado, 0x2200_0000 pra RAM. Também há mais devices que não estão listados acima, esses terão seu próprio artigo depois que eu terminar de mapear tudo.

O datasheet principal mostra duas variantes do QFN88, uma tendo um sufixo `_J`. A versão não J tem um regulador 3.3V interno, que é muito bom para placas tipo o AIR105. Fazendo engenharia reversa da placa da D177, parece que o pin-out bate exatamente com a variante J. Vocês verão que eu tive um grande problema por que eu assumi que o datasheet estava correto XD

## Descobrindo como as coisas estão conectadas

A primeira coisa que preciso descobrir é **pelo menos** onde a UART está (se está). Eu sei que o USB da máquina é fixo, por que os pinos são fixos. Mas por alguma razão eu não consegui ativar a bootrom pela USB então tive que caçar a UART.

Os pinos da UART geralmente estão exposto de alguma maneira, para diagnósticos durante a fabricação. Isso ou o JTAG (ou mais especificamente aqui, o SWD). Porém no caso desse micro controlador, eles estão desativados durante o boot, então decidi não perder muito tempo tentando achar eles na placa.

Tá, mas como eu consigo achar as coisas na placa? Bom, eu geralmente removo **todos** componentes da placa e faço um scan dela (usando scanner normal de papel). E aí eu faço um overlay com o pinout da CPU e traço até onde vai. Uma boa aplicação pra isso é o [Inkscape](https://inkscape.org/). Ele permite desenhar tudo vetorizado e as imagens de scanner doméstico tem 1:1 com tamanho real dela (então caso você precise de medidas, elas são realistas).

Então desenho retângulos cinzas e coloco os nomes:

![](/assets/Running code in a PAX Credit Card Payment Machine/bacf2a2ebe249871db70adb98d4fa2b7_MD5.jpeg)

Eu também marco as vias, por que essas placas costumam ser multi-layer e você vai precisar de tudo pra seguir elas:

![](/assets/Running code in a PAX Credit Card Payment Machine/fdeaa9034f0f2a2217c7d55f05e2e6f4_MD5.jpeg)

Por exemplo, o TX e RX passa através da parte frontal da PCB também (esquece esse desalinhamento, nao sei por que a imagem bugou).

![](/assets/Running code in a PAX Credit Card Payment Machine/652fd1331e348c4861938eadf3f0a824_MD5.jpeg)

Depois de seguir tudo, eu cheguei em 2 de 5 testpads, no canto direito da parte de trás da PCB, os quais marquei também no Inkscape.

![](/assets/Running code in a PAX Credit Card Payment Machine/985831c28a29ecc016e52f876980476a_MD5.jpeg)

Agora que eu tinha a UART, eu poderia usa-la para reprogramar a máquina após a troca da CPU. E pra aqueles que estão pensando: a UART, para a aplicação da máquina, é basicamente a mesma coisa do USB e do bluetooth, então (geralmente) não há leak de informações ali. É exatamente o que o aplicativo móvel acessa. E caso você queira explorar, você pode usar USB ou Bluetooth que elas vão agir da mesma maneira desta UART.

## Troca de CPU

Um dos jeitos mais fáceis que eu consigo rodar um código nela e pulando a parte de tentar bypassar o secureboot, é apenas comprar uma CPU nova e trocar. Alguns podem considerar isso uma vulnerabilidade, mas eu pessoalmente não considero: Mesmo que alguém tenha acesso a todo código que roda nas máquinas, ainda assim eles precisam das chaves e dos dados carregados na NVRAM para a transação de cartão. Eu já vi uns tempos atrás o caso de algumas máquinas que armazenavam isso na memória flash (então se você quebrasse a CPU antes de ela detectar o tamper, o conteúdo estava lá). Mas este não é o caso desta máquina.


Infelizmente esses MH1903 são bem raros pra comprar fora da china continental. De tempos em tempos eles aparecem na Aliexpress. Aqui está um link <https://s.click.aliexpress.com/e/_oBMot6n> embora ele provavelmente vai estar morto quando você estiver lendo isso.

![](/assets/Running code in a PAX Credit Card Payment Machine/c94d5244a68733e5cfbec91c6f08f5f0_MD5.jpeg)

É uma CPU bem cara, R$34 de CPU e ainda R$15 de taxad por dispositivo. E ainda tem os R$28 de frete. Eu comprei 5 deles (caso eu precisasse de mais) e saiu por volta de R$150 com o frete.

![](/assets/Running code in a PAX Credit Card Payment Machine/edad8e809adbb209bf4eca20043fd1dd_MD5.jpeg)

Uns anos atrás eu tentei trocar a CPU dessa maquina sem nenhum sucesso. Então eu pensei que a variante que eu tinha não era a J, mas a mesma do AIR105 (o que faria sentido) e isso me deixou triste. Mas recentemente eu estava colecionando as bootroms, e decidi trocar um AIR105 por um MH1903 que comprei apenas para dumpar o bootloader (mais bootloaders == mais informações).

![](/assets/Running code in a PAX Credit Card Payment Machine/8fabf3473c8ee086fdea127b537c4ef6_MD5.jpeg)

E depois de fazer isso, eu percebi que a placa estava full morta. Nenhuma energia além dos 5V. Depois de trocar eu notei uma coisa no datasheet:

![](/assets/Running code in a PAX Credit Card Payment Machine/725ff8aa056e6d095a4ac1ea1882fa1a_MD5.jpeg)

![](/assets/Running code in a PAX Credit Card Payment Machine/839cea0de243ff5cc485a19e6a0fb849_MD5.jpeg)

Uma das diferenças entre o J e não J, é que a versão **não J** (nesse caso AIR105) tem um LDO interno de 3.3V. E olhando os esquemáticos do AIR105, adivinha só? Não existe nenhum outro regulador na placa. É tudo alimentado por esse LDO.

![](/assets/Running code in a PAX Credit Card Payment Machine/87356f1a4622aa38a746dd5676123bf5_MD5.jpeg)

Então, fazia sentido não ter nada no 3.3V dado que a versão J nao tinha o regulador. Então eu decidi novamente trocar a CPU da D177. Pra isso, eu decidi começar do zero: Máquina recém tirada da caixa e um MH1903 que nao tinha usado. O resultado? Nada ainda. Nada na UART, nada na USB (e ambos deveriam ter atividade da bootrom).

O que acontecia é que, a bootrom nunca respondia as chamadas de handshake do meu leitor, o que era estranho. Decidi tentar no AIR105, até que notei que a placa sempre resetava quando eu enviava o sinal RTS na porta serial.

![](/assets/Running code in a PAX Credit Card Payment Machine/fd96942840f9a3924a76e5d843ee88a2_MD5.jpeg)

Isso me fez pensar: como ele tava resetando a placa? Olhando pela pinagem do chip, não existe reset. Mas olhando pelo esquema do AIR105 vemos uma coisa interessante:

![](/assets/Running code in a PAX Credit Card Payment Machine/217023812ae3d8552e72a67306105efa_MD5.jpeg)

![](/assets/Running code in a PAX Credit Card Payment Machine/0c7f3862853471f760b69c71098168a4_MD5.jpeg)

Basicamente a placa, não tinha a bateria-moeda onde deveria ter, só um capacitor pra emular (o XH311H no esquemático, era basicamente um conector nao populado), e o que o pino de reset fazia na verdade era **colocar essa bateria em curto** fazendo ela marcar 0V. E adivinha só? O datasheet estava me falando o tempo todo, mas minha falta de experiência lendo chines só passou batido 😆

![](/assets/Running code in a PAX Credit Card Payment Machine/7a75d13b7c4758f46f7c29717f7907cd_MD5.jpeg)
Pra aqueles (como eu) que estão enferrujados no Chines, o texto acima basicamente diz: Alimentação da bateria, precisa ser energizado caso contrario o chip não funciona.

Então eu investiguei um pouco mais a bootrom (ainda vou postar detalhes da engenharia reversa da bootrom desse chip) e notei que o que acontece é: Quando o VBAT33 cai para baixo de 2.3V, ele aciona um tamper na CPU. O jeito que a CPU lida com esse tamper, é basicamente se resetar, o que apaga a NVRAM e seta alguns registradores que podem ser lidos pela bootrom ou pela aplicação. Então basicamente, o botão de reset do AIR105 é um botão de tamper 😆

Olhando na PCB da D177, não há nenhum testpad específico para atuar como reset, mas geralmente para evitar que a bateria seja usada quando existe energia externa, colocam um diodo em série com ela a maneira de isolar ela. Posso soldar um fio nesse diodo para usar como reset. Seguindo os traços na PCB, achei um diodo na borda da placa.

![](/assets/Running code in a PAX Credit Card Payment Machine/ea6eb39aabf1f914c71bda9f6eb79907_MD5.jpeg)

Então apenas soldei um fio, abri meu [air105-uploader](https://github.com/racerxdl/air105-uploader/) e manualmente setei ele pro GND. E **PROFIT**:

![](/assets/Running code in a PAX Credit Card Payment Machine/a4da09ed6fa71e3bd9b38a0097594756_MD5.jpeg)

Agora eu consigo rodar código na máquina!!!

![](/assets/Running code in a PAX Credit Card Payment Machine/3247c212e1baa37421f763ede653c022_MD5.jpeg)

## Construindo código para isso

Não vou entrar em muitos detalhes aqui (já que este artigo já está ficando maior do que eu esperava), mas o resumo é: o LuatOS fornece uma maneira de construir coisas e tem um "boilerplate" para inicializar todas as coisas do lua. O próprio CPU é um ARM Cortex, então é facilmente construível pelo GCC, apenas requerendo um script de ligação personalizado para juntar tudo no lugar certo.

Basicamente, reutilizei quase tudo que fiz para o AIR105, apenas mudei o script de ligação para estar ciente de que o MH1903 na verdade tem 1MB de RAM em vez de 640KB. Para torná-lo mais fácil de usar, criei algumas libs para [platform.io](https://platformio.org/) que você pode usar diretamente.

Se você quiser experimentar, basta instalá-lo através do pip.

```bash
pip install -U platformio
```

Em seguida, você pode criar um novo projeto:

```bash
mkdir my-project && cd my-project
pio init
```
```
The following files/directories have been created in /tmp/m
include - Put project header files here
lib - Put project specific (private) libraries here
src - Put project source files here
platformio.ini - Project Configuration File
Project has been successfully initialized!
```

Depois disso, você pode simplesmente editar o `platformio.ini` para mapeá-lo para usar a plataforma air105:

```toml
[env:air105]
platform = https://github.com/racerxdl/platformio-air105
board = mh1903
framework = baremetal
;monitor_port = SERIAL_PORT
;monitor_speed = 115200
monitor_rts = 0 ; AIR105 board has inverted RTS
build_flags = -g -ggdb
```

Você pode alterar o parâmetro `board` entre `mh1903` e `air105`, dependendo do que você está direcionando. O MH1903 é a variante de 1MB, portanto, o código travará no AIR105 devido à stack estar posicionada no final do espaço RAM.

E para executar:
```bash
pio run -t upload
```

Isso deve compilar e carregar (usando o air105-uploader) diretamente. Também irá baixar qualquer ferramenta e bibliotecas necessárias para isso. Você também pode adicionar `-t monitor` para abrir um console serial e ver o retorno da máquina.

O código-fonte para o framework e a plataforma nos links do platform.io estão no final deste artigo.

## MAGIC STUFF

Então, este artigo está ficando enorme e sinto que muitos detalhes serão mal escritos se eu continuar colocando conteúdo aqui. Afinal, este é um projeto de pesquisa de mais de 4 anos. Portanto, eventualmente escreverei mais dois artigos sobre como mapeei algumas coisas mágicas.

Quando digo coisas mágicas, as próximas seções deste artigo vão assumir que sabemos como o LCD está conectado à CPU, o que inicialmente supus que estava na mesma porta que a memória flash que vimos na PCB. Resumindo, está, mas não o Chip Select, nem o controle da backlight do LCD, e esses não foram triviais de encontrar, já que o pinout do LCD não é padrão e eu não consegui encontrar nenhum datasheet dele.

Eu emulei o firmware para descobrir algumas coisas (outras coisas foram apenas observando seções descompiladas) e a coisa mágica que descobri é que os pinos que controlam o LCD estão mapeados em um GPIO que **não existe** de acordo com o datasheet 😃 (Spoiler, existem **dois** GPIOs não documentados e algumas outras coisas)

Por agora, vamos apenas fingir que escrevi um bom artigo sobre como fiz isso. Prometo que escreverei um novo com detalhes sobre a engenharia reversa e os detalhes de como fiz um emulador para isso (que poderia até mostrar as imagens do LCD) 👀

![](/assets/Running code in a PAX Credit Card Payment Machine/e129a7f1554e79536be3ca8d71fe03d9_MD5.jpeg)

## Fazendo o "crasharalho"

O "crasharalho" é um sticker que uso muito no Discord e no Telegram. No artigo inglês eu explico o que é o crasharalho, mas acho que em português, é auto explicativo hehe.

Fazer foi fácil, apenas criei uma imagem 160x128 no GIMP e colei o sticker lá.

![](/assets/Running code in a PAX Credit Card Payment Machine/67e6e21e4aca4b6c3ceeb47bf2b57530_MD5.jpeg)

O Gimp também é bom porque pode exportar diretamente para um cabeçalho C, meio que comprimido com uma macro para realmente obter os valores de pixel R,G,B. Então foi bem fácil convertê-lo.

```c
/* GIMP header image file format (RGB): include/crasharalho.h */

static unsigned int width = 160;
static unsigned int height = 128;

/* Call this macro repeatedly. After each use, the pixel data can be extracted */

#define HEADER_PIXEL(data,pixel) {\
pixel[0] = (((data[0] - 33) << 2) | ((data[1] - 33) >> 4)); \
pixel[1] = ((((data[1] - 33) & 0xF) << 4) | ((data[2] - 33) >> 2)); \
pixel[2] = ((((data[2] - 33) & 0x3) << 6) | ((data[3] - 33))); \
data += 4; \
}

static const char *header_data =

")#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A"

")#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A)#!A"
(...)
```

O LCD ST7735 que a máquina usa tem vários modos de pixel. Decidi usar RGB565, pois seria exatamente 16 bits de largura (o que dá dois bytes sobre SPI) e fácil de converter. Fui preguiçoso, então usei uma LLM local para gerar uma macro para convertê-lo, o que funcionou muito bem (eu não lembrava como converter os espaços, não tinha certeza se era apenas cortar bits ou realmente uma LUT).

```c
#define RGB888_TO_RGB565(r, g, b) ( \
(((r) & 0xF8) << 8) | /* 5 bits of red, shifted to bits 15-11 */ \
(((g) & 0xFC) << 3) | /* 6 bits of green, shifted to bits 10-5 */ \
(((b) & 0xF8) >> 3) /* 5 bits of blue, shifted to bits 4-0 */ \
)
```

A LLM gerou um pequeno corte, e funcionou bem. Então, deixei como estava. Depois, pude simplesmente enviá-lo diretamente no código:

```c
    {
        // 0x2C RAMWR
        SendCMD(LCD_SPI, 0x2C);                // RAMWR
        P15_ON;
        uint8_t rgb[3];
        // Fill the screen with white color // 16 bit mode
        for (int i = 0; i < 160 * 128; i++) {
            HEADER_PIXEL(header_data, rgb);
            uint16_t color = RGB888_TO_RGB565(rgb[0], rgb[1], rgb[2]);
            SendCMDParam(LCD_SPI,color >> 8); // Send high byte
            SendCMDParam(LCD_SPI, color & 0xFF); // Send low byte
        }
        P15_OFF;
    }
```

E testei no meu emulador:

![](/assets/Running code in a PAX Credit Card Payment Machine/947b71be153e6405b62909b62e93385d_MD5.jpeg)

## Resultado

![](/assets/Running code in a PAX Credit Card Payment Machine/23c966b8036e41fe19f78b38bfa8bf73_MD5.jpeg)

## Próximos passos

Rodar doom, é claro 😃 - Eu planejava fazer este artigo apenas após o doom, mas descobri que 1MB de RAM é meio baixo para o doom padrão. Vi que há uma versão RP2040 do doom que funciona muito bem, então provavelmente vou portar para esse núcleo.

Ainda quero fazer engenharia reversa de tudo que puder desses SoCs, já que são bastante poderosos e têm bons aceleradores que podem ser usados para outras coisas seguras. Também consegui extrair as ROMs de boot do MH1903S e do MH1903, que têm seus próprios aspectos interessantes. Quase terminei de fazer a engenharia reversa da ROM de boot do MH1903S e pretendo fazer um artigo sobre isso em breve. Parece que existem várias versões de ROMs de boot por aí (elas basicamente fazem a mesma coisa, mas têm diferentes revisões e builds). Então, se você encontrar algum dispositivo MH190x que você possa fazer JTAG ou que não tenha a assinatura de boot habilitada, me avise. Vamos fazer um arquivo de ROMs de boot 😃

## Notas

1.  Houve um pouco de pesquisa sobre os códigos da PAX e PagBank para descobrir como eles interagem com o hardware. Nenhuma falha de segurança foi explorada e não há nada que eles possam fazer sobre a troca de CPU.
2. Não há nada específico para o PagBank nesse caso. Qualquer D177 deve funcionar bem. O trabalho aqui **não é devido a uma falha de segurança**.
3. Megahunt faz MUITO "Silicon OEM" (o AIR105 mencionado aqui é apenas um deles). Decaps devem apontar.
4. Além da boot rom, não compartilho binários que extraí de máquinas. Não fiz engenharia reversa o suficiente para saber quais informações eles armazenam, e eles podem conter coisas que devem ser privadas. Portanto, por favor, não peça, você pode extraí-lo você mesmo. É bem fácil.
5. Os artigos seguintes mostrarão como fiz engenharia reversa dos boot loaders, formato de imagem pax e descobri como os pinos do LCD foram mapeados.

### Links

* <https://github.com/racerxdl/platformio-air105> - PIO Platform for AIR105/MH1903
* <https://github.com/racerxdl/framework-megahunt> - PIO Framework for Megahunt devices
* <https://github.com/racerxdl/air105-uploader> - Python script to upload using the boot rom
* <https://archive.org/details/mh-1903-s-v-1.5> - Some usefull MH1903 datasheets
* <https://github.com/racerxdl/d177-crasharalho> - Crasharalho Source Code
* <https://github.com/racerxdl/megahunt-bootroms> - Megahunt Bootroms
* <https://github.com/racerxdl/mhdumper> - Megahunt ROM Dumper Tool

### Timeline

- **01/04/2025** - Voltei aos trabalhos de engenharia reversa e mapeamento
- **17/06/2025** - Consegui rodar o primeiro código (crasharalho)
- **22/06/2025** - Terminei o artigo, mandei para revisão (técnica)
- **27/08/2025** - Enviei o artigo para pag para revisão
- **28/08/2025** - Aprovado pela pag para publicação
- **31/08/2025** - Mais reviews, tradução, etc...
- **05/09/2025** - Publicado