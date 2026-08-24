---
title: "Início | Lets Hack It"
description: "October 01, 2014 The Parallella Board and HyperSignal Somente disponível em Inglês February 08, 2014 Motivos pelos quais eu não gostei do Intel Galileo Consegui minha placa Intel Galileo na semana da Campus Party. Peguei ela mais por curiosidade. A minha real intenção sobre ela seria comparar o processador dela..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

October 01, 2014
# [The Parallella Board and HyperSignal](/pt/2014/10/the-parallella-board-and-hypersignal/)

Somente disponível em Inglês

February 08, 2014
# [Motivos pelos quais eu não gostei do Intel Galileo](/pt/2014/02/motivos-pelos-quais-eu-nao-gostei-do-intel-galileo/)

Consegui minha placa Intel Galileo na semana da Campus Party. Peguei ela mais por curiosidade. A minha real intenção sobre ela seria comparar o processador dela ao Raspberry Pi. O Raspberry Pi como muitos sabem usa um processador bem ultrapassado. Os seus 700MHz já não significam muita coisa. Porém ele tem uma boa GPU que é capaz de decodificar videos 1080p e rodar aplicativos OpenGL. Eu sempre tive a ideia de que a Intel só faz \*porcaria\* nos seus produtos. Antes que venham falar \*fanboy da AMD\* o meu ponto contra a Intel é o x86, o que me coloca...

January 18, 2014
# [IP Cam – MayGion](/pt/2014/01/ip-cam-maygion/)

Bom, estou montando um QuadCopter e sai procurando cameras para colocar nele. Na minha lista de opções coloquei 3 câmeras IP: 1) MayGion IP cam (comprada na Dealextreme, 640×480) 2) DSC-930L (D-LINK 640×480) 3) DSC-2130 (D-LINK 1280×800) Comecei a desmontar a MayGion pra ver como ela era. Ai vai umas fotos Essa é a placa principal. O microcontrolador parece proprietário (ao menos, não conheço a marca). Pela engenharia reversa na firmware, é um processador MIPS que roda a cerca de 400MHz. A câmera usa motores de passo para os controles dos eixos, um jeito bem preciso de mexer a câmera....

October 30, 2011
# [Função C para múltiplos e submúltiplos (REVISADO)](/pt/2011/10/funcao-c-para-multiplos-e-submultiplos-revisado/)

O Caio Alarcon me notificou de algumas coisas sobre minha função de&nbsp;múltiplos&nbsp;e&nbsp;submúltiplos, por exemplo, o tratamento de&nbsp;números&nbsp;negativos. Resolvi então revisar e otimizar a função em C. O Resultado está abaixo: #include \<stdio.h\> #include \<math.h\> char toNotationUnit(double value,float \*out) { double val; char notacoes[] = {'y','z','a','f','p','n','u','m',' ', 'k','M','G','T','P','E','Z','Y'}; int counter=8; char unit; val = value\>0?value:-value; if(val \< 1) { while( (val \< 1.00) & (counter != 0)) { counter--; val=val\*(double)1000; } }else{ while((val \>= 1000) & (counter != 16)) { counter++; val=val/(double)1000; } } unit = notacoes[counter]; val = round(val\*(double)100)/(double)100; \*out = (float) value\>0?val:-val; return unit; } int main() { double...

October 22, 2011
# [Recondicionamento de um Variac](/pt/2011/10/recondicionamento-de-um-variac/)

Como alguns sabem, meu variac pegou fogo ( ), e o meu outro queimou na semana da GV. Então precisei arrumar um pelo menos para poder usado aqui. Ai estão as fotos 😀 Foi testado e está funcionando corretamente agora. Foi arrumado na gambiarra, mas ta arrumado. &nbsp;
