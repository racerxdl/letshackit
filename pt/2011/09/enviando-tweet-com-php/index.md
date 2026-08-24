---
title: "Enviando Tweet com PHP | Lets Hack It"
description: "Tutorial completo para enviar Tweets via PHP usando a biblioteca tmhOAuth. Configure as chaves da API do Twitter e automatize suas redes sociais."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Enviando Tweet com PHP

Escrito por Lucas Teske   
em 7 Setembro 2011

No post anterior mostrei como enviar um Tweet com Python. Agora mostrarei com o PHP.

Repita os mesmos passos de criação das Keys ditas no post anterior e anote todas elas.

Para o PHP usamos uma biblioteca chamada tmhOAuth, que pode ser conseguida aqui:

[https://github.com/themattharris/tmhOAuth](https://github.com/themattharris/tmhOAuth)

Baixe apenas o arquivo **tmhOAuth.php** que é o que precisamos aqui.

Crie um arquivo PHP com o código abaixo:

> [http://codepad.org/NngSyam6](http://codepad.org/NngSyam6)

```php; title: 
<?
include("tmhOAuth.php");

        $tmhOAuth = new tmhOAuth(array(
          'consumer_key' => "Sua Consumer Key",
          'consumer_secret' => "Seu Consumer Secret",
          'user_token' => "Seu Access Token",
          'user_secret' => "Seu Access Secret",
        ));

        $code = $tmhOAuth->request('POST',
 $tmhOAuth->url('1/statuses/update'),
 array('status' => "Teste do Lets Hack It! Em #PHP!"
        ));
?>
```

Se você executar esse script em PHP terá o seguinte resultado:

![image](https://media.tumblr.com/tumblr_lr68h9SRih1qh7srd.png)

Simples não? Qualquer dúvida só perguntar!

## Cite este artigo

### Citação sugerida

Lucas Teske. “Enviando Tweet com PHP.” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/09/enviando-tweet-com-php/](https://lucasteske.dev/pt/2011/09/enviando-tweet-com-php/).

### BibTeX

```
@misc{teske2011enviandotweetcomphp,
  author = {Lucas Teske},
  title = {Enviando Tweet com PHP},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/09/enviando-tweet-com-php/}
}
```
