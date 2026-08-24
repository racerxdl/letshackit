---
title: "Desenhando com Canvas do HTML5 | Lets Hack It"
description: "Guia prático de HTML5 Canvas. Aprenda a criar gráficos, desenhar ondas senoidais e manipular pixels com JavaScript e Context 2D."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Desenhando com Canvas do HTML5

Escrito por Lucas Teske   
em 12 Setembro 2011

[Migrado do LetsHack It]

Alguns de vocês podem ter visto que tive alguns pequenos projetos usando o Canvas do HTML5 na EnergyLabs Brasil. Abaixo alguns projetos que fazem uso do Canvas:

> [Curva do Transístor](http://www.energylabs.com.br/el/tcalc)
> 
> [Gerador de Ondas Harmônicas](http://www.energylabs.com.br/el/hwg)
> 
> [Gerador de Fundo Animado](http://www.energylabs.com.br/el/bggen)

Porém nunca expliquei a ninguém como os fiz. Vou começar um simulador de gráficos onde você digita a fórmula e ele desenha o gráfico, e explicarei no caminho o que estou fazendo.

Acredito que será útil para muitas pessoas.

Bom irei postar como iniciar o Canvas e irei dormir. Mais tarde continuarei este post do Lets Hack It!

Para inicializar o Canvas:

```xml; title: 
<script type="text/javascript>
var canvas = document.getElementById("myCanvas");
var ctx = canvas.getContext("2d");

</script>
<center><canvas id="myCanvas" width="640" height="480">Seu
browser n&atilde;o suporta canvas!</canvas></center>
```

Entre as tags \*\*

É isso ai, mais tarde explico mais de como desenhar. Irei dormir agora! Boa madrugada a todos 😀  
——————————————————————————-

Não consegui fazer nada hoje praticamente. Acordei tarde e tive de sair correndo por que ainda tinha que deixar algo nos correios.

De qualquer maneira começarei agora a escrever, talvez não termine hoje, mas irei adiantar o máximo possível.

Vamos lá, cometi um erro no post anterior, as &nbsp;vars precisam ser declaradas dentro da função **draw()**&nbsp;por um motivo simples, o _browser_&nbsp;interpreta linha a linha o código javascript, e o javascript está antes da declaração da tag canvas. executaremos a função draw no método **onLoad** &nbsp;da tag **body**. Assim quando ele carregar tudo, executará o Draw e tudo funcionará perfeitamente.

Vamos lá, começar a desenhar, pintando o fundo de preto.

Dentro da tag script, colocaremos o seguinte:

```jscript; title: 
var width = 640;
var height = 480;

function draw() {
	var canvas = document.getElementById("canvas");
	var ctx = canvas.getContext("2d");
	ctx.fillStyle = '#000000';
	ctx.fillRect(0,0,width,height);
}
```

Definimos duas variáveis **width** e **height** &nbsp;para definirmos a largura e altura. Note que alterar esses valores não altera o tamanho do canvas, e sim a área onde nosso script desenhará. Se você for fazer uma tela de desenho diferente, não se esqueça de alterar a tag canvas também!

Isso deve resultar nisso:

![image](https://media.tumblr.com/tumblr_lrfzn3tJnp1qh7srd.png)

A função **fillStyle** &nbsp;define a cor do preenchimento como diz o próprio nome. Ela segue o mesmo padrão do HTML sendo cada cor composta de um _byte_ em hexa ( **00** a **FF** ) no padrão **RRGGBB** ( R = Vermelho, G = Verde, B = Azul ).

Já a função **fillRect** &nbsp;faz o preenchimento de um retângulo, seu uso é:

**fillRect(StartX,StartY,EndX,EndY);**

Onde:

> StartX, StartY -\> São as coordenadas do ponto superior esquerdo.
> 
> EndX, EndY -\> São as coordenadas do ponto inferior direito.

Simples não?

——————————————————————————-

Vamos começar a desenhar as linhas e colunas então. Para isso criaremos uma “caneta” para desenhar no canvas.

Usaremos basicamente 5 comandos do canvas:

> beginPath() =\> Inicia a operação “caneta” do canvas
> 
> moveTo(x,y) =\> Move a caneta para coordenada x,y
> 
> lineTo(x,y) =\> Marca o desenho da posição atual da caneta até x,y
> 
> stroke() =\> Efetua o desenho marcado
> 
> closePath() =\> Finaliza a operação “caneta” do canvas

Então vamos lá!

Mudaremos o tamanho do Canvas para 640×640 para termos uma área de desenho quadrada. Altere o **width** &nbsp;e **height** &nbsp;tanto no javascript quanto na tag canvas para este tamanho. Também alteraremos a cor usada anteriormente para preenchimento do fundo, para algo ligeiramente diferente do preto, no meu caso usei o #333333

Faremos tudo a uma relação para que haja uma linha e uma coluna cruzando exatamente no centro da tela. Tendo uma tela de desenho 640×640, a sua coluna central começará em **(0,width/2)**&nbsp;e terminará em **(height,width/2)**. Já sua linha central começará em **(height/2,0)** e terminará em **(height/2,width)**. Vamos fazer tudo baseado nessa informação.

Montaremos então 5 colunas e 5 linhas, isso da uma distância de **128px** &nbsp;entre elas. Vamos lá:

Antes de mais nada começaremos então a operação “caneta”:

```jscript; title: 
ctx.beginPath();
	ctx.lineWidth = 2;
	ctx.strokeStyle = '#EEEEEE';
```

Iniciada a operação caneta, podemos começar a projetar as colunas:

```jscript; title: 
var i;
	for(i=-2;i<=2;i++) {
		ctx.moveTo(width/2-128*i,0);
		ctx.lineTo(width/2-128*i,height);
	}
```

Vejam que eu usei uma fórmula na coordenada, onde a posição X da coluna será a largura dividida por 2 (centro) menos 128px vezes o numero da coluna. Começando por -2 (2 colunas antes da central) teremos a primeira coluna em X = largura/2 – 256.

Faremos agora as linhas, de maneira semelhante:

```jscript; title: 
for(i=-2;i<=2;i++) {
		ctx.moveTo(0,height/2-128*i);
		ctx.lineTo(width,height/2-128*i);
	}
```

Após isso, podemos mandar desenhar e encerrar a operação caneta.

```jscript; title: 
ctx.stroke(); //Desenhar
	ctx.closePath();
```

Isso nos resultará em algo desse jeito:

![image](https://media.tumblr.com/tumblr_lrg1nffed61qh7srd.png)  
——————————————————————————

Bom vamos desenhar algo agora então no gráfico. Uma função senoidal amarela.

Uma função senoidal é definida por **y = seno(x)**. Para fazermos este desenho, teremos que fazer um&nbsp;método chamado **varredura**. Como funciona? Simples!

Na escola quando vamos desenhar o gráfico de uma função, não pegamos vários valores de X, calculamos o Y e colocamos no plano cartesiano? Faremos algo bem semelhante aqui.

Considere que o X é número de pixels na horizontal e o Y é o número de pixels na vertical. Bem, na vertical ficará meio pequeno então faremos um controle de **amplitude** &nbsp;(“altura” da função). Cada 1 de Y valerá 10px…

Vamos começar então!

Usaremos a função **translate** &nbsp;para alterar o ponto de origem para o centro da tela **(width/2,height/2)**. Outro detalhe é que precisamos de uma interpolação para desenhar a onda bem. Faremos o seguinte então, temos metade da janela disponível para desenho da onda, isso da width/2 para o X. Faremos uma interpolação de 100 vezes para calcular os valores de seno.

```jscript; title: 
ctx.translate(width/2,height/2);
	ctx.beginPath();
	ctx.strokeStyle = '#EEEE00';
```

```jscript; title: 
ctx.moveTo(0,0);
	var x=0;;
	var amplitude = 0;
	while(x < width*50) {
		amplitude = Math.round(Math.sin(x/100)*100);
		ctx.lineTo(x/5,amplitude);
		x++;
	}
	ctx.stroke();
	ctx.closePath();
```

Começamos traduzindo o X e Y para width/2 e height/2 respectivamente, logo o 0,0 será o centro da tela (cruzamento da linha e coluna centrais).

Movemos a caneta para 0,0 e fizemos um laço iterativo que roda até o **x** &nbsp;ser igual a cinquenta vezes a largura da tela _[lembra que falei da interpolação? Considerando que onde desenhamos é largura/2, largura\*50 é uma interpolação de 100 vezes]._ A variável **amplitude** &nbsp;é usada para armazenar o valor do **Y** , onde usamos o **Math.sin(x/100)**&nbsp;_[Lembra da interpolação? Aqui temos que usar o x no tamanho real da tela!]_ e multiplicamos por 100 _[lembra que falei que cada Y valeria 100px?]_&nbsp;após isso arredondamos com o **Math.round** , afinal não existe pixel em números fracionários. Feito isso teremos um resultado assim:

![image](https://media.tumblr.com/tumblr_lrg4h1lupp1qh7srd.png)

Viram como é “fácil”?

Podemos fazer umas alterações também!

```jscript; title: 
ctx.translate(0,height/2);
	ctx.beginPath();
	ctx.strokeStyle = '#EEEE00';

	ctx.moveTo(0,0);
	var x=0;
	var amplitude = 0;
	while(x < (width/2)*100) {
		amplitude = Math.round(Math.sin(x/100)*300);
		ctx.lineTo(x/2,amplitude);
		x++;
	}
```

Isso irá gerar um resultado assim:

![image](https://media.tumblr.com/tumblr_lrg4r0YSaj1qh7srd.png)

Para clarificar um pouco as mudanças que fiz, aqui está um código que ficará mais fácil de entender o que cada coisa faz:

```jscript; title: 
var PosX = 0;
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
	while(x < (width/2)*Interpolacao) {
		amplitude = Math.round(Math.sin(x/Interpolacao)*AmplitudeM);
		ctx.lineTo(x/Periodo,amplitude);
		x++;
	}
	ctx.stroke();
	ctx.closePath();
```

Defini variáveis antes para esclarecer a devida função de cada coisa:

> PosX =\> Posição X real do 0 no plano cartesiano
> 
> PosY =\> Posição Y real do 0 no plano cartesiano
> 
> Interpolacao =\> Numero de pontos para a interpolação
> 
> AmplitudeM =\> Multiplicador de amplitude
> 
> Periodo =\> Divisor do Período

Faça uma alteração você mesmo nesses valores e veja a diferença!

Podemos fazer qualquer fórmula nisso, veja só o resultado de **y = seno(x)\*sqrt(x)**

**![image](https://media.tumblr.com/tumblr_lrg568jhJp1qh7srd.png)**

Tente você também!

Código:

> [http://codepad.org/xzXGlBkd](http://codepad.org/xzXGlBkd)

## Cite este artigo

### Citação sugerida

Lucas Teske. “Desenhando com Canvas do HTML5.” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/09/desenhando-com-canvas-do-html5/](https://lucasteske.dev/pt/2011/09/desenhando-com-canvas-do-html5/).

### BibTeX

```
@misc{teske2011desenhandocomcanvasdohtml5,
  author = {Lucas Teske},
  title = {Desenhando com Canvas do HTML5},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/09/desenhando-com-canvas-do-html5/}
}
```
