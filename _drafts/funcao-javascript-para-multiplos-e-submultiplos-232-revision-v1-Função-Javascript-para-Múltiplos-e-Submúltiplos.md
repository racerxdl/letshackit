---
id: 33
title: Função Javascript para Múltiplos e Submúltiplos
date: 2014-10-01T16:24:15-03:00
author: racerxdl
layout: revision
guid: http://www.teske.net.br/lucas/?p=33
permalink: /2014/10/32-revision-v1/
---
Bom, vocês devem ter visto meu tópico anterior sobre [Função Javascript para Submúltiplos](http://letshackit.energylabs.com.br/post/11195814648/funcao-javascript-para-submultiplos) e eu resolvi fazer uma função mais completa. Agora abrangendo mais submúltiplos e também abrangendo múltiplos. O conceito é o mesmo do anterior, gerar o valor com múltiplo ou submúltiplo e arredondar para duas casas decimais apenas. A função fica assim:

<pre class="brush: jscript; title: ; notranslate" title="">function toNotationUnit(v) {
	var unit;
	var submultiplo = [&quot;&quot;,&quot;m&quot;,&quot;&amp;micro;&quot;,&quot;n&quot;,&quot;p&quot;,&quot;f&quot;,&quot;a&quot;,&quot;z&quot;,&quot;y&quot;];
	var multiplo 	= [&quot;&quot;,&quot;k&quot;,&quot;M&quot;,&quot;G&quot;,&quot;T&quot;,&quot;P&quot;,&quot;E&quot;,&quot;Z&quot;,&quot;Y&quot;]
	var counter= 0;
	var value = v;
	if(value &amp;lt; 1) {
		while(value &amp;lt; 1) {
			counter++;
			value=value*1e3;
			if(counter==8) break;
		}
		unit = submultiplo[counter];
	}else{
		while(value &amp;gt;= 1000) {
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

<pre class="brush: xml; title: ; notranslate" title="">&lt;script type=&quot;text/javascript&quot;&gt;
function toNotationUnit(v) {
	var unit;
	var submultiplo = [&quot;&quot;,&quot;m&quot;,&quot;µ&quot;,&quot;n&quot;,&quot;p&quot;,&quot;f&quot;,&quot;a&quot;,&quot;z&quot;,&quot;y&quot;];
	var multiplo 	= [&quot;&quot;,&quot;k&quot;,&quot;M&quot;,&quot;G&quot;,&quot;T&quot;,&quot;P&quot;,&quot;E&quot;,&quot;Z&quot;,&quot;Y&quot;]
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

Insira um valor: &lt;input type=&quot;text&quot; id=&quot;valor&quot; name=&quot;valor&quot;&gt;
&lt;input type=&quot;button&quot; onClick=&quot;pegarvalor();&quot; value=&quot;Pegar&quot;&gt;&lt;BR&gt;
Resultado: &lt;div id=&quot;resultado&quot;&gt;&lt;/div&gt;
</pre>

Ou se preferir no Codepad: <http://codepad.org/TSn8wtA1>

Façam bom uso 😀