---
title: Boost Converter Calculator
date: 2013-06-13T00:00:00-03:00
author: Lucas Teske
layout: page
guid: http://www.energylabs.com.br/el/calculadora/boostconv
---

<script type="text/javascript">
function putunit(v) {
    var lastunit = '';
    var units = ["m", "&micro;", "n", "p"];
    var counter = 0;
    var value = v;
    while (value < 1) {
        lastunit = units[counter];
        counter++;
        value = value * 1e3;
        if (counter == 5)
            break;
    }
    value = Math.round(value * 1e2) / 1e2;
    return "<B>" + value + "</B> " + lastunit;
}

function calc() {
    var Vout = document.getElementById("vout").value;
    var Vin = document.getElementById("vin").value;
    var Vdrop = document.getElementById("vripple").value;
    var n = document.getElementById("eff").value / 100;
    var freq = document.getElementById("freq").value * 1e3;
    var Iout = document.getElementById("iout").value;
    var nV = Vin / (Vout - Vin);
    var Rl = Vout / Iout;
    var T = 1 / freq;
    var tOntR = T * n;
    var L = (tOntR * Rl * n * Math.pow(Vin, 2)) / ((1 + nV) * 2 * Math.pow(Vout, 2));
    var tOn = (2 * L * Math.pow(Vout, 2)) / (Rl * n * Math.pow(Vin, 2));
    var tR = nV * tOn;
    var Ipeak = Vin / L * tOn;
    var Cout = Ipeak * (T - tR) / Vdrop;
    document.getElementById("resultl").innerHTML = putunit(L) + "H";
    document.getElementById("resultc").innerHTML = putunit(Cout) + "F";
    document.getElementById("resultton").innerHTML = putunit(tOn) + "s";
    document.getElementById("resulttr").innerHTML = putunit(tR) + "s";
    document.getElementById("resultipeak").innerHTML = putunit(Ipeak) + "A";
}
</script>
<center>
  <table width="505" border="0" cellpadding="0" cellspacing="0">
     <tr>
        <td width="172" height="30">&nbsp;</td>
        <td width="19">&nbsp;</td>
        <td width="63">&nbsp;</td>
        <td width="55">&nbsp;</td>
        <td width="90">&nbsp;</td>
        <td width="37">&nbsp;</td>
        <td width="48">&nbsp;</td>
        <td width="21">&nbsp;</td>
     </tr>
     <tr>
        <td height="22" valign="top">Input Voltage </td>
        <td>&nbsp;</td>
        <td valign="top">
           <center>    (<strong>Vin</strong>)  </center>
        </td>
        <td>&nbsp;</td>
        <td valign="top"><input name="vin" type="text" id="vin" size="15"></td>
        <td>&nbsp;</td>
        <td valign="top">
           <center>    V  </center>
        </td>
        <td>&nbsp;</td>
     </tr>
     <tr>
        <td height="8"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="22" valign="top">Output Voltage </td>
        <td></td>
        <td valign="top">
           <center>    (<strong>Vout</strong>)  </center>
        </td>
        <td></td>
        <td valign="top"><input name="vout" type="text" id="vout" size="15"></td>
        <td></td>
        <td valign="top">
           <center>    V  </center>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="8"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="22" valign="top">Efficiency</td>
        <td></td>
        <td valign="top">
           <center>    (<strong>n</strong>)  </center>
        </td>
        <td></td>
        <td valign="top"><input name="eff" type="text" id="eff" size="15"></td>
        <td></td>
        <td valign="top">
           <center>    %  </center>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="8"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="22" valign="top">Work Frequency </td>
        <td></td>
        <td valign="top">
           <center>    (<strong>F</strong>)  </center>
        </td>
        <td></td>
        <td valign="top"><input name="freq" type="text" id="freq" size="15"></td>
        <td></td>
        <td valign="top">
           <center>    kHz  </center>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="8"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="22" valign="top">Ripple Voltage </td>
        <td></td>
        <td valign="top">
           <center>    (<strong>Vripple</strong>)  </center>
        </td>
        <td></td>
        <td valign="top"><input name="vripple" type="text" id="vripple" size="15"></td>
        <td></td>
        <td valign="top">
           <center>    V  </center>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="8"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="22" valign="top">Max Load </td>
        <td></td>
        <td valign="top">
           <center>    (<strong>Iout</strong>)  </center>
        </td>
        <td></td>
        <td valign="top"><input name="iout" type="text" id="iout" size="15"></td>
        <td></td>
        <td valign="top">
           <center>    A  </center>
        </td>
        <td>&nbsp;</td>
     </tr>
     <tr>
        <td height="17"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="24" colspan="8" valign="top">
            <center>
              <input type="button" name="calc" value="Calculate" onclick="calc();">
            </center>
        </td>
     </tr>
     <tr>
        <td height="20">&nbsp;</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="21" valign="top"><strong>Result:</strong></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="20">&nbsp;</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="19" valign="top">Inductor</td>
        <td></td>
        <td valign="top">
           <center>    (<strong>L</strong>)  </center>
        </td>
        <td></td>
        <td colspan="3" valign="top">
           <div id="resultl" align="center">          <B>XX</B> H             </div>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="11"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="19" valign="top">Capacitor</td>
        <td></td>
        <td valign="top">
           <center>    (<strong>C</strong>)  </center>
        </td>
        <td></td>
        <td colspan="3" valign="top">
           <div id="resultc" align="center">                <B>XX</B> F             </div>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="11"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="19" valign="top">Peak Current </td>
        <td></td>
        <td valign="top">
           <center>    (<strong>Ipeak</strong>)  </center>
        </td>
        <td></td>
        <td colspan="3" valign="top">
           <div id="resultipeak" align="center">    <B>XX</B> A             </div>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="11"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="19" valign="top">On Time </td>
        <td></td>
        <td valign="top">
           <center>(<strong>tOn</strong>)</center>
        </td>
        <td></td>
        <td colspan="3" valign="top">
           <div id="resultton" align="center">  <B>XX</B> s             </div>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="11"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td rowspan="2" valign="top">Ripple Time </td>
        <td height="1"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="19"></td>
        <td rowspan="2" valign="top">
           <center>(<strong>tR</strong>)</center>
        </td>
        <td></td>
        <td colspan="3" rowspan="2" valign="top">
           <div id="resulttr" align="center">          <B>XX</B> s             </div>
        </td>
        <td></td>
     </tr>
     <tr>
        <td height="1"></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr>
        <td height="19"></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
  </table>
  <BR />
  <div style="background-color: #000000">
    <img src="/assets/calculators/boostbasic.png" />
  </div>
</center>