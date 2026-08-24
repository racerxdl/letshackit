---
title: "IP Cam – MayGion | Lets Hack It"
description: "Montando um QuadCopter? Descubra como hackear a câmera IP MayGion. Análise de hardware, processador MIPS e uso de USB UVC no Linux."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

# IP Cam – MayGion

Escrito por Lucas Teske   
em 18 Janeiro 2014

Bom, estou montando um QuadCopter e sai procurando cameras para colocar nele.

Na minha lista de opções coloquei 3 câmeras IP:

1) MayGion IP cam (comprada na Dealextreme, 640×480)

2) DSC-930L (D-LINK 640×480)

3) DSC-2130 (D-LINK 1280×800)

Comecei a desmontar a MayGion pra ver como ela era. Ai vai umas fotos

![image](https://31.media.tumblr.com/41e6b536cc37c4358192a86d7329e0ae/tumblr_inline_mzmhhfrbLV1rvy8i7.jpg)

Essa é a placa principal. O microcontrolador parece proprietário (ao menos, não conheço a marca). Pela engenharia reversa na firmware, é um processador MIPS que roda a cerca de 400MHz.

![image](https://31.media.tumblr.com/19fe72857a4b9e315ad515d7e45be324/tumblr_inline_mzmhj1PUuf1rvy8i7.jpg)

A câmera usa motores de passo para os controles dos eixos, um jeito bem preciso de mexer a câmera.

![image](https://31.media.tumblr.com/98b6ada64fac473dcda34e0451068451/tumblr_inline_mzmhk0Vpsx1rvy8i7.jpg)

![image](https://31.media.tumblr.com/ece03b9c30537a01a6836e0ee8689a09/tumblr_inline_mzmhk8QWV61rvy8i7.jpg)

![image](https://31.media.tumblr.com/04230cbd3d5bee32a10bae0c5081a62a/tumblr_inline_mzmhknAgpV1rvy8i7.jpg)

A câmera (para minha surpresa) é USB. Deduzi então que fosse uma câmera genérica compatível com UVC. Para ajudar mais ainda, os bons chineses deixaram os pinos no padrão do USB. Logo, Lets Hack it!

![image](https://31.media.tumblr.com/1b6e0950b63146a86cd25d166c5555a6/tumblr_inline_mzmhm9Yqtc1rvy8i7.jpg)

Ligando no meu notebook usando Linux tenho: ![image](https://31.media.tumblr.com/9c5dd7d93b8136c30910e4e611d4fd98/tumblr_inline_mzmhmwiVBN1rvy8i7.png)

Bingo! Uma câmera UVC Sonix. Tudo funcionando ótimo! 😀

![image](https://31.media.tumblr.com/e9bf5c587cb45c7381c4d1e9fb21c007/tumblr_inline_mzmho15lIy1rvy8i7.png)

![image](https://31.media.tumblr.com/8fe2b8f52a62d228d5f70f390e4b30a4/tumblr_inline_mzmhoinMKu1rvy8i7.png)

![image](https://31.media.tumblr.com/9a083ed6b325f4c187cc7245f4ebf93d/tumblr_inline_mzmhoxbBoS1rvy8i7.png)

Bom, por hoje é só isso! Em breve devo postar notícias sobre meu QuadCopter! 😀

## Cite este artigo

### Citação sugerida

Lucas Teske. “IP Cam – MayGion.” _Lets Hack It_, 2014. [https://lucasteske.dev/pt/2014/01/ip-cam-maygion/](https://lucasteske.dev/pt/2014/01/ip-cam-maygion/).

### BibTeX

```
@misc{teske2014ipcammaygion,
  author = {Lucas Teske},
  title = {IP Cam – MayGion},
  year = {2014},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/pt/2014/01/ip-cam-maygion/}
}
```
