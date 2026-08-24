---
title: "Função Javascript para Multiplos e Submultiplos | Lets Hack It"
description: "Função Javascript para múltiplos e submúltiplos. Converta valores para mili, micro, nano e pico automaticamente com este código prático."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Função Javascript para Multiplos e Submultiplos

Escrito por Lucas Teske   
em 8 Outubro 2011

Bom, estava montando uma outra calculadora aqui para a [EnergyLabs Brasil](http://www.energylabs.com.br), e quis fazer algo mais legalzinho. Fiz uma função em javascript que concatena o valor com o&nbsp;submúltiplo, e já faz as multiplicações necessárias além de arrendondar para duas casas decimais.

Não entendeu? Bom vou exemplificar.

Em física se usa muito&nbsp;múltiplos&nbsp;e&nbsp;submúltiplos para ajudar a escrever unidades. Por exemplo, estamos habituados com a unidade **segundo** &nbsp;no nosso dia a dia. Para representarmos 0,1 segundo, podemos representar como 100ms (100&nbsp;milissegundos), para 0,0001 segundo, podemos representar como 100us (100&nbsp;microssegundos), e assim por diante. Isso são os&nbsp;submúltiplos. Ao invés de escrevermos 0,0001 escrevemos 100 \* 10^-6 (100 \* 0,000001 que é 0,0001) ou 100us. Os mais comuns submúltiplos são:

1. mili – **m** &nbsp;– 10^-3
2. micro – **µ** – 10^-6
3. nano – **n** – 10^-9
4. pico – **p –** &nbsp;10^-12

Então vamos lá para a função:

```jscript; title: 
function putunit(v,unit) {
	var lastunit = '';
	var units = ["m","µ","n","p"];
	var counter= 0;
	var value = v;
	while(value < 1) {
		lastunit = units[counter];
		counter++;
		value=value*1e3;
		if(counter==5) break;
	}
	value = Math.round(value*1e2)/1e2;
	return "<B>"+value+"</B> "+lastunit+unit;
}
```

Como usar? Bem simples:

```jscript; title: 
var i = 0.015;
	var resultado = putunit(i,"s");
```

Quer um exemplo mais prático? Vamos lá então, uma página HTML 😀

```jscript; title: 
function putunit(v,unit) {
	var lastunit = '';
	var units = ["m","µ","n","p"];
	var counter= 0;
	var value = v;
	while(value < 1) {
		lastunit = units[counter];
		counter++;
		value=value*1e3;
		if(counter==5) break;
	}
	value = Math.round(value*1e2)/1e2;
	return "<B>"+value+"</B> "+lastunit+unit;
}

function pegarvalor() {
	var i = parseFloat(document.getElementById('valor').value);
	document.getElementById('resultado').innerHTML = putunit(i,"s");
}
```

```xml; title: 
Insira um valor: <input type="text" id="valor" name="valor">
<input type="button" onClick="pegarvalor();" value="Pegar"><BR>
Resultado: <div id="resultado"></div>
```

Ou se preferir ver no Codepad:&nbsp;[http://codepad.org/hGDQsbT1](http://codepad.org/hGDQsbT1)

Faça o teste e terá resultados assim:

![image](https://media.tumblr.com/tumblr_lsrlqnEhTa1qh7srd.png)

![image](https://media.tumblr.com/tumblr_lsrlqtkXYj1qh7srd.png)

![image](https://media.tumblr.com/tumblr_lsrlqzB9R51qh7srd.png)

Viu como é prático? Você pode usar a mesma ideia da função para os&nbsp;múltiplos&nbsp;também!

## Cite este artigo

### Citação sugerida

Lucas Teske. “Função Javascript para Multiplos e Submultiplos.” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos/](https://lucasteske.dev/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos/).

### BibTeX

```
@misc{teske2011funcaojavascriptparamultiplosesubmul,
  author = {Lucas Teske},
  title = {Função Javascript para Multiplos e Submultiplos},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos/}
}
```
