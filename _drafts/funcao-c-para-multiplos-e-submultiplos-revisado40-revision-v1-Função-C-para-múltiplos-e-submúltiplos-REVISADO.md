---
id: 41
title: Função C para múltiplos e submúltiplos (REVISADO)
date: 2014-10-01T16:28:27-03:00
author: racerxdl
layout: revision
guid: http://www.teske.net.br/lucas/?p=41
permalink: /2014/10/40-revision-v1/
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
                while( (val &lt; 1.00) &amp; (counter != 0)) {
                        counter--;
                        val=val*(double)1000;
                }
        }else{
                while((val &gt;= 1000) &amp; (counter != 16)) {
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
  t = toNotationUnit(x,&amp;res);
  printf(&quot;%.2F%c&quot;,res,t);
  return 0;
}
</pre>

Quem preferir, tem um link no ideone com este código funcionando 😀

<http://ideone.com/wpvZo>

Bom uso!