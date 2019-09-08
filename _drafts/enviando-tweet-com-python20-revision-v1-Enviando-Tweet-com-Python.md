---
id: 22
title: Enviando Tweet com Python
date: 2014-10-01T19:07:40-03:00
author: Lucas Teske
layout: revision
guid: http://www.teske.net.br/lucas/?p=22
permalink: /2014/10/20-revision-v1/
---
[Migrado do LetsHack It no Tumblr]  
Bom, como estou sem ideias para novos hacks, vou mostrar a vocês um jeito simples de enviar um Tweet com o Python.

Existem vários meios de autenticação para o Twitter (ou existiam), o principal é o OAuth. Outro ponto é que existem várias bibliotecas para o Python acessar a API do twitter, eu particularmente uso o [Tweepy](http://code.google.com/p/tweepy/).

1º) Vamos começar baixando o Tweepy do seu repositório no Google Code:

> <div>
>   <p>
>     <a href="http://code.google.com/p/tweepy/">http://code.google.com/p/tweepy/</a>
>   </p>
> </div>

Abrindo a página, você verá vários meios de instalar, escolha um deles, não faz diferença qual.

2º) Vamos criar um aplicativo no twitter para ter acesso a API. Abra o site <https://dev.twitter.com/apps> e logue com sua conta do twitter. Após isso vá em **Create New Application**.

![image](https://media.tumblr.com/tumblr_lr66z0hM2e1qh7srd.png) 

Preencha os campos obrigatórios (com *****) (Nome, Descrição e Site), aceite os termos abaixo e redigite o Captcha.

3º) Agora a aplicação está criada, precisamos autorizar o uso da API para esta conta do Twitter. Mas antes precisamos alterar as permissões para **Read/Write**.

![image](https://media.tumblr.com/tumblr_lr672i7I8s1qh7srd.jpg) 

Clique em **Settings**, e abaixe a página até ver as permissões. Selecione **Read and Write** e clique no botão **Update**.

![image](https://media.tumblr.com/tumblr_lr673ipKAF1qh7srd.png) 

Volte para a aba **Details** e no final da página clique no botão **Create My Access Token**. Espere um tempo e atualize a página. Suas chaves devem estar disponíveis.

![image](https://media.tumblr.com/tumblr_lr677kUrNE1qh7srd.jpg) 

Anote o nome das chaves e as respectivas chaves (Tanto as Consumer quanto Access). Iremos usa-las.

4º) Vamos então fazer o programa enviar um tweet então! O programa é simples:

> <div>
>   <p>
>     <a href="http://codepad.org/GDvH4Sr8">http://codepad.org/GDvH4Sr8</a>
>   </p>
> </div>

<pre class="brush: python; title: ; notranslate" title="">import sys
import tweepy

CONSUMER_KEY = 'Coloque aqui sua Consumer Key'
CONSUMER_SECRET = 'Coloque aqui sua Consumer Secret'
ACCESS_KEY = 'Coloque aqui sua Access Key'
ACCESS_SECRET = 'Coloque aqui sua Access Secret'

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_KEY, ACCESS_SECRET)
api = tweepy.API(auth)
api.update_status(&quot;Teste do Lets Hack It!&quot;) #Envia o Tweet
</pre>

Execute o script, e veja a sua timeline!

![image](https://media.tumblr.com/tumblr_lr67ifsvgC1qh7srd.png) 

Simples não? Qualquer dúvida só perguntar!