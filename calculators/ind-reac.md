---
title: Inductor Reactance Calculator
date: 2013-06-13T00:00:00-03:00
author: Lucas Teske
layout: page
guid: http://www.energylabs.com.br/el/calculadora/indreac
---

<script>
function calcindreac() {
    var L;
    var F;
    var Xl;
    L = document.indreac.L.value;
    F = document.indreac.F.value;
    Xl = document.indreac.Xl.value;
    if (Xl == '') {
        Xl = 2 * 3.1415 * F * L;
    } else if (L == '') {
        L = Xl / (2 * 3.1415 * F);
    } else if (F == '') {
        F = Xl / (2 * 3.1415 * L);
    }
    document.indreac.L.value = parseFloat(Math.round(L * 10000) / 10000);
    document.indreac.F.value = parseFloat(Math.round(F * 10000) / 10000);
    document.indreac.Xl.value = parseFloat(Math.round(Xl * 10000) / 10000);
}
</script>
<center>
   <form id="indreac" name="indreac" method="post" action="">
      <table width="397" border="0" cellspacing="0" cellpadding="0">
         <tr>
            <td height="20" colspan="6" valign="top">
               <center>Fill two values to calculate the other.</center>
            </td>
         </tr>
         <tr>
            <td width="95" height="14"></td>
            <td width="144"></td>
            <td width="32"></td>
            <td width="38"></td>
            <td width="62"></td>
            <td width="26"></td>
         </tr>
         <tr>
            <td height="22" valign="top">Inductance:</td>
            <td valign="top"><input name="L" type="text" id="L" /></td>
            <td valign="top">&nbsp;mH</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
         </tr>
         <tr>
            <td height="24" valign="top">Frequency:</td>
            <td valign="top"><input name="F" type="text" id="F" /></td>
            <td valign="top">&nbsp;kHz</td>
            <td>&nbsp;</td>
            <td valign="top"><input name="calcind" type="button" id="calcind" onclick="javascript:calcindreac();" value="Calculate" /></td>
            <td>&nbsp;</td>
         </tr>
         <tr>
            <td height="22" valign="top">Reactance:</td>
            <td valign="top"><input name="Xl" type="text" id="Xl" /></td>
            <td valign="top">&nbsp;&Omega;</td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
         <tr>
            <td height="15"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
         </tr>
         <tr>
            <td height="23" colspan="6" valign="top">
               <center> Xl = 2*&pi;*F*L</center>
            </td>
         </tr>
      </table>
   </form>
</center>