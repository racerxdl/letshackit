---
title: "Função C para múltiplos e submúltiplos (REVISADO) | Lets Hack It"
description: "Veja a função C revisada para múltiplos e submúltiplos. Converta números para notação SI (k, M, G, p, n, u) com precisão."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# Função C para múltiplos e submúltiplos (REVISADO)

Escrito por Lucas Teske   
em 30 Outubro 2011

O _Caio Alarcon_ me notificou de algumas coisas sobre minha função de&nbsp;múltiplos&nbsp;e&nbsp;submúltiplos, por exemplo, o tratamento de&nbsp;números&nbsp;negativos. Resolvi então revisar e otimizar a função em C. O Resultado está abaixo:

```cpp; title: 
#include <stdio.h>
#include <math.h>
char toNotationUnit(double value,float *out) {
        double val;
        char notacoes[] = {'y','z','a','f','p','n','u','m',' ',

                                   'k','M','G','T','P','E','Z','Y'};
        int counter=8;
        char unit;
        val = value>0?value:-value;
        if(val < 1) {
                while( (val < 1.00) & (counter != 0)) {
                        counter--;
                        val=val*(double)1000;
                }
        }else{
                while((val >= 1000) & (counter != 16)) {
                        counter++;
                        val=val/(double)1000;
                }
        }
        unit = notacoes[counter];
        val = round(val*(double)100)/(double)100;
        *out = (float) value>0?val:-val;
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
```

Quem preferir, tem um link no ideone com este código funcionando 😀

[http://ideone.com/wpvZo](http://ideone.com/wpvZo)

Bom uso!

## Cite este artigo

### Citação sugerida

Lucas Teske. “Função C para múltiplos e submúltiplos (REVISADO).” _Lets Hack It_, 2011. [https://lucasteske.dev/pt/2011/10/funcao-c-para-multiplos-e-submultiplos-revisado/](https://lucasteske.dev/pt/2011/10/funcao-c-para-multiplos-e-submultiplos-revisado/).

### BibTeX

```
@misc{teske2011funcaocparamultiplosesubmultiplosrev,
  author = {Lucas Teske},
  title = {Função C para múltiplos e submúltiplos (REVISADO)},
  year = {2011},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2011/10/funcao-c-para-multiplos-e-submultiplos-revisado/}
}
```
