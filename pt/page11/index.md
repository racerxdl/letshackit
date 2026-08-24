---
title: "Início | Lets Hack It"
description: "Lets Hack It October 09, 2011 Função Javascript para Múltiplos e Submúltiplos Bom, vocês devem ter visto meu tópico anterior sobre Função Javascript para Submúltiplos e eu resolvi fazer uma função mais completa. Agora abrangendo mais submúltiplos e também abrangendo múltiplos. O conceito é o mesmo do anterior, gerar o valor..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Lets Hack It
  

October 09, 2011
## [Função Javascript para Múltiplos e Submúltiplos](/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos-2/)

Bom, vocês devem ter visto meu tópico anterior sobre Função Javascript para Submúltiplos&nbsp;e eu resolvi fazer uma função mais completa. Agora abrangendo mais submúltiplos e também abrangendo múltiplos. O conceito é o mesmo do anterior, gerar o valor com múltiplo ou submúltiplo e arredondar para duas casas decimais apenas. A função fica assim: function toNotationUnit(v) { var unit; var submultiplo = ["","m","µ","n","p","f","a","z","y"]; var multiplo = ["","k","M","G","T","P","E","Z","Y"] var counter= 0; var value = v; if(value \< 1) { while(value \< 1) { counter++; value=value\*1e3; if(counter==8) break; } unit = submultiplo[counter]; }else{ while(value \>= 1000) { counter++; value=value/1e3; if(counter==8) break; } unit...

October 08, 2011
## [Função Javascript para Multiplos e Submultiplos](/pt/2011/10/funcao-javascript-para-multiplos-e-submultiplos/)

Bom, estava montando uma outra calculadora aqui para a EnergyLabs Brasil, e quis fazer algo mais legalzinho. Fiz uma função em javascript que concatena o valor com o&nbsp;submúltiplo, e já faz as multiplicações necessárias além de arrendondar para duas casas decimais. Não entendeu? Bom vou exemplificar. Em física se usa muito&nbsp;múltiplos&nbsp;e&nbsp;submúltiplos para ajudar a escrever unidades. Por exemplo, estamos habituados com a unidade segundo&nbsp;no nosso dia a dia. Para representarmos 0,1 segundo, podemos representar como 100ms (100&nbsp;milissegundos), para 0,0001 segundo, podemos representar como 100us (100&nbsp;microssegundos), e assim por diante. Isso são os&nbsp;submúltiplos. Ao invés de escrevermos 0,0001 escrevemos 100 \*...

September 12, 2011
## [Desenhando com Canvas do HTML5](/pt/2011/09/desenhando-com-canvas-do-html5/)

[Migrado do LetsHack It] Alguns de vocês podem ter visto que tive alguns pequenos projetos usando o Canvas do HTML5 na EnergyLabs Brasil. Abaixo alguns projetos que fazem uso do Canvas: Curva do Transístor Gerador de Ondas Harmônicas Gerador de Fundo Animado Porém nunca expliquei a ninguém como os fiz. Vou começar um simulador de gráficos onde você digita a fórmula e ele desenha o gráfico, e explicarei no caminho o que estou fazendo. Acredito que será útil para muitas pessoas. Bom irei postar como iniciar o Canvas e irei dormir. Mais tarde continuarei este post do Lets...

September 07, 2011
## [Enviando Tweet com PHP](/pt/2011/09/enviando-tweet-com-php/)

No post anterior mostrei como enviar um Tweet com Python. Agora mostrarei com o PHP. Repita os mesmos passos de criação das Keys ditas no post anterior e anote todas elas. Para o PHP usamos uma biblioteca chamada tmhOAuth, que pode ser conseguida aqui: https://github.com/themattharris/tmhOAuth Baixe apenas o arquivo tmhOAuth.php que é o que precisamos aqui. Crie um arquivo PHP com o código abaixo: http://codepad.org/NngSyam6 \<? include("tmhOAuth.php"); $tmhOAuth = new tmhOAuth(array( 'consumer\_key' =\> "Sua Consumer Key", 'consumer\_secret' =\> "Seu Consumer Secret", 'user\_token' =\> "Seu Access Token", 'user\_secret' =\> "Seu Access Secret", )); $code = $tmhOAuth-\>request('POST', $tmhOAuth-\>url('1/statuses/update'), array('status' =\> "Teste do...

September 07, 2011
## [Enviando Tweet com Python](/pt/2011/09/enviando-tweet-com-python/)

[Migrado do LetsHack It no Tumblr] Bom, como estou sem ideias para novos hacks, vou mostrar a vocês um jeito simples de enviar um Tweet com o Python. Existem vários meios de autenticação para o Twitter (ou existiam), o principal é o OAuth. Outro ponto é que existem várias bibliotecas para o Python acessar a API do twitter, eu particularmente uso o Tweepy. 1º) Vamos começar baixando o Tweepy do seu repositório no Google Code: http://code.google.com/p/tweepy/ Abrindo a página, você verá vários meios de instalar, escolha um deles, não faz diferença qual. 2º) Vamos criar um aplicativo no twitter para...
