---
id: 1
title: Ed Poliglota
date: 2011-09-06 12:42:24-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=6
permalink: /2011/09/ed-poliglota/
categories:
- Hacking
- Reverse Engineering
tags:
- Python
- Reverse Engineering
- Web Scraping
- Google Translate API
- Chatbot
- Bot Gateway
- mod_perl
- CGI
- Source Code Analysis
- HTTP Request
description: Aprenda a interagir com o Robô Ed do governo brasileiro. Use Python e
  Google Translate para fazer o bot responder em qualquer idioma.
enriched: true
---
[Migrado do LetsHackIt]

Hmm, vamos brincar um pouco com Robô Ed? É aquele Robô Ed que está no site do Ministério de Minas de Energia do Brasil&#8230; Não sabe qual? Olhe aqui: <http://www.ed.conpet.gov.br/br/converse.php> &#8211; Mas não vamos brincar de conversar não! Vamos fazer algo mais legal, vamos ver o que da pra fazer!

Vamos analisar o código fonte do site e ver se descobrimos algo legal!

<!--more-->

Bom, o botão Enviar tem a função **DoTalk()** , percorrendo o código para achar o que ela faz achei umas coisas interessantes:

<pre class="brush: jscript; title: ; notranslate" title="">var e_usermsg = escape(usermsg); 
e_usermsg = e_usermsg.replace(/\+/g, "%2B"); 
var url = '/mod_perl/bot_gateway.cgi?server='+bot_server+'&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg='+e_usermsg; // Salva tudo em campo hidden para que outro frame possa ler os dados da conversa document.form1.fulltext.value += "Você: "+usermsg+"\n"; document.form1.fulltext.value += "Ed: "+answer+"\n";
</pre>

Vamos ver, tem uma var ali com a URL de request. Será que da pra brincar?  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-  
Seguindo a lógica da URL, começando com a / significa root do documento, vendo o site por <a href="http://www.ed.conpet.gov.br/br/converse.php" target="_blank">http://www.ed.conpet.gov.br/br/converse.php</a> o root seria <a href="http://www.ed.conpet.gov.br/br/converse.php" target="_blank">http://www.ed.conpet.gov.br</a> . Logo: <a href="http://www.ed.conpet.gov.br/br/converse.php" target="_blank">http://www.ed.conpet.gov.br</a>/mod\_perl/bot\_gateway.cgi?server=’+bot\_server+’&charset=utf-8&pure=1&js=0&msg=’+e\_usermsg Vamos descobrir o valor da variável bot\_server, afinal o e\_usermsg nem preciso comentar né?  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-  
Olha que legal! Achei o endereço no próprio código:

<pre class="brush: jscript; title: ; notranslate" title="">var bot_id = 5;
//bot_server = ‘r.bot.insite.com.br:8085’;
//bot_server = ‘bot.insite.com.br:8085’;
bot_server = ‘0.0.0.0:8085’;
</pre>

Vamos tentar substituir para ver?  
<a href="http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&charset=utf-8&pure=1&js=0&msg=Ola" target="_blank">http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&charset=utf-8&pure=1&js=0&msg=Ola</a> Opa! Funcionou, consegui uma resposta!

> Oi, como posso ajudar?

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-  
Vamos ao meu amigo Python por enquanto! Que tal fazer um script que pergunte pergunte algo pro Ed? Vamos lá!

<pre class="brush: python; title: ; notranslate" title="">import urllib
print “Insira a mensagem pro Ed! :”
mensagem = raw_input()
f = urllib.urlopen(“http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg=”+mensagem)
s = f.read()
f.close()
print “Resposta do Ed: “+s
</pre>

Deve funcionar, vamos ver!

> **\# python ed.py**

> Insira a mensagem pro Ed! :

> Ola Ed!

> Resposta do Ed: Oi, como posso ajudar?

Uhul! Funciona! Vamos pensar em algo mais legal para fazer 😀

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Olha que legal o que eu descobri! Google Text-To-Speech API!

<a href="http://translate.google.com/translate_tts?tl=ptbr&q=Ae,%20vamos%20Lets%20Hack%20It!" target="_blank">Vamos Lets Hack It!</a>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

O <a href="http://twitter.com/gustavojordan" target="_blank">@gustavojordan</a> sugeriu fazer um Robô Ed para os gringos, vamos lá então!

Ele sugeriu o uso dessa lib: <a href="http://www.catonmat.net/blog/python-library-for-google-translate/" target="_blank">http://www.catonmat.net/blog/python-library-for-google-translate/</a>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

É, essa lib xgoogle vai quebrar o galho:

> >> from xgoogle.translate import Translator  
> >> translate = Translator().translate  
> >> print translate(“Estou doido”)  
> I’m very excited  
> >>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Bom, essa lib não tem suporte a pt-br, mas uma pequena modificação faz ela suportar (afinal o tio Google suporta pt-br). Só adicionei pt-br nos índices de línguas do translator.py e voi-lá!

> >> from xgoogle.translate import Translator  
> >> translate = Translator().translate  
> >> print translate(“Hello world”, lang_to=’pt-br’)  
> Olá, mundo

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Yahooooo! Ops, Gooooooogle!

Tradução funciona! Agora os gringos podem falar com o Ed!

> \# **python ed.py**
> 
> Insert your message for Ed:
> 
> Hello
> 
> Ed says: Hello, how are you?

O código? Claro, por que não!

<pre class="brush: python; title: ; notranslate" title="">import urllib
from xgoogle.translate import Translator
translate = Translator().translate

print "Insert your message for Ed: "
mensagem = raw_input()
mensagem = translate(mensagem, lang_to='pt-br').encode('utf-8')
url = 'http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg='
f = urllib.urlopen(url+mensagem)
s = f.read()
f.close()
print "Ed says: "+ translate(s)</pre>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

> **\# python ed.py**
> 
> > Insert your message for Ed:
> > 
> > la luna piena piange lo sangue de l’innocenza
> > 
> > Ed says: Auuuuuuuuuuuu! Full moon makes me inspired!

Agora sabemos que pode-se falar em qualquer língua que o Google Translate aceite!

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Bom o Taka disse que é ruim o bot sempre responder em inglês. Então vou fazer ele responder na língua que for digitada!

Pequena modificação no **translate.py** para que ele me retorne também a informação que o Google da sobre a linguagem de origem:

Após:

<pre class="brush: jscript; title: ; notranslate" title="">try:
            translation = self.browser.get_page(real_url)
            data = json.loads(translation)
            if data[‘responseStatus’] != 200:
                raise TranslationError, “Failed translating: %s” % data[‘responseDetails’]
</pre>

Vamos ver 😀

> >> from xgoogle.translate import Translator  
> >> translate = Translator().translate  
> >> translate(“Hello World”, lang_to=’pt-br’)  
> {u’responseData’: {u’translatedText’: u’Ol\xe1 Mundo’, u’detectedSourceLanguage’: u’en’}, u’responseDetails’: None, u’responseStatus’: 200}

Funciona!

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-  
É isso ai pessoal! Agora o Ed é poliglota!

> **\# python ed_pol.py**
> 
> Insert your message for Ed:
> 
> Hello Ed
> 
> Ed Response: Hi, how can I help?
> 
> **\# python ed_pol.py**
> 
> Insert your message for Ed:
> 
> Buenos Dias Ed
> 
> Ed Response: Muy buenos dias! Gusto en conocerlo.
> 
> **\# python ed_pol.py**
> 
> Insert your message for Ed:
> 
> ange ou démon, qui l’emporte à la fin?
> 
> Ed Response: Emily a dàcouvert dans la Voie Lactàe gràce doeun petit ange avec une aile cassàe. Il Àtait en voyage vers le ciel

Código? Claro!

<pre class="brush: jscript; title: ; notranslate" title="">import urllib
from xgoogle.translate import Translator
translate = Translator().translate

print "Insert your message for Ed: "
mensagem = raw_input()
mensagem = translate(mensagem, lang_to='pt-br')
url = 'http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg='
f = urllib.urlopen(url+mensagem['responseData']['translatedText'].encode('utf-8'))
s = f.read()
f.close()
langfrom=mensagem['responseData']['detectedSourceLanguage']
resp=translate(s, lang_to=langfrom)['responseData']['translatedText']
print "Ed Response: "+resp
</pre>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Estou pensando, que tal algo mais público? Tipo uma página onde qualquer um possa falar com o Robô Ed em qualquer língua? É uma boa! Vamos fazer com PHP então e disponibilizar um link para vocês!

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Com PHP é simples também para pegar a mensagem do Ed:

<pre class="brush: php; title: ; notranslate" title="">$mensagem = utf8_encode($_REQUEST["mensagem"]);
echo '&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /&gt;';
$url = "http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg=";
$x = strip_tags(file_get_contents($url.$mensagem));
echo $x;
</pre>

Isso já faz o papel 😀

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Brinquei tanto na API de Translate da Google, que parece que me baniram #EPIC FAIL

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

Falsifiquei o User Agent dizendo que era um browser _Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)_ e a Google aceitou!

Função usada no PHP para traduzir com google translate:

<pre class="brush: php; title: ; notranslate" title="">function translate($msg, $from="", $to="pt-br") {
$tUrl = "http://ajax.googleapis.com/ajax/services/language/translate?
v=1.0&amp;q=".urlencode($msg)."&amp;langpair=".$from."|".$to;
$curl = curl_init($tUrl);
curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($curl, CURLOPT_HEADER, 0);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)");
curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($curl, CURLOPT_COOKIEFILE, "cookiefile");
curl_setopt($curl, CURLOPT_COOKIEJAR, "cookiefile"); # SAME cookiefile
$output = curl_exec($curl);
curl_close($curl);
$rt = json_decode($output);
return $rt;
}</pre>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

O Ed Agora é poliglota em PHP também!

> You asked: Buenos Dias, Ed  
> Ed Response: Eso está muy bien …

O código? Claro!

<pre class="brush: php; title: ; notranslate" title="">function translate($msg, $from="", $to="pt-br") {
	$tUrl = "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&amp;q=".urlencode($msg)."&amp;langpair=".$from."|".$to;
	$curl = curl_init($tUrl);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($curl, CURLOPT_HEADER, 0);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)");
	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($curl, CURLOPT_COOKIEFILE, "cookiefile");
	curl_setopt($curl, CURLOPT_COOKIEJAR, "cookiefile"); # SAME cookiefile
	$output = curl_exec($curl);
	curl_close($curl);
	$rt = json_decode($output, TRUE);
	return $rt;
}

$mensagem = translate($_REQUEST["mensagem"]);
$from = $mensagem["responseData"]["detectedSourceLanguage"];
$mensagem = utf8_encode($mensagem["responseData"]["translatedText"]);

echo '&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /&gt;';
$x = strip_tags(file_get_contents("http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg=".$mensagem));
$resp = translate($x,"",$from);
echo("You asked: ".$_REQUEST["mensagem"]."&lt;BR&gt;
Ed Response: ".$resp["responseData"]["translatedText"]);
</pre>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

É triste isso pessoal, mas API da Google não detecta a linguagem de origem se for a mesma de destino. Vejam só:

<a href="http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&langpair=%7Cpt-br&q=Ol%C3%A1%20Ed!" target="_blank">http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&langpair=|pt-br&q=Ol%C3%A1%20Ed!</a>

Tenho como resultado:

> {“responseData”: null, “responseDetails”: “could not reliably detect source language”, “responseStatus”: 400}

Logo Ed falará todas as línguas MENOS português. Fail Eterno?

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-  
Resolvido o problema com o bug da Google:

<pre class="brush: php; title: ; notranslate" title="">function translate($msg, $from="", $to="pt-br") {
	$tUrl = "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&amp;q=".urlencode($msg)."&amp;langpair=".$from."|".$to;
	$curl = curl_init($tUrl);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($curl, CURLOPT_HEADER, 0);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 5.01;	Windows NT 5.0)");
	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($curl, CURLOPT_COOKIEFILE, "cookiefile");
	curl_setopt($curl, CURLOPT_COOKIEJAR, "cookiefile"); # SAME cookiefile
	$output = curl_exec($curl);
	curl_close($curl);
	$rt = json_decode($output, TRUE);
	return $rt;
}
header("Content-Type: text/plain; charset=UTF-8");
$mensagem = translate($_REQUEST["mensagem"]);
$from = $mensagem["responseData"]["detectedSourceLanguage"];
if($mensagem["responseStatus"] == 400)
	$mensagem = $_REQUEST["mensagem"];
else
	$mensagem = utf8_encode($mensagem["responseData"]["translatedText"]);
$x = strip_tags(file_get_contents("http://www.ed.conpet.gov.br/mod_perl/bot_gateway.cgi?server=0.0.0.0:8085&amp;charset=utf-8&amp;pure=1&amp;js=0&amp;msg=".$mensagem));

if($mensagem == $_REQUEST["mensagem"])
	echo $x;
	else{
	$resp = translate($x,"",$from);
	echo($resp["responseData"]["translatedText"]);
}
</pre>

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

[<img class="alignnone size-medium wp-image-7" src="https://www.teske.net.br/lucas/wp-content/uploads/2014/10/tumblr_lr4xycuamW1r2f8jyo1_1280-300x171.png" alt="Ed Poliglota" width="300" height="171" srcset="https://www.teske.net.br/lucas/wp-content/uploads/2014/10/tumblr_lr4xycuamW1r2f8jyo1_1280-300x171.png 300w, https://www.teske.net.br/lucas/wp-content/uploads/2014/10/tumblr_lr4xycuamW1r2f8jyo1_1280.png 846w" sizes="(max-width: 300px) 100vw, 300px" />](https://www.teske.net.br/lucas/wp-content/uploads/2014/10/tumblr_lr4xycuamW1r2f8jyo1_1280.png)

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

É isso ae! Agora o Ed Poliglóta pode ser acessado por todos!

Aqui está: <a href="http://www.energylabs.com.br/edpol/" target="_blank">http://www.energylabs.com.br/edpol/</a>

É claro que tem muitos erros, mas isso a gente releva, olha só o que fizemos em tão pouco tempo!

Divirtam-se!

&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-

<div class="regular_post_body">
  <p>
    Sim estou com uma grande preguiça de fazer o AutoScroll Down… Quem sabe um outro dia? Se alguém quiser colaborar ai! UOIASHEOIAUHe o código fonte inteiro está aqui 😀
  </p>
  
  <p>
    <a href="http://codepad.org/IrP8opQM" target="_blank">getanswer.php</a>
  </p>
  
  <p>
    <a href="http://codepad.org/PTQEXPcS" target="_blank">index.php</a> (HTML puro)
  </p>
  
  <p>
    Em breve novos hacks!
  </p>
</div>