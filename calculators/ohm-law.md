---
title: Ohm Law Calculator
date: 2013-06-13T00:00:00-03:00
author: Lucas Teske
layout: page
guid: http://www.energylabs.com.br/el/calculadora/ohmlaw
---

<script>
function fn(num) {
  return parseFloat(num.replace(",", "."));
}

function calcohmlaw() {
    var P = document.getElementsByName("P")[0].value;
    var V = document.getElementsByName("V")[0].value;
    var I = document.getElementsByName("I")[0].value;
    var R = document.getElementsByName("R")[0].value;

    if (P == '' & V == '') {
        V = fn(R) * fn(I);
        P = fn(V) * fn(I);
    } else if (P == '' & R == '') {
        R = fn(V) / fn(I);
        P = fn(V) * fn(I);
    } else if (P == '' & I == '') {
        I = fn(V) / fn(R);
        P = fn(V) * fn(I);
    } else if (V == '' & R == '') {
        V = fn(P) / fn(I);
        R = fn(V) / fn(I);
    } else if (V == '' & I == '') {
        I = Math.sqrt(fn(P) / fn(R));
        V = fn(P) / fn(I);
    } else if (R == '' & I == '') {
        I = fn(P) / fn(V);
        R = fn(V) / fn(I);
    }

    document.getElementsByName("P")[0].value = P;
    document.getElementsByName("V")[0].value = V;
    document.getElementsByName("R")[0].value = R;
    document.getElementsByName("I")[0].value = I;
}
</script>
<center>
<table width="397" height="155" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="19" colspan="6" valign="top"><center>Fill two values to calculate othre two</center></td>
  </tr>
  <tr>
    <td width="83" height="15"></td>
    <td width="144"></td>
    <td width="27"></td>
    <td width="39"></td>
    <td width="62"></td>
    <td width="42"></td>
  </tr>
  <tr>
    <td height="22" valign="top">Voltage:</td>
    <td valign="top"><input type="text" name="V" /></td>
    <td valign="top">&nbsp;V</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">Current:</td>
    <td rowspan="2" valign="top"><input type="text" name="I" /></td>
    <td rowspan="2" valign="top">&nbsp;A</td>
    <td height="12"></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td height="10"></td>
    <td rowspan="2" valign="top">
      <input name="calcohm" type="button" id="calcohm" onclick="javascript:calcohmlaw();" value="Calculate" />
    </td>
    <td></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">Resistance:</td>
    <td rowspan="2" valign="top"><input type="text" name="R" /></td>
    <td rowspan="2" valign="top">&nbsp;&Omega;&nbsp;</td>
    <td height="14"></td>
    <td></td>
  </tr>
  <tr>
    <td height="8"></td>
    <td></td>
    <td></td>
  </tr>
<tr>
    <td height="22" valign="top">Power:</td>
    <td valign="top"><input type="text" name="P" /></td>
    <td valign="top">&nbsp;W</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td height="13"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>

  <tr>
    <td height="19" colspan="6" valign="top"><center>P = V * I - V = R * I</center></td>
  </tr>
</table>
</center>