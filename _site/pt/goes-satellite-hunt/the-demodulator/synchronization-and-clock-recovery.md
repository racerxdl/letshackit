---
title: "Synchronization and Clock Recovery - GOES Satellite Hunt | Lets Hack It"
description: "Escrito por Lucas Teske em 19 Fevereiro 2017 Parte de GOES Satellite Hunt Visão geral do projeto → Synchronization and Clock Recovery As I talked before, we will use 2nd Order Costas Loop as Carrier Wave Recovery (synchronization) and M&M Clock Recovery to recover the Symbol Clock. GNU Radio provides..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 19 Fevereiro 2017

# 

# Synchronization and Clock Recovery

As I talked before, we will use 2nd Order Costas Loop as Carrier Wave Recovery (synchronization) and M&M Clock Recovery to recover the Symbol Clock. GNU Radio provides blocks for both algorithms. Let’s start with Costas Loop.

![Costas Loop block diagram with loop bandwidth 1.99m and order 2.](/assets/goes-satellite-hunt/costas-loop-grc.png)

Costas Loop

For the parameters we will only need&nbsp; **0.00199 as Loop Bandwidth** and&nbsp; **2 as Order**. After that we should have our virtual carrier in the base band. Now we only need to synchronize our samples with clock using M&M Clock Recovery.

![Clock Recovery MM block with parameters: Omega, Gain Omega, Mu, Gain Mu, Omega Relative Limit.](/assets/goes-satellite-hunt/mm-recovery.png)

M&M Clock Recovery

For the M&M Parameters we will use&nbsp; **Omega as 4.25339** that is basically our symbols per sample rate, or sample\_rate / symbol\_rate. That is the first symbolrate guess for M&M. For&nbsp;**Gain Omega we use (alpha ^ 2) / 4, that is alpha = 3.7e-3, so our Gain Omega be 3.4225e-6**,&nbsp; **Mu as 0.5** ,&nbsp;**Gain Mu as alpha (or 3.7e-3)**,&nbsp; **Omega Relative Limit as 5e-3**.

So you can notice that I called a new parameter&nbsp; **alpha** in M&M that is not a direct parameter of the block. That alpha is a parameter to adjust how much the M&M clock recovery can deviate from the initial guess. You can experiment with your own values, but 3.7e-3 was the best option to me.

Now at the output of M&M we will have our Complex Symbols pumped out with the correct rate. Now we only need to extract our values.

## Cite este trabalho

### Citação sugerida

Lucas Teske. “GOES Satellite Hunt.” _Lets Hack It_, 2017. [https://lucasteske.dev/goes-satellite-hunt/](https://lucasteske.dev/goes-satellite-hunt/).

### BibTeX

```
@misc{teske2017goessatellitehunt,
  author = {Teske, Lucas},
  title = {GOES Satellite Hunt},
  year = {2017},
  publisher = {Lets Hack It},
  url = {https://lucasteske.dev/goes-satellite-hunt/}
}
```
