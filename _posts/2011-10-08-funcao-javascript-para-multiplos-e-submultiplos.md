---
id: 6
title: Função Javascript para Multiplos e Submultiplos
date: 2011-10-08T05:50:12-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=30
permalink: /2011/10/funcao-javascript-para-multiplos-e-submultiplos/
categories:
  - Sem categoria
---
Bom, estava montando uma outra calculadora aqui para a [EnergyLabs Brasil](http://www.energylabs.com.br), e quis fazer algo mais legalzinho. Fiz uma função em javascript que concatena o valor com o submúltiplo, e já faz as multiplicações necessárias além de arrendondar para duas casas decimais.

Não entendeu? Bom vou exemplificar.

Em física se usa muito múltiplos e submúltiplos para ajudar a escrever unidades. Por exemplo, estamos habituados com a unidade **segundo** no nosso dia a dia. Para representarmos 0,1 segundo, podemos representar como 100ms (100 milissegundos), para 0,0001 segundo, podemos representar como 100us (100 microssegundos), e assim por diante. Isso são os submúltiplos. Ao invés de escrevermos 0,0001 escrevemos 100 \* 10^-6 (100 \* 0,000001 que é 0,0001) ou 100us. Os mais comuns submúltiplos são:

  1. mili &#8211; **m**  &#8211; 10^-3
  2. micro &#8211; **µ** &#8211; 10^-6
  3. nano &#8211; **n** &#8211; 10^-9
  4. pico &#8211; **p &#8211;** 10^-12

Então vamos lá para a função:

<pre class="brush: jscript; title: ; notranslate" title="">function putunit(v,unit) {
	var lastunit = '';
	var units = ["m","µ","n","p"];
	var counter= 0;
	var value = v;
	while(value &lt; 1) {
		lastunit = units[counter];
		counter++;
		value=value*1e3;
		if(counter==5) break;
	}
	value = Math.round(value*1e2)/1e2;
	return "&lt;B&gt;"+value+"&lt;/B&gt; "+lastunit+unit;
}
</pre>

Como usar? Bem simples:

<pre class="brush: jscript; title: ; notranslate" title="">var i = 0.015;
	var resultado = putunit(i,"s");
</pre>

Quer um exemplo mais prático? Vamos lá então, uma página HTML 😀

<pre class="brush: jscript; title: ; notranslate" title="">function putunit(v,unit) {
	var lastunit = '';
	var units = ["m","µ","n","p"];
	var counter= 0;
	var value = v;
	while(value &lt; 1) {
		lastunit = units[counter];
		counter++;
		value=value*1e3;
		if(counter==5) break;
	}
	value = Math.round(value*1e2)/1e2;
	return "&lt;B&gt;"+value+"&lt;/B&gt; "+lastunit+unit;
}

function pegarvalor() {
	var i = parseFloat(document.getElementById('valor').value);
	document.getElementById('resultado').innerHTML = putunit(i,"s");
}
</pre>

<pre class="brush: xml; title: ; notranslate" title="">Insira um valor: &lt;input type="text" id="valor" name="valor"&gt;
&lt;input type="button" onClick="pegarvalor();" value="Pegar"&gt;&lt;BR&gt;
Resultado: &lt;div id="resultado"&gt;&lt;/div&gt;
</pre>

Ou se preferir ver no Codepad: <http://codepad.org/hGDQsbT1>

Faça o teste e terá resultados assim:

![image](https://media.tumblr.com/tumblr_lsrlqnEhTa1qh7srd.png) 

![image](https://media.tumblr.com/tumblr_lsrlqtkXYj1qh7srd.png) 

![image](https://media.tumblr.com/tumblr_lsrlqzB9R51qh7srd.png) 

Viu como é prático? Você pode usar a mesma ideia da função para os múltiplos também!