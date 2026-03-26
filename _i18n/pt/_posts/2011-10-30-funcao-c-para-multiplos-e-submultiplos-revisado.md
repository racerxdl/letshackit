---
id: 14
title: Função C para múltiplos e submúltiplos (REVISADO)
date: 2011-10-30 17:50:21-03:00
author: Lucas Teske
layout: post
guid: http://www.teske.net.br/lucas/?p=40
permalink: /2011/10/funcao-c-para-multiplos-e-submultiplos-revisado/
categories:
- Programming
tags:
- C programming
- function
- notation
- SI units
- multiples
- submultiples
- floating point
- rounding
- optimization
- code snippet
description: Veja a função C revisada para múltiplos e submúltiplos. Converta números
  para notação SI (k, M, G, p, n, u) com precisão.
enriched: true
---
O _Caio Alarcon_ me notificou de algumas coisas sobre minha função de múltiplos e submúltiplos, por exemplo, o tratamento de números negativos. Resolvi então revisar e otimizar a função em C. O Resultado está abaixo:

<pre class="brush: cpp; title: ; notranslate" title="">#include &lt;stdio.h&gt;
#include &lt;math.h&gt;
char toNotationUnit(double value,float *out) {
        double val;
        char notacoes[] = {'y','z','a','f','p','n','u','m',' ',

                                   'k','M','G','T','P','E','Z','Y'};
        int counter=8;
        char unit;
        val = value&gt;0?value:-value;
        if(val &lt; 1) {
                while( (val &lt; 1.00) & (counter != 0)) {
                        counter--;
                        val=val*(double)1000;
                }
        }else{
                while((val &gt;= 1000) & (counter != 16)) {
                        counter++;
                        val=val/(double)1000;
                }
        }
        unit = notacoes[counter];
        val = round(val*(double)100)/(double)100;
        *out = (float) value&gt;0?val:-val;
        return unit;
}
 
int main() {
  double x = -1230000;
  float res;
  char t;
  t = toNotationUnit(x,&res);
  printf("%.2F%c",res,t);
  return 0;
}
</pre>

Quem preferir, tem um link no ideone com este código funcionando 😀

<http://ideone.com/wpvZo>

Bom uso!