---
id: 116
title: Interruptor MIDI Polifônico com PIC 16F628A
date: 2016-01-24T23:26:49-03:00
author: Lucas Teske
layout: revision
guid: http://www.teske.net.br/lucas/2016/01/42-revision-v1/
permalink: /2016/01/42-revision-v1/
---
# &#8211; Introdução

Bom, muitos sabem que eu fiz um Interruptor MIDI (ou sintetizador como preferir) com um FPGA. Porém poucos tem acesso a um FPGA principalmente para fazer algo tão \*simples\*, então resolvi fazer um com PIC 16F628A.

No começo queria fazer com um PIC menor, mas os menores não tem Receptor Serial via **_hardware_**, então ficaria mais complicado implementar. Outro ponto, é que o preço dos PIC&#8217;s menores são praticamente os mesmos, então era só uma questão de espaço mesmo. Usando um PIC maior, fica mais espaço livre para futuras modificações caso seja necessário.

O PIC 16F628A tem 2KB de memoria flash, 224 Bytes de RAM, 128 Bytes de EEPROM, um Comparador, 3 Timers, e um Receptor Serial Universal. Está no pacote DIP de 18 Pinos, e ele tem 2 portas de 8 bits (dependendo da configuração, a porta A pode \*perder\* 3 bits.

Datasheet dele: <http://ww1.microchip.com/downloads/en/DeviceDoc/40044F.pdf>

Ele tem um oscilador RC Interno de 4MHz calibrado de fábrica para +/- 1%, então podemos fazer uso dele tranquilamente.

<!--more-->

# &#8211; Protocolo MIDI

Vamos falar um pouco antes do protocolo MIDI. O Sinal MIDI é basicamente um sinal Serial parecido com padrão RS232. São 10 bits enviados, um bit para identificar o inicio (_start bit_), 8 bits de dados, e um bit para identificar o fim (_stop bit_). Ele só não se encaixa na RS232 por causa de sua _Baud Rate_ (velocidade com que os bits são transmitidos), que é 31250 Hz (ou 31.25 kBits por segundo). Por apenas sua _Baud Rate_ ser fora de padrão, podemos usar a porta serial universal do PIC, apenas usando 31250 como _Baud Rate_.

Outro ponto do Protocolo MIDI, é que todo dado MIDI é composto por 3 Bytes (24 bits), sendo o primeiro deles o byte de **Operação**, e os outros dois bytes de **Dados**. Para uma identificação mais fácil de qual é qual, foi padronizado que se o primeiro bit (MSB) do byte for 1, é uma **Operação**, se for 0 é **Dado**. Assim caso a transmissão de algum byte falhe (principalmente o primeiro) é possível saber.

A tabela simplificada abaixo associa os modos de operação e a função de seus dados:

![image](https://media.tumblr.com/tumblr_lt646kEHJA1qh7srd.jpg) 

Na tabela só está os mais comuns e tirando o _Pitch Bend, os que vamos usar._

Iremos então fazer o PIC ler 3 bytes, e depois efetuar as operações necessárias de acordo com o primeiro byte.

# &#8211; Notas musicais e Timer do PIC

Outro detalhe importante são as notas musicais. O MIDI apenas envia o numero da nota, que varia de 0 a 127. Precisamos então calcular o período das notas.

A frequência de uma dada nota musical, tem que dobrar a cada 12 notas. Para isso é dada a fórmula:

> <div>
>   <p>
>     <strong>Frequência = FreqBase * 2^(n/12)</strong>
>   </p>
> </div>

Onde **Frequência** é a frequência da nota que queremos, **FreqBase** é a frequência da nota base, **n** é o numero da nota relativa a nota base. A nota que usaremos como base é a 10ª nota, que tem sua frequência em 27.5Hz. Para calcularmos o período de uma nota é só pegarmos o inverso da frequência:

> <div>
>   <p>
>     <strong>Período = 1 / ( FreqBase * 2^(n/12) )</strong>
>   </p>
> </div>

Até podemos calcular isso em tempo real no PIC, porém podem haver atrasos muito grandes, então faremos uma tabela com os períodos das notas para usarmos.

Podemos usar o seguinte código em PHP para calcularmos as frequências:

<pre class="brush: php; title: ; notranslate" title="">&lt;?

for($i=0;$i&lt;128;$i++) {
    $freq = 27.5 * pow(2,($i-9)/12);
    echo(&quot;Nota: $i Frequência: $freq\r\n&quot;);
}

?&gt;
</pre>

Link do Codepad: <http://codepad.org/4GloHc3b>

De maneira semelhante podemos fazer para o período:

<pre class="brush: php; title: ; notranslate" title="">&lt;?

for($i=0;$i&lt;128;$i++) {
    $period = 1/ (27.5 * pow(2,($i-9)/12));
    echo(&quot;Nota: $i Periodo: $period\r\n&quot;);
}

?&gt;
</pre>

Link do Codepad: <http://codepad.org/yqXDTXQZ>

No PIC, usaremos o **TIMER1** como referência, ele é um timer de **16 bits**, ou seja conta de **** a **65535**. Faremos ele incrementar de 1 em 1 micro segundo, então colocaremos o período em micro segundos. Outro detalhe é que depois que o timer está rodando, não podemos para-lo. Precisamos esperar ele chegar até o fim, então faremos ele contar apenas o necessário (o período). Sendo o máximo dele de **65535**, ao iniciar uma nota, colocaremos **65535-período** em seu valor inicial, assim ele contará apenas o tempo do período. Faremos então um script que já gere um _array_ com os valores que precisamos de cada nota:

<pre class="brush: php; title: ; notranslate" title="">&lt;?
echo &quot; const unsigned int16 notas[] = {&quot;;
for($i=0;$i&lt;128;$i++) {
    $period = 65535-round(1000000 / (27.5 * pow(2,($i-9)/12)));
    if($i==0) echo($period); else echo(&quot;,$period&quot;);
}
echo &quot;};&quot;;
?&gt;
</pre>

Link do codepad: <http://codepad.org/yUNkOm7V>

<pre class="brush: cpp; title: ; notranslate" title="">const unsigned int16 notas[] = {4379,
7811,11051,14109,16995,19720,22291,24718,27009,29171,31212,33139,34957,
36673,38293,39822,41265,42627,43913,45127,46272,47353,48374,49337,50246,
51104,51914,52679,53400,54081,54724,55331,55904,56444,56954,57436,57890,
58320,58725,59107,59468,59808,60130,60433,60719,60990,61245,61485,61713,
61927,62130,62321,62501,62672,62832,62984,63127,63262,63390,63510,63624,
63731,63832,63928,64018,64103,64184,64259,64331,64399,64462,64523,64579,
64633,64684,64731,64777,64819,64859,64897,64933,64967,64999,65029,65057,
65084,65109,65133,65156,65177,65197,65216,65234,65251,65267,65282,65296,
65310,65322,65334,65345,65356,65366,65376,65385,65393,65401,65408,65416,
65422,65429,65435,65440,65446,65451,65455,65460,65464,65468,65472,65475,
65479,65482,65485,65488,65490,65493,65495};
</pre>

Isso já nos da o array com os valores que teremos que colocar no **TIMER1**. Assim podemos facilmente agora começar a programar 😀

# &#8211; Programa do PIC

O programa do PIC não é tão complexo assim. Usaremos o _CCS C_ como compilador C, mas o programa pode ser facilmente adaptado a qualquer outro compilador. Usaremos a Interrupção da _USART_ para receber os bytes e armazena-los numa array de 3 bytes. Após completar os 3 bytes, ele vai marcar uma variável como 1 para sabermos que recebemos os 3 bytes.

Definiremos duas variáveis do tipo _int16_ para período e tOn (tempo ligado), uma _array de char_ de tamanho 3 para os bytes, duas _int1_ para identificar se há alguma nota ligada e para marcar o buffer de 3 bytes como carregado, duas variáveis do tipo _int_ para fazer a contagem dos bytes recebidos e para guardar o numero da nota carregada.

<pre class="brush: cpp; title: ; notranslate" title="">static unsigned int16 tOn = 250;    //tOn
static unsigned int16 period = 0;   //Período
static int1 noteOn = 0;             //Nota Ligada
static int8 loadedNote = 0;         //Nota Carregada
static char buffer[3];              //Buffer de Bytes
static int1 buffer_loaded;          //Estado do Buffer
static int  buffer_counter = 0;     //Contador do Buffer
</pre>

Assim definimos as variáveis que iremos usar no código. Agora iremos a função da interrupção da porta serial. O _CCS C_ identifica a interrupção serial do PIC como **INT_RDA**, então iremos colocar uma função para ela:

<pre class="brush: cpp; title: ; notranslate" title="">#int_rda 
void serial_isr() 
{ 
   if(buffer_counter!=3) {             //Se ainda não leu 3 bytes
      buffer[buffer_counter]=getc();   //Ler o byte e guardar no buffer
      buffer_counter++;
      if(buffer_counter==3) {          //Se ler 3 bytes, 
         buffer_counter = 0;           //Resetar o contador
         buffer_loaded = 1;            //Marcar o buffer como carregado
      }else{                           //Se não
         buffer_loaded = 0;            //Manter o status do buffer como 0
      }
   }else                               //Caso receber algum byte com o buffer
      getc();                          //carregado, descartar o byte.
}</pre>

Com isso, estaremos recebendo os bytes e armazenando no buffer. Iremos agora então fazer a interrupção do **TIMER1** que irá fazer a contagem. Nessa interrupção iremos apenas fazer ele setar o valor correto em si mesmo cada vez que sua contagem chegar ao fim. A interrupção é acionada toda vez que o **TIMER1** termina de contar. Ou seja, após 65535 us no nosso caso.

<pre class="brush: cpp; title: ; notranslate" title="">#INT_TIMER1
void resetTimer1() {
   set_timer1(period);
}</pre>

Iremos agora para a rotina principal, onde iremos fazer todo trabalho <span style="text-decoration: line-through;">pesado</span>.

Precisamos fazer a inicialização do PIC, faremos tudo isso dentro da _void main()_.

Iremos definir uma variável do tipo _int16_ para podermos guardar temporariamente a posição do **TIMER1** no código.

<pre class="brush: cpp; title: ; notranslate" title="">void main()
{
   int16 pos;
   setup_timer_0(RTCC_INTERNAL|RTCC_DIV_1);
   setup_timer_1(T1_INTERNAL|T1_DIV_BY_1);
   setup_timer_2(T2_DISABLED,0,1);
   setup_comparator(NC_NC_NC_NC);
   setup_vref(FALSE);
   enable_interrupts(global);
   enable_interrupts(INT_TIMER1); 
   enable_interrupts(INT_RDA); 
Com isso iremos ter inicializado tudo que precisamos. Agora vamos aos “checks”. Usaremos o pino A0 para saída do interruptor, e A1 como Enable, A2 como saída para representar o PIC como “ocupado”.
    while(true) {                    //Loop para sempre
      pos=get_timer1()-period;      //Pega valor do timer, e subtrai do periodo
                                    //Iremos usar isso para o tOn
      if((pos&lt;=tOn)&amp;noteOn)         //Se a posição for menor que o tOn 
         OUTPUT_HIGH(PIN_A0);       //Liga saída A0
      else                          //Se não
         OUTPUT_LOW(PIN_A0);        //Desliga saída A0
         
    if(buffer_loaded) {             //Aqui iremos fazer o processo do buffer
                                    //Se o valor no byte1 for 0x90, e não houver
                                    //nota ligada, e o pino A1 estiver ligado 
       if((buffer[0] == 0x90) &amp; !(noteOn) &amp; INPUT(PIN_A1)) {
         period = notas[buffer[1]]; //Carrega o valor da nota no periodo
         tON = (0xFFFF-period)*0.1; //Faz o tOn ser 10% do periodo total
         noteOn = 1;                //Fala que a nota está ligada
         OUTPUT_HIGH(PIN_A2);       //Coloca saída A2 em alta, PIC ocupado
         loadedNote = buffer[1];    //Guarda o número da nota carregada
       }else if(buffer[0] == 0x80) {//Se for 0x80, é para desligar a nota
       if(buffer[1] == loadedNote) {//Verifica se a nota que esta tocando é a
                                    //mesma que está pedindo para desligar
            period = 0xFFFF;        //Reseta periodo
            noteOn = 0;             //Desliga nota
            OUTPUT_LOW(PIN_A2);     //Desliga saida A2, PIC Disponível
            loadedNote = 0x00;      //Zera nota carregada
       }
       }else if(buffer[0] == 0xB0) {
         period = 0xFFFF;           
         noteOn = 0;                
         OUTPUT_LOW(PIN_A2);        
         loadedNote = 0x00;
         buffer_counter = 0;
         buffer_loaded = 0;
       }
       buffer_loaded = 0;           //Libera o buffer para recarregamento
    }
   }
}
</pre>

Com isso temos nosso código completo!

Podemos usar os PIC&#8217;s em modo Pipeline para polifonia, ligando todas as recepções midis juntas, e as saídas A2 nas entradas A1 dos próximos, e fazendo operação OR entre as saídas. Colocarei mais detalhes no próximo tópico.

Créditos a ideia de serializar microcontroladores para a polifonia: Uzzors2k &#8211; <http://uzzors2k.4hv.org/index.php?page=midiinterrupter>