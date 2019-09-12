---
id: 3
title: Enviando Tweet com PHP
date: 2011-09-07T18:17:24-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=23
permalink: /2011/09/enviando-tweet-com-php/
categories:
  - Sem categoria
---
No post anterior mostrei como enviar um Tweet com Python. Agora mostrarei com o PHP.

Repita os mesmos passos de criação das Keys ditas no post anterior e anote todas elas.

Para o PHP usamos uma biblioteca chamada tmhOAuth, que pode ser conseguida aqui:

<https://github.com/themattharris/tmhOAuth>

Baixe apenas o arquivo **tmhOAuth.php** que é o que precisamos aqui.

Crie um arquivo PHP com o código abaixo:

> <div>
>   <p>
>     <a href="http://codepad.org/NngSyam6">http://codepad.org/NngSyam6</a>
>   </p>
> </div>

<pre class="brush: php; title: ; notranslate" title="">&lt;?
include("tmhOAuth.php");

        $tmhOAuth = new tmhOAuth(array(
          'consumer_key'    =&gt; "Sua Consumer Key",
          'consumer_secret' =&gt; "Seu Consumer Secret",
          'user_token'      =&gt; "Seu Access Token",
          'user_secret'     =&gt; "Seu Access Secret",
        ));

        $code = $tmhOAuth-&gt;request('POST',
 $tmhOAuth-&gt;url('1/statuses/update'),
 array('status' =&gt; "Teste do Lets Hack It! Em #PHP!"
        ));
?&gt;
</pre>

Se você executar esse script em PHP terá o seguinte resultado:

![image](https://media.tumblr.com/tumblr_lr68h9SRih1qh7srd.png) 

Simples não? Qualquer dúvida só perguntar!