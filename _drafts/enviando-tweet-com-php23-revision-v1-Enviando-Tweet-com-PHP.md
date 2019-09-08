---
id: 24
title: Enviando Tweet com PHP
date: 2014-10-01T19:09:34-03:00
author: Lucas Teske
layout: revision
guid: http://www.teske.net.br/lucas/?p=24
permalink: /2014/10/23-revision-v1/
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
include(&quot;tmhOAuth.php&quot;);

        $tmhOAuth = new tmhOAuth(array(
          'consumer_key'    =&gt; &quot;Sua Consumer Key&quot;,
          'consumer_secret' =&gt; &quot;Seu Consumer Secret&quot;,
          'user_token'      =&gt; &quot;Seu Access Token&quot;,
          'user_secret'     =&gt; &quot;Seu Access Secret&quot;,
        ));

        $code = $tmhOAuth-&gt;request('POST',
 $tmhOAuth-&gt;url('1/statuses/update'),
 array('status' =&gt; &quot;Teste do Lets Hack It! Em #PHP!&quot;
        ));
?&gt;
</pre>

Se você executar esse script em PHP terá o seguinte resultado:

![image](https://media.tumblr.com/tumblr_lr68h9SRih1qh7srd.png) 

Simples não? Qualquer dúvida só perguntar!