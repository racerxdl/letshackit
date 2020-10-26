---
title: Introdução a FPGA
date: 2020-06-14T16:17:00-03:00
author: Lucas Teske
layout: post
image: /assets/FPGA.jpg
categories:
  - Portugues
  - Hacking
  - FPGA
  - Hardware
  - Eletrônica
  - Verilog

tags:
  - Hacking
  - FPGA
  - ICEWolf
  - IceStick
  - ECP5
  - Lattice
  - Hardware
  - Eletrônica
  - Verilog
---

Esta é a primeira parte do guia de programação para FPGAs! Este guia irá virar eventualmente um `verilog4noobs` para qualquer pessoa que quiser iniciar na área de programação de hardware possa ter um jeito fácil de conseguir! Iremos começar a explicar o que é um FPGA e como ele funciona.

Para quem preferir, este artigo foi feito em base na Livestream sobre Verilog que fiz a um tempo atrás e está disponível no YouTube: [https://www.youtube.com/watch?v=BcKwqju5gxA](https://www.youtube.com/watch?v=BcKwqju5gxA)

# O que é um FPGA

FPGA é uma abreviatura para Field Programmable Gate Array, ou Matriz de Portas Programáveis em Campo. O termo `campo` usado aqui se refere ao fato de que o chip pode ser programado após sair da fábrica. O termo `portas` se referem a portas lógicas.

Alguns exemplos de portas lógicas:

![Portas Lógicas](/assets/posts/introducao_a_fpga/logic-gates.svg)*Portas Lógicas - Remix de [https://commons.wikimedia.org/wiki/File:Circuit_elements.svg](https://commons.wikimedia.org/wiki/File:Circuit_elements.svg)*

## Portas Lógicas

As portas lógicas efetuam operações lógicas entre bits, e podem ter **N** entradas e uma saída. O FPGA é uma matriz de portas lógicas as quais podem ser interligadas para gerar circuitos lógicos equivalentes a qualquer chip desejado. Portas lógicas são blocos bem simples, e geralmente podem ser representados com poucos transístores. Por exemplo, dado `A`, `B` entradas e `Q` saída. Podemos implementar portas NOT, NAND e NOR destas maneiras:

![Porta Inversora (NOT) em transístores](/assets/posts/introducao_a_fpga/logic-not-transistor.svg)*Representação em transístores bipolares de uma **Porta Inversora** (NOT)*

![Porta Não-E (NAND) em transístores](/assets/posts/introducao_a_fpga/logic-nand-transistor.svg)*Representação em transístores bipolares de uma **Porta Não-E** (NAND)*

![Porta Não-OU (NOR) em transístores](/assets/posts/introducao_a_fpga/logic-nor-transistor.svg)*Representação em transístores bipolares de uma **Porta Não-OU** (NOR)*

As operações lógicas realizadas pelas portas lógicas descritas seguem a seguinte tabela da verdade:

<div class="truth-table-holder">
  <div class="truth-table-container">
    <table id="andtable" class="truth">
      <tbody>
        <tr>
          <td colspan=4><B>Porta E</B></td>
        </tr>
        <tr>
          <th>A</th>
          <th>B</th>
          <th class="dv"></th>
          <th>A & B</th>
        </tr>
        <tr>
          <td>0</td>
          <td>0</td>
          <td class="dv"></td>
          <td class="mc">0</td>
        </tr>
        <tr>
          <td>0</td>
          <td>1</td>
          <td class="dv"></td>
          <td class="mc">0</td>
        </tr>
        <tr>
          <td>1</td>
          <td>0</td>
          <td class="dv"></td>
          <td class="mc">0</td>
        </tr>
        <tr>
          <td>1</td>
          <td>1</td>
          <td class="dv"></td>
          <td class="mc">1</td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="truth-table-container">
    <table id="ortable" class="truth">
      <tbody>
        <tr>
          <td colspan=4><B>Porta OU</B></td>
        </tr>
        <tr>
          <th>A</th>
          <th>B</th>
          <th class="dv"></th>
          <th>A | B</th>
        </tr>
        <tr>
          <td>0</td>
          <td>0</td>
          <td class="dv"></td>
          <td class="mc">0</td>
        </tr>
        <tr>
          <td>0</td>
          <td>1</td>
          <td class="dv"></td>
          <td class="mc">1</td>
        </tr>
        <tr>
          <td>1</td>
          <td>0</td>
          <td class="dv"></td>
          <td class="mc">1</td>
        </tr>
        <tr>
          <td>1</td>
          <td>1</td>
          <td class="dv"></td>
          <td class="mc">1</td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="truth-table-container">
    <table id="nottable" class="truth">
      <tbody>
        <tr>
          <td colspan=3><B>Porta Inversora</B></td>
        </tr>
        <tr>
          <th>A</th>
          <th class="dv"></th>
          <th>~A</th>
        </tr>
        <tr>
          <td>0</td>
          <td class="dv"></td>
          <td class="mc">1</td>
        </tr>
        <tr>
          <td>1</td>
          <td class="dv"></td>
          <td class="mc">0</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
<BR/>

Porém você nunca sabe especificamente qual porta irá usar em qual posição do FPGA. Por essa dúvida, seria nescessário cada `bloco` do FPGA conter todos os tipos básicos de portas lógicas para que na hora de ligar, pudesse escolher a porta correta. Isso tornaria o chip ineficiente pois de N portas que um bloco teria, você apenas usaria uma.

Felizmente o FPGA não usa portas lógicas na sua maneira primitiva. Ao invés disso ele usa uma "porta programável" feita com um circuito lógico chamado **multiplexador**.

## O que é um Multiplexador

Um multiplexador é uma unidade lógica de N entradas com apenas uma saída, e log2(N) entradas de controle. Abaixo segue um exemplo de um multiplexador de 8 entradas.

![Multiplexador 8 entradas](/assets/posts/introducao_a_fpga/mux.svg)*

Neste multiplexador temos:

* `X0-X7`   => Entrada de dados
* `A, B, C` => Entrada de controle
* `O`       => Saída

As entradas A, B e C formam um número de 3 bits que representam qual entrada X estará ligada a saída O.
<BR/>

<div class="truth-table-container">
  <table id="muxtable" class="truth">
    <tbody>
      <tr>
        <td colspan=5><B>MUX8</B></td>
      </tr>
      <tr>
        <th>A</th>
        <th>B</th>
        <th>C</th>
        <th class="dv"></th>
        <th>O</th>
      </tr>
      <tr>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
      </tr>
      <tr>
        <td>0</td>
        <td>0</td>
        <td>1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
      </tr>
      <tr>
        <td>0</td>
        <td>1</td>
        <td>0</td>
        <td class="dv"></td>
        <td class="mc">X2</td>
      </tr>
      <tr>
        <td>0</td>
        <td>1</td>
        <td>1</td>
        <td class="dv"></td>
        <td class="mc">X3</td>
      </tr>
      <tr>
        <td>1</td>
        <td>0</td>
        <td>0</td>
        <td class="dv"></td>
        <td class="mc">X4</td>
      </tr>
      <tr>
        <td>1</td>
        <td>0</td>
        <td>1</td>
        <td class="dv"></td>
        <td class="mc">X5</td>
      </tr>
      <tr>
        <td>1</td>
        <td>1</td>
        <td>0</td>
        <td class="dv"></td>
        <td class="mc">X6</td>
      </tr>
      <tr>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td class="dv"></td>
        <td class="mc">X7</td>
      </tr>
    </tbody>
  </table>
</div>

Com a sua contra-parte (demultiplexador ou demux), é possível transferir vários canais de dados em apenas um canal, desde que ambos Mux e Demux estejam com os valores A,B,C corretamente configurados. Porém para FPGA's MUX geralmente são usados de maneiras diferentes. Em lógica digital, você pode usar um MUX para implementar *qualquer* porta lógica associando as entradas do mux a valores pré-definidos.

## Implementando portas lógicas com Multiplexador

A implementação de portas lógicas pode parecer complexa, mas para portas simples (NOT, OR, AND) é bem simples de entender o funcionamento. Vamos usar um MUX de 2 entradas (1 bit).

![Multiplexador 2 entradas](/assets/posts/introducao_a_fpga/mux2.svg)*

Neste caso a tabela da verdade é bem mais simples:

<div class="truth-table-container">
  <table id="mux2table" class="truth">
    <tbody>
      <tr>
        <td colspan=4><B>MUX2</B></td>
      </tr>
      <tr>
        <th>A</th>
        <th class="dv"></th>
        <th>O</th>
      </tr>
      <tr>
        <td>0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
      </tr>
      <tr>
        <td>1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
      </tr>
    </tbody>
  </table>
</div>
<BR/>

De modo que se quisermos que o MUX2 vire uma porta inversora, podemos apenas pré-configurar as entradas X0 e X1 com os valores 1 e 0.

<div class="truth-table-container">
  <table id="mux2table" class="truth">
    <tbody>
      <tr>
        <td colspan=6><B>MUX2-NOT</B></td>
      </tr>
      <tr>
        <th>X0</th>
        <th>X1</th>
        <th>A</th>
        <th class="dv"></th>
        <th>O porta</th>
        <th>O valor</th>
      </tr>
      <tr>
        <td>1</td>
        <td>0</td>
        <td class="tv">0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
        <td class="mc">1</td>
      </tr>
      <tr>
        <td>1</td>
        <td>0</td>
        <td class="tv">1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
        <td class="mc">0</td>
      </tr>
    </tbody>
  </table>
</div>
<BR/>

Caso queiramos fazer uma porta AND, podemos configurar a entrada X0 como 0, e usar a entrada X1 e A como entradas da porta AND

<div class="truth-table-container">
  <table id="mux2table" class="truth">
    <tbody>
      <tr>
        <td colspan=6><B>MUX2-AND</B></td>
      </tr>
      <tr>
        <th>X0 (FIXO)</th>
        <th>X1 (AND0)</th>
        <th>A (AND1)</th>
        <th class="dv"></th>
        <th>O porta</th>
        <th>O valor</th>
      </tr>
      <tr>
        <td>0</td>
        <td class="tv">0</td>
        <td class="tv">0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
        <td class="mc">0</td>
      </tr>
      <tr>
        <td>0</td>
        <td class="tv">0</td>
        <td class="tv">1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
        <td class="mc">0</td>
      </tr>
      <tr>
        <td>0</td>
        <td class="tv">1</td>
        <td class="tv">0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
        <td class="mc">0</td>
      </tr>
      <tr>
        <td>0</td>
        <td class="tv">1</td>
        <td class="tv">1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
        <td class="mc">1</td>
      </tr>
    </tbody>
  </table>
</div>
<BR/>

Ou no caso de uma porta OR, fixamos o valor de X1 em 1 e usamos X0 e A como operadores OR.

<div class="truth-table-container">
  <table id="mux2table" class="truth">
    <tbody>
      <tr>
        <td colspan=6><B>MUX2-OR</B></td>
      </tr>
      <tr>
        <th>X0 (OR0)</th>
        <th>X1 (FIXO)</th>
        <th>A (OR1)</th>
        <th class="dv"></th>
        <th>O porta</th>
        <th>O valor</th>
      </tr>
      <tr>
        <td class="tv">0</td>
        <td>1</td>
        <td class="tv">0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
        <td class="mc">0</td>
      </tr>
      <tr>
        <td class="tv">0</td>
        <td>1</td>
        <td class="tv">1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
        <td class="mc">1</td>
      </tr>
      <tr>
        <td class="tv">1</td>
        <td>1</td>
        <td class="tv">0</td>
        <td class="dv"></td>
        <td class="mc">X0</td>
        <td class="mc">1</td>
      </tr>
      <tr>
        <td class="tv">1</td>
        <td>1</td>
        <td class="tv">1</td>
        <td class="dv"></td>
        <td class="mc">X1</td>
        <td class="mc">1</td>
      </tr>
    </tbody>
  </table>
</div>
<BR/>

Existem outras operações que podem ser implementadas usando multiplexadores, inclusive operações mais complexas caso o multiplexador tenha mais entradas. Este uso é frequentemente chamado de Lookup-Table (ou Tabela de Consulta em português). Os detalhes de como criar operações não serão discutidos aqui (porém se quiserem, posso fazer um artigo no futuro sobre :) ), mas com essas informações já conseguimos explicar como funciona as células do FPGA!

## "LUT" Lookup-Table dos FPGAs

Cada célula do FPGA contém (em geral) uma LUT (Lookup-Table), um Flip-Flop tipo D e um mux 2:1.

![Célula Lógica do FPGA](/assets/posts/introducao_a_fpga/fpga-logic-cell.svg)*Célula Lógica do FPGA*

O flip-flop serve para sincronização dos dados quando a operação é feita sob um domínio de um clock (um sinal de sincronia). Já o MUX 2:1 serve para selecionar se aquela célula será sincronizada com algo ou não (ela alterna entre a saída do flip-flop e a saída direto da LUT).

As LUT's seguem o princípio da reprogramabilidade do multiplexador como foi comentado na seção anterior, onde cada uma das entradas pode estar ligada a um nível lógico fixo ( 0 ou 1 ) ou a outras células / Pinos de entrada. Cada célula independente pode não fazer muita coisa por sí, porém interligadas a outras células podem fazer praticamente qualquer coisa!

# O que é uma HDL

HDL significa Hardware Description Language (ou Linguagem de Descrição de Hardware). Uma HDL serve para abstrair os conceitos de portas lógicas e células do FPGA para um nível onde fique mais fácil de pensar na lógica do programa. Uma HDL é efetivamente traduzida a netlist (lista de nós) de pseudo-LUTs que será usada para preparar o conjunto de dados que irá efetivamente ligar as células dentro do FPGA.

As duas linguagens mais tradicionais são VHDL e Verilog. Ambas são suportadas pela grande maioria de ferramentas de FPGA especificas dos fabricantes e também das de código fonte aberto.


```verilog
// Exemplo em Verilog
module contador ( // Definição de entradas e saídas do módulo
  out     ,  // Saída do contador
  enable  ,  // Sinal de ativação do contador
  clk     ,  // Sinal de clock
  reset      // Sinal de reset
);
// ------------- Portas de saída ----------
    output [7:0] out; // Saída de 8 bits
// ------------ Portas de Entrada ---------
    input enable, clk, reset;
// ------------ Variáveis Internas --------
    reg [7:0] out; // Contador de 8 bits, associado a saída out

// ------------- Código começa aqui -------

always @(posedge clk)
if (reset) begin
  out <= 8'b0 ;
end else if (enable) begin
  out <= out + 1;
end

endmodule
```

```vhdl
-- Exemplo em VHDL
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;

-- Definição de entradas e saídas do módulo
entity contador is
  port (
    cout   :out std_logic_vector (7 downto 0); -- Saída de 8 bits do contador
    enable :in  std_logic;                     -- Sinal de ativação do contador
    clk    :in  std_logic;                     -- Sinal de clock
    reset  :in  std_logic                      -- Sinal de reset
  );
end entity;

-- Definição do funcionamento do módulo
architecture rtl of contador is
  signal count :std_logic_vector (7 downto 0);
begin
  process (clk, reset) begin
    if (reset = '1') then
      count <= (others=>'0');
    elsif (rising_edge(clk)) then
      if (enable = '1') then
        count <= count + 1;
      end if;
    end if;
  end process;
  cout <= count;
end architecture;
```

Existe outro processo de geração que usam linguagens de mais alto nível (por exemplo C++ ou Python), este processo se chama High Level Synthesis (Síntese de Alto Nível), onde o código do FPGA é construido programaticamente em uma linguagem de mais alto nível e no fim é gerado um código Verilog / VHDL para sintetização habitual. Alguns dos processos geram diretamente a netlist, porém muitos softwares de empresas de FPGA usam padrões próprios de netlist o que pode tornar um problema o suporte.

# Processo de "compilação" (sintentização)

No processo de compilação, ou melhor dizendo, sintetização (que é o termo adequado pra esse processo) um código escrito em HDL se torna uma netlist que será usada para construção do que será o código que ficará na memória do FPGA. Neste processo as entradas e saídas da netlist tem nomes simbólicos que apontam para alguma entrada/saída do chip. A netlist é agnóstica a esses nomes e eles só representaram algo significativo para os processos finais da síntese.

Neste passo são feitas várias otimizações do circuito lógico para que haja o mínimo possível de nós na netlist. Algumas dessas otimizações podem ser feitas assumindo algum FPGA especifico (pelo tamanho de sua LUT). Após a netlist pronta, as ferramentas deverão "achar um jeito de encaixar" o netlist no FPGA alvo. Este passo é chamado Place & Route (Colocar e Rotear)

# Place & Route

O processo de place & route é muito similar a quando um engenheiro desenha uma placa de circuito impresso. Você coloca os componentes na placa e liga os fios entre eles. Dependendo do circuito isto pode ser fácil ou difícil. Imagine que quanto mais espaço da placa seus componentes ocupar, mais difícil é de achar um caminho para todas suas trilhas. O mesmo ocorre com o FPGA.

Este passo é **sempre** especifico do FPGA de destino, onde parâmetro como linhas globais de clock, tamanho de LUT e posição de LUT são levadas em conta. Além disso, algumas ferramentas permitem colocar restrições nos parâmetro de delay, clock mínimo e tensão elétrica para as rotas. Com todas essas informações, o programa de Place & Route irá tentar achar uma configuração válida para aquele FPGA.

Dependendo da complexidade do projeto, o tempo pode ser desde alguns segundos até alguns dias. Além disso pode também não ser possível rotear o seu código no FPGA destino, mesmo que este não ocupe o FPGA inteiro!

Após o processo estar completo, a netlist será incrementada com a posição **física** dos nós dentro do FPGA, por exemplo:

```
// Antes do Place & Route
LUT4(0,1,0,1) -> LUT4(1,1,0,0)
// Depois do Place & Route
LUT4_0.0(0,1,0,1) -> LUT4_1.1(1,1,0,0) // one 0.0 e 1.1 são as coordenadas dentro do chip
```

Após isso seu programa está completo, e o único passo restante é gerar a sequência de bits que irão programar o FPGA para esta configuração!

# Geração de Bitstream

A ultima etapa do processo é a geração do bitstream. Este gerador recebe como entrada a netlist complementada com as posições físicas das células do FPGA e como elas se interligam e converte para uma sequência de bits proprietária do FPGA. Cada marca e modelo de FPGA tem uma sequência especifica para programação e sua programação também pode variar do meio de origem.

Por exemplo, um FPGA pode ser programado via:

* "Porta Serial" (Na verdade pino de programação serial)
* JTAG
* Memória Flash SPI

# Next steps...

Todos estes processos vão ficar mais claros nos próximos artigos! Esta é a primeira parte de uma série de posts sobre Verilog e programação para FPGA. Farei assim que possível o próximo post :D 

Espero que tenham gostado!