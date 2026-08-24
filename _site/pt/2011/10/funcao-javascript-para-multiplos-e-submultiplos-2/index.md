---
title: "Função Javascript para Múltiplos e Submúltiplos | Lets Hack It"
description: "Função Javascript completa para converter valores em múltiplos e submúltiplos, retornando array com valor e unidade arredondada."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Função Javascript para Múltiplos e Submúltiplos

Escrito por Lucas Teske   
em 9 Outubro 2011

Bom, vocês devem ter visto meu tópico anterior sobre [Função Javascript para Submúltiplos](http://letshackit.energylabs.com.br/post/11195814648/funcao-javascript-para-submultiplos)&nbsp;e eu resolvi fazer uma função mais completa. Agora abrangendo mais submúltiplos e também abrangendo múltiplos. O conceito é o mesmo do anterior, gerar o valor com múltiplo ou submúltiplo e arredondar para duas casas decimais apenas. A função fica assim:

```jscript; title: 
function toNotationUnit(v) {
	var unit;
	var submultiplo = ["","m","µ","n","p","f","a","z","y"];
	var multiplo = ["","k","M","G","T","P","E","Z","Y"]
	var counter= 0;
	var value = v;
	if(value < 1) {
		while(value < 1) {
			counter++;
			value=value*1e3;
			if(counter==8) break;
		}
		unit = submultiplo[counter];
	}else{
		while(value >= 1000) {
			counter++;
			value=value/1e3;
			if(counter==8) break;
		}
		unit = multiplo[counter];
	}
	value = Math.round(value*1e2)/1e2;
	return [value,unit];
}
```

Como podem ver, eu coloquei para retornar uma array contendo na sua posição 0 o valor arredondado em duas casas, e na posição 1 a unidade, assim você poderá tratar da maneira que bem entender o resultado. Para usá-la é bem simples, vamos a um exemplo em HTML:

```xml; title: 
<script type="text/javascript">
function toNotationUnit(v) {
	var unit;
	var submultiplo = ["","m","µ","n","p","f","a","z","y"];
	var multiplo = ["","k","M","G","T","P","E","Z","Y"]
	var counter= 0;
	var value = v;
	if(value < 1) {
		while(value < 1) {
			counter++;
			value=value*1e3;
			if(counter==8) break;
		}
		unit = submultiplo[counter];
	}else{
		while(value >= 1000) {
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
</script>

Insira um valor: <input type="text" id="valor" name="valor">
<input type="button" onClick="pegarvalor();" value="Pegar"><BR>
Resultado: <div id="resultado"></div>
```

Ou se preferir no Codepad:&nbsp;[http://codepad.org/TSn8wtA1](http://codepad.org/TSn8wtA1)

Façam bom uso 😀

## Cite este artigo

### Citação sugerida

Lucas Teske. “Função Javascript para Múltiplos e Submúltiplos.” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos-2/](https://lucasteske.dev/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos-2/).

### BibTeX

```
@misc{teske2011funcaojavascriptparamultiplosesubmul,
  author = {Lucas Teske},
  title = {Função Javascript para Múltiplos e Submúltiplos},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos-2/}
}
```
