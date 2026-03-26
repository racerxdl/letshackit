---
id: 5
title: Desenhando com Canvas do HTML5
date: 2011-09-12 16:10:53-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=25
permalink: /2011/09/desenhando-com-canvas-do-html5/
categories:
- Programming
tags:
- HTML5
- Canvas
- JavaScript
- Web Graphics
- 2D Drawing
- Context 2D
- Sine Wave
- Cartesian Coordinates
- Pixel Manipulation
- Web Development
description: Guia prático de HTML5 Canvas. Aprenda a criar gráficos, desenhar ondas
  senoidais e manipular pixels com JavaScript e Context 2D.
enriched: true
---
[ Migrado do LetsHack It ]

<div class="regular_post_body">
  <p>
    Alguns de vocês podem ter visto que tive alguns pequenos projetos usando o Canvas do HTML5 na EnergyLabs Brasil. Abaixo alguns projetos que fazem uso do Canvas:
  </p>
  
  <blockquote>
    <p>
      <a href="http://www.energylabs.com.br/el/tcalc" target="_blank">Curva do Transístor</a>
    </p>
    
    <p>
      <a href="http://www.energylabs.com.br/el/hwg" target="_blank">Gerador de Ondas Harmônicas</a>
    </p>
    
    <p>
      <a href="http://www.energylabs.com.br/el/bggen" target="_blank">Gerador de Fundo Animado</a>
    </p>
  </blockquote>
  
  <p>
    Porém nunca expliquei a ninguém como os fiz. Vou começar um simulador de gráficos onde você digita a fórmula e ele desenha o gráfico, e explicarei no caminho o que estou fazendo.
  </p>
  
  <p>
    Acredito que será útil para muitas pessoas.
  </p>
</div>

<!--more-->

Bom irei postar como iniciar o Canvas e irei dormir. Mais tarde continuarei este post do Lets Hack It!

Para inicializar o Canvas:

<pre class="brush: xml; title: ; notranslate" title="">&lt;script type="text/javascript&gt;
var canvas = document.getElementById("myCanvas");
var ctx = canvas.getContext("2d");

&lt;/script&gt;
&lt;center&gt;&lt;canvas id="myCanvas" width="640" height="480"&gt;Seu
browser n&amp;atilde;o suporta canvas!&lt;/canvas&gt;&lt;/center&gt;

</pre>

Entre as tags **<script>** iremos colocar o código em JavaScript para manipular o canvas. A tag **<canvas>** define onde será desenhado, o _width e height_ definem o tamanho do canvas. O conteúdo entre as tags define o texto que será mostrado caso o Browser não suporte Canvas.

É isso ai, mais tarde explico mais de como desenhar. Irei dormir agora! Boa madrugada a todos 😀  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Não consegui fazer nada hoje praticamente. Acordei tarde e tive de sair correndo por que ainda tinha que deixar algo nos correios.

De qualquer maneira começarei agora a escrever, talvez não termine hoje, mas irei adiantar o máximo possível.

Vamos lá, cometi um erro no post anterior, as  vars precisam ser declaradas dentro da função **draw()** por um motivo simples, o _browser_ interpreta linha a linha o código javascript, e o javascript está antes da declaração da tag canvas. executaremos a função draw no método **onLoad** da tag **body**. Assim quando ele carregar tudo, executará o Draw e tudo funcionará perfeitamente.

Vamos lá, começar a desenhar, pintando o fundo de preto.

Dentro da tag script, colocaremos o seguinte:

<pre class="brush: jscript; title: ; notranslate" title="">var width = 640;
var height = 480;

function draw() {
	var canvas = document.getElementById("canvas");
	var ctx = canvas.getContext("2d");
	ctx.fillStyle = '#000000';
	ctx.fillRect(0,0,width,height);
}
</pre>

Definimos duas variáveis **width** e **height** para definirmos a largura e altura. Note que alterar esses valores não altera o tamanho do canvas, e sim a área onde nosso script desenhará. Se você for fazer uma tela de desenho diferente, não se esqueça de alterar a tag canvas também!

Isso deve resultar nisso:

![image](https://media.tumblr.com/tumblr_lrfzn3tJnp1qh7srd.png) 

A função **fillStyle** define a cor do preenchimento como diz o próprio nome. Ela segue o mesmo padrão do HTML sendo cada cor composta de um _byte_ em hexa ( **00** a **FF** ) no padrão **RRGGBB** ( R = Vermelho, G = Verde, B = Azul ).

Já a função **fillRect** faz o preenchimento de um retângulo, seu uso é:

**fillRect(StartX,StartY,EndX,EndY);**

Onde:

> <div>
>   <p>
>     StartX, StartY -> São as coordenadas do ponto superior esquerdo.
>   </p>
>   
>   <p>
>     EndX, EndY -> São as coordenadas do ponto inferior direito.
>   </p>
> </div>

Simples não?

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Vamos começar a desenhar as linhas e colunas então. Para isso criaremos uma &#8220;caneta&#8221; para desenhar no canvas.

Usaremos basicamente 5 comandos do canvas:

> <div>
>   <p>
>     beginPath() => Inicia a operação &#8220;caneta&#8221; do canvas
>   </p>
>   
>   <p>
>     moveTo(x,y) => Move a caneta para coordenada x,y
>   </p>
>   
>   <p>
>     lineTo(x,y) => Marca o desenho da posição atual da caneta até x,y
>   </p>
>   
>   <p>
>     stroke() => Efetua o desenho marcado
>   </p>
>   
>   <p>
>     closePath() => Finaliza a operação &#8220;caneta&#8221; do canvas
>   </p>
> </div>

Então vamos lá!

Mudaremos o tamanho do Canvas para 640&#215;640 para termos uma área de desenho quadrada. Altere o **width** e **height** tanto no javascript quanto na tag canvas para este tamanho. Também alteraremos a cor usada anteriormente para preenchimento do fundo, para algo ligeiramente diferente do preto, no meu caso usei o #333333

Faremos tudo a uma relação para que haja uma linha e uma coluna cruzando exatamente no centro da tela. Tendo uma tela de desenho 640&#215;640, a sua coluna central começará em **(0,width/2)** e terminará em **(height,width/2)**. Já sua linha central começará em **(height/2,0)** e terminará em **(height/2,width)**. Vamos fazer tudo baseado nessa informação.

Montaremos então 5 colunas e 5 linhas, isso da uma distância de **128px** entre elas. Vamos lá:

Antes de mais nada começaremos então a operação &#8220;caneta&#8221;:

<pre class="brush: jscript; title: ; notranslate" title="">ctx.beginPath();
	ctx.lineWidth = 2;
	ctx.strokeStyle = '#EEEEEE';
</pre>

Iniciada a operação caneta, podemos começar a projetar as colunas:

<pre class="brush: jscript; title: ; notranslate" title="">var i;
	for(i=-2;i&lt;=2;i++) {
		ctx.moveTo(width/2-128*i,0);
		ctx.lineTo(width/2-128*i,height);
	}
</pre>

Vejam que eu usei uma fórmula na coordenada, onde a posição X da coluna será a largura dividida por 2 (centro) menos 128px vezes o numero da coluna. Começando por -2 (2 colunas antes da central) teremos a primeira coluna em X = largura/2 &#8211; 256.

Faremos agora as linhas, de maneira semelhante:

<pre class="brush: jscript; title: ; notranslate" title="">for(i=-2;i&lt;=2;i++) {
		ctx.moveTo(0,height/2-128*i);
		ctx.lineTo(width,height/2-128*i);
	}</pre>

Após isso, podemos mandar desenhar e encerrar a operação caneta.

<pre class="brush: jscript; title: ; notranslate" title="">ctx.stroke(); //Desenhar
	ctx.closePath();
</pre>

Isso nos resultará em algo desse jeito:

![image](https://media.tumblr.com/tumblr_lrg1nffed61qh7srd.png)  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;

Bom vamos desenhar algo agora então no gráfico. Uma função senoidal amarela.

Uma função senoidal é definida por **y = seno(x)**. Para fazermos este desenho, teremos que fazer um método chamado **varredura**. Como funciona? Simples!

Na escola quando vamos desenhar o gráfico de uma função, não pegamos vários valores de X, calculamos o Y e colocamos no plano cartesiano? Faremos algo bem semelhante aqui.

Considere que o X é número de pixels na horizontal e o Y é o número de pixels na vertical. Bem, na vertical ficará meio pequeno então faremos um controle de **amplitude** (&#8220;altura&#8221; da função). Cada 1 de Y valerá 10px&#8230;

Vamos começar então!

Usaremos a função **translate** para alterar o ponto de origem para o centro da tela **(width/2,height/2)**. Outro detalhe é que precisamos de uma interpolação para desenhar a onda bem. Faremos o seguinte então, temos metade da janela disponível para desenho da onda, isso da width/2 para o X. Faremos uma interpolação de 100 vezes para calcular os valores de seno.

<pre class="brush: jscript; title: ; notranslate" title="">ctx.translate(width/2,height/2);
	ctx.beginPath();
	ctx.strokeStyle = '#EEEE00';
</pre>

<pre class="brush: jscript; title: ; notranslate" title="">ctx.moveTo(0,0);
	var x=0;;
	var amplitude = 0;
	while(x &lt; width*50) {
		amplitude = Math.round(Math.sin(x/100)*100);
		ctx.lineTo(x/5,amplitude);
		x++;
	}
	ctx.stroke();
	ctx.closePath();</pre>

Começamos traduzindo o X e Y para width/2 e height/2 respectivamente, logo o 0,0 será o centro da tela (cruzamento da linha e coluna centrais).

Movemos a caneta para 0,0 e fizemos um laço iterativo que roda até o **x** ser igual a cinquenta vezes a largura da tela _[lembra que falei da interpolação? Considerando que onde desenhamos é largura/2, largura*50 é uma interpolação de 100 vezes]._ A variável **amplitude** é usada para armazenar o valor do **Y**, onde usamos o **Math.sin(x/100)** _[Lembra da interpolação? Aqui temos que usar o x no tamanho real da tela!]_ e multiplicamos por 100 _[lembra que falei que cada Y valeria 100px?]_ após isso arredondamos com o **Math.round**, afinal não existe pixel em números fracionários. Feito isso teremos um resultado assim:

![image](https://media.tumblr.com/tumblr_lrg4h1lupp1qh7srd.png) 

Viram como é &#8220;fácil&#8221;?

Podemos fazer umas alterações também!

<pre class="brush: jscript; title: ; notranslate" title="">ctx.translate(0,height/2);
	ctx.beginPath();
	ctx.strokeStyle = '#EEEE00';

	ctx.moveTo(0,0);
	var x=0;
	var amplitude = 0;
	while(x &lt; (width/2)*100) {
		amplitude = Math.round(Math.sin(x/100)*300);
		ctx.lineTo(x/2,amplitude);
		x++;
	}
</pre>

Isso irá gerar um resultado assim:

![image](https://media.tumblr.com/tumblr_lrg4r0YSaj1qh7srd.png) 

Para clarificar um pouco as mudanças que fiz, aqui está um código que ficará mais fácil de entender o que cada coisa faz:

<pre class="brush: jscript; title: ; notranslate" title="">var PosX = 0;
	var PosY = height/2;
	var Interpolacao = 100;
	var AmplitudeM = 300;
	var Periodo = 2;

	ctx.translate(PosX,PosY);
	ctx.beginPath();
	ctx.strokeStyle = '#EEEE00';

	ctx.moveTo(0,0);
	var x=0;
	var amplitude = 0;
	while(x &lt; (width/2)*Interpolacao) {
		amplitude = Math.round(Math.sin(x/Interpolacao)*AmplitudeM);
		ctx.lineTo(x/Periodo,amplitude);
		x++;
	}
	ctx.stroke();
	ctx.closePath();
</pre>

Defini variáveis antes para esclarecer a devida função de cada coisa:

> <div>
>   <p>
>     PosX => Posição X real do 0 no plano cartesiano
>   </p>
>   
>   <p>
>     PosY => Posição Y real do 0 no plano cartesiano
>   </p>
>   
>   <p>
>     Interpolacao => Numero de pontos para a interpolação
>   </p>
>   
>   <p>
>     AmplitudeM => Multiplicador de amplitude
>   </p>
>   
>   <p>
>     Periodo => Divisor do Período
>   </p>
> </div>

Faça uma alteração você mesmo nesses valores e veja a diferença!

Podemos fazer qualquer fórmula nisso, veja só o resultado de **y = seno(x)*sqrt(x)**

**![image](https://media.tumblr.com/tumblr_lrg568jhJp1qh7srd.png)**

Tente você também!

Código:

> <div>
>   <p>
>     <a href="http://codepad.org/xzXGlBkd">http://codepad.org/xzXGlBkd</a>
>   </p>
> </div>