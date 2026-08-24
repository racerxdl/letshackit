---
title: "Enviando Tweet com Python | Lets Hack It"
description: "Tutorial completo para enviar tweets com Python. Aprenda a configurar OAuth, gerar chaves de API e usar a biblioteca Tweepy para automação."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Enviando Tweet com Python

Escrito por Lucas Teske   
em 7 Setembro 2011

[Migrado do LetsHack It no Tumblr]  
Bom, como estou sem ideias para novos hacks, vou mostrar a vocês um jeito simples de enviar um Tweet com o Python.

Existem vários meios de autenticação para o Twitter (ou existiam), o principal é o OAuth. Outro ponto é que existem várias bibliotecas para o Python acessar a API do twitter, eu particularmente uso o [Tweepy](http://code.google.com/p/tweepy/).

1º) Vamos começar baixando o Tweepy do seu repositório no Google Code:

> [http://code.google.com/p/tweepy/](http://code.google.com/p/tweepy/)

Abrindo a página, você verá vários meios de instalar, escolha um deles, não faz diferença qual.

2º) Vamos criar um aplicativo no twitter para ter acesso a API. Abra o site&nbsp;[https://dev.twitter.com/apps](https://dev.twitter.com/apps)&nbsp;e logue com sua conta do twitter. Após isso vá em **Create New Application**.

![image](https://media.tumblr.com/tumblr_lr66z0hM2e1qh7srd.png)

Preencha os campos obrigatórios (com \*\*\*\*\*) (Nome, Descrição e Site), aceite os termos abaixo e redigite o Captcha.

3º) Agora a aplicação está criada, precisamos autorizar o uso da API para esta conta do Twitter. Mas antes precisamos alterar as permissões para **Read/Write**.

![image](https://media.tumblr.com/tumblr_lr672i7I8s1qh7srd.jpg)

Clique em **Settings** , e abaixe a página até ver as permissões. Selecione **Read and Write** &nbsp;e clique no botão **Update**.

![image](https://media.tumblr.com/tumblr_lr673ipKAF1qh7srd.png)

Volte para a aba **Details** &nbsp;e no final da página clique no botão **Create My Access Token**. Espere um tempo e atualize a página. Suas chaves devem estar disponíveis.

![image](https://media.tumblr.com/tumblr_lr677kUrNE1qh7srd.jpg)

Anote o nome das chaves e as respectivas chaves (Tanto as Consumer quanto Access). Iremos usa-las.

4º) Vamos então fazer o programa enviar um tweet então! O programa é simples:

> [http://codepad.org/GDvH4Sr8](http://codepad.org/GDvH4Sr8)

```python; title: 
import sys
import tweepy

CONSUMER_KEY = 'Coloque aqui sua Consumer Key'
CONSUMER_SECRET = 'Coloque aqui sua Consumer Secret'
ACCESS_KEY = 'Coloque aqui sua Access Key'
ACCESS_SECRET = 'Coloque aqui sua Access Secret'

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_KEY, ACCESS_SECRET)
api = tweepy.API(auth)
api.update_status("Teste do Lets Hack It!") #Envia o Tweet
```

Execute o script, e veja a sua timeline!

![image](https://media.tumblr.com/tumblr_lr67ifsvgC1qh7srd.png)

Simples não? Qualquer dúvida só perguntar!

## Cite este artigo

### Citação sugerida

Lucas Teske. “Enviando Tweet com Python.” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/09/enviando-tweet-com-python/](https://lucasteske.dev/pt/2011/09/enviando-tweet-com-python/).

### BibTeX

```
@misc{teske2011enviandotweetcompython,
  author = {Lucas Teske},
  title = {Enviando Tweet com Python},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/09/enviando-tweet-com-python/}
}
```
