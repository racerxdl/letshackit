---
id: 32
title: Função Javascript para Múltiplos e Submúltiplos
date: 2011-10-09T19:24:31-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=32
permalink: /2011/10/funcao-javascript-para-multiplos-e-submultiplos-2/
categories:
  - Sem categoria
---
Bom, vocês devem ter visto meu tópico anterior sobre [Função Javascript para Submúltiplos](http://letshackit.energylabs.com.br/post/11195814648/funcao-javascript-para-submultiplos) e eu resolvi fazer uma função mais completa. Agora abrangendo mais submúltiplos e também abrangendo múltiplos. O conceito é o mesmo do anterior, gerar o valor com múltiplo ou submúltiplo e arredondar para duas casas decimais apenas. A função fica assim:

<pre class="brush: jscript; title: ; notranslate" title="">function toNotationUnit(v) {
	var unit;
	var submultiplo = ["","m","&micro;","n","p","f","a","z","y"];
	var multiplo 	= ["","k","M","G","T","P","E","Z","Y"]
	var counter= 0;
	var value = v;
	if(value &lt; 1) {
		while(value &lt; 1) {
			counter++;
			value=value*1e3;
			if(counter==8) break;
		}
		unit = submultiplo[counter];
	}else{
		while(value &gt;= 1000) {
			counter++;
			value=value/1e3;
			if(counter==8) break;
		}
		unit = multiplo[counter];
	}
	value = Math.round(value*1e2)/1e2;
	return [value,unit];
}
</pre>

Como podem ver, eu coloquei para retornar uma array contendo na sua posição 0 o valor arredondado em duas casas, e na posição 1 a unidade, assim você poderá tratar da maneira que bem entender o resultado. Para usá-la é bem simples, vamos a um exemplo em HTML:

<pre class="brush: xml; title: ; notranslate" title="">&lt;script type="text/javascript"&gt;
function toNotationUnit(v) {
	var unit;
	var submultiplo = ["","m","µ","n","p","f","a","z","y"];
	var multiplo 	= ["","k","M","G","T","P","E","Z","Y"]
	var counter= 0;
	var value = v;
	if(value &lt; 1) {
		while(value &lt; 1) {
			counter++;
			value=value*1e3;
			if(counter==8) break;
		}
		unit = submultiplo[counter];
	}else{
		while(value &gt;= 1000) {
			counter++;
			value=value/1e3;
			if(counter==8) break;
		}
		unit = multiplo[counter];
	}
	value = Math.round(value*1e2)/1e2;
	return [value,unit];
}

function pegarvalor() {
	var i = parseFloat(document.getElementById('valor').value);
	var t = toNotationUnit(i);
	document.getElementById('resultado').innerHTML = t[0]+t[1];
}
&lt;/script&gt;

Insira um valor: &lt;input type="text" id="valor" name="valor"&gt;
&lt;input type="button" onClick="pegarvalor();" value="Pegar"&gt;&lt;BR&gt;
Resultado: &lt;div id="resultado"&gt;&lt;/div&gt;
</pre>

Ou se preferir no Codepad: <http://codepad.org/TSn8wtA1>

Façam bom uso 😀