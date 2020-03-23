---
title: Synchronization and Clock Recovery - GOES Satellite Hunt
date: 2017-02-19T00:00:00-03:00
author: Lucas Teske
layout: page
---

# Synchronization and Clock Recovery

As I talked before, we will use 2nd Order Costas Loop as Carrier Wave Recovery \(synchronization\) and M&M Clock Recovery to recover the Symbol Clock. GNU Radio provides blocks for both algorithms. Let’s start with Costas Loop.

![](/assets/goes-satellite-hunt/costas-loop-grc.png)

Costas Loop

For the parameters we will only need **0.00199 as Loop Bandwidth**and **2 as Order**. After that we should have our virtual carrier in the base band. Now we only need to synchronize our samples with clock using M&M Clock Recovery.

![](/assets/goes-satellite-hunt/mm-recovery.png)

M&M Clock Recovery

For the M&M Parameters we will use **Omega as 4.25339**that is basically our symbols per sample rate, or sample\_rate / symbol\_rate. That is the first symbolrate guess for M&M. For **Gain Omega we use \(alpha ^ 2\) / 4, that is alpha = 3.7e-3, so our Gain Omega be 3.4225e-6**, **Mu as 0.5**, **Gain Mu as alpha \(or 3.7e-3\)**, **Omega Relative Limit as 5e-3**.

So you can notice that I called a new parameter **alpha**in M&M that is not a direct parameter of the block. That alpha is a parameter to adjust how much the M&M clock recovery can deviate from the initial guess. You can experiment with your own values, but 3.7e-3 was the best option to me.

Now at the output of M&M we will have our Complex Symbols pumped out with the correct rate. Now we only need to extract our values.

<div class="pagination">
    <a href="{{ 'automatic-gain-control-and-root-raised-cosine-filter' | prepend: site.baseurl }}" class="left arrow">&#8592;</a>

    <a href="{{ 'symbol-output-from-gnu-radio' | prepend: site.baseurl }}" class="right arrow">&#8594;</a>
</div>
