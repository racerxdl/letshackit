---
title: "Início | Lets Hack It"
description: "Lets Hack It September 07, 2011 Apontador com Laser Vermelho de DVD Para passar um pouco o tempo, um hack antigo meu de como fazer um apontador laser vermelho que queima com um Gravador de DVD… [embedyt]https://www.youtube.com/watch?v=mEzq2PaFvXY[/embedyt] September 06, 2011 Ed Poliglota [Migrado do LetsHackIt] Hmm, vamos brincar um pouco..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Lets Hack It
  

September 07, 2011
## [Apontador com Laser Vermelho de DVD](/pt/2011/09/15/)

Para passar um pouco o tempo, um hack antigo meu de como fazer um apontador laser vermelho que queima com um Gravador de DVD… [embedyt]https://www.youtube.com/watch?v=mEzq2PaFvXY[/embedyt]

September 06, 2011
## [Ed Poliglota](/pt/2011/09/ed-poliglota/)

[Migrado do LetsHackIt] Hmm, vamos brincar um pouco com Robô Ed? É aquele Robô Ed que está no site do Ministério de Minas de Energia do Brasil… Não sabe qual? Olhe aqui:&nbsp;http://www.ed.conpet.gov.br/br/converse.php&nbsp;– Mas não vamos brincar de conversar não! Vamos fazer algo mais legal, vamos ver o que da pra fazer! Vamos analisar o código fonte do site e ver se descobrimos algo legal! Bom, o botão Enviar tem a função DoTalk()&nbsp;, percorrendo o código para achar o que ela faz achei umas coisas interessantes: var e\_usermsg = escape(usermsg); e\_usermsg = e\_usermsg.replace(/\+/g, "%2B"); var url = '/mod\_perl/bot\_gateway.cgi?server='+bot\_server+'&charset=utf-8&pure=1&js=0&msg='+e\_usermsg; // Salva tudo...
