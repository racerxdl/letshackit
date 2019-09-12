---
title: Capacitor Reactance Calculator
date: 2013-06-13T00:00:00-03:00
author: Lucas Teske
layout: page
guid: http://www.energylabs.com.br/el/calculadora/capreac
---

<script>
function calccapreac() {
		var C;
		var F;
		var Xc;
		C = document.capreac.C.value;
		F = document.capreac.F.value;
		Xc = document.capreac.Xc.value;
		if (Xc == '') {
				Xc = 1 / (2 * 3.14159 * F * C) * 1e3;
		} else if (C == '') {
				C = 1 / (2 * 3.14159 * F * Xc / 1e3);
		} else if (F == '') {
				F = 1 / (2 * 3.14159 * C * Xc / 1e3);
		}
		document.capreac.C.value = parseFloat(C);
		document.capreac.F.value = parseFloat(F);
		document.capreac.Xc.value = parseFloat(Xc);
}
</script>
<center>
	<form id="capreac" name="capreac" method="post" action="">
	   <table width="397" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	         <td height="20" colspan="6" valign="top">
	            <center>Fill two values to calculate other.</center>
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
	         <td height="22" valign="top">Capacitance:</td>
	         <td valign="top"><input name="C" type="text" id="C" /></td>
	         <td valign="top">&nbsp;uF</td>
	         <td>&nbsp;</td>
	         <td>&nbsp;</td>
	         <td>&nbsp;</td>
	      </tr>
	      <tr>
	         <td height="24" valign="top">Frequency:</td>
	         <td valign="top"><input name="F" type="text" id="F" /></td>
	         <td valign="top">&nbsp;kHz</td>
	         <td>&nbsp;</td>
	         <td valign="top"><input name="calccap" type="button" id="calccap" onclick="javascript:calccapreac();" value="Calculate" /></td>
	         <td>&nbsp;</td>
	      </tr>
	      <tr>
	         <td height="22" valign="top">Reactance:</td>
	         <td valign="top"><input type="text" name="Xc" /></td>
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
	            <center>Xc = 1 / (2*&pi;*F*C)</center>
	         </td>
	      </tr>
	   </table>
	</form>
</center>