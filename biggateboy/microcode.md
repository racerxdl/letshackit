---
title: BGB - Instructions
date: 2021-01-16T18:25:00-03:00
author: Lucas Teske
layout: page
permalink: /biggateboy/microcode
---

{:text-style: style=";color: black;font-family:CMSSBX10;font-variant:normal;font-weight:normal;"}
{:head-style: class="table-head-style"}
{:x-style:    class="x-style"}
{:y-style:    class="y-style"}
{:z-style:    class="z-style"}

<style>
table {
  table-layout: fixed ;
  border-spacing: 0 0;
  width: 100% ;
}


td {
  background: #F0F0F0;
  padding-left: 10px;
  padding-right: 10px;
  font-family:CMSSBX10;
  font-size: 1em;
}

.table-head-style {
  background: #c0c0c0;
  color: black;
  font-weight: bold;
  font-size: 1.2em;
}
.table-ref {
  color:#006600;
  font-weight: bold;
}
.x-style {
  background:#4CB5F5;
  color:white;
}
.y-style {
  background:#484848;
  color:white;
}
.z-style {
  background:#6AB187;
  color:white;
}
.table-note {
  color: gray;
}
.op-undefined {
  color: red;
}
.op {
  color: #CC9900;
}
.u16 {
  color: #3399FF;
}
.u8 {
  color: #3366FF;
}
.s8 {
  color: #66CCFF;
}
.reg {
  color: #AAAA77;
}
.const {
  color: #996633;
}
</style>

# DISCLAIMER

This document is only a reference and is poorly written. I promise I will do a better one in the future.

# Instruction Decoding

For better explanation and instruction decoding, I did some convention to explain the opcode masks and functions.
The first part is the instruction decoding, we define three bit mask groups: X, Y and Z

<table>
  <tr>
    <th colspan=10>Instruction Byte {: head-style }</th>
  </tr>
  <tr>
    <td colspan=2 style="text-align: right">Bit Number{: head-style }</td>
    <td style="text-align: center"> 7 {:x-style} </td>
    <td style="text-align: center"> 6 {:x-style} </td>
    <td style="text-align: center"> 5 {:y-style} </td>
    <td style="text-align: center"> 4 {:y-style} </td>
    <td style="text-align: center"> 3 {:y-style} </td>
    <td style="text-align: center"> 2 {:z-style} </td>
    <td style="text-align: center"> 1 {:z-style} </td>
    <td style="text-align: center"> 0 {:z-style} </td>
  </tr>
  <tr>
    <td colspan=2 style="text-align: right">Mask{: head-style }</td>
    <td style="text-align: center"> X {:x-style} </td>
    <td style="text-align: center"> X {:x-style} </td>
    <td style="text-align: center"> Y {:y-style} </td>
    <td style="text-align: center"> Y {:y-style} </td>
    <td style="text-align: center"> Y {:y-style} </td>
    <td style="text-align: center"> Z {:z-style} </td>
    <td style="text-align: center"> Z {:z-style} </td>
    <td style="text-align: center"> Z {:z-style} </td>
  </tr>
</table>
<BR/>

I also did some ALU opcode, call/jump conditions mask grouping. Along with that, I will define the terms I will be using in this document.

|: Term {: head-style } :| Meaning                                                  {: head-style }     |||||
|: IMM    {:y-style} :| Immediate value. Comes from next position in memory                        |||||
|: <span class="s8">s8</span>     {:y-style} :| Signed 8 bit value <span class="table-note">IMM</span>                     |||||
|: <span class="u8">u8</span>     {:y-style} :| Unsigned 8 bit value <span class="table-note">IMM</span>                   |||||
|: <span class="u16">u16</span>    {:y-style} :| Unsigned 16 bit value <span class="table-note">IMM</span>                  |||||
|: <span class="table-ref">RG0</span>    {:y-style} :| <a href="#register-group-0" class="table-ref">Register Group 0</a>         |||||
|: <span class="table-ref">RG1</span>    {:y-style} :| <a href="#register-group-1" class="table-ref">Register Group 1</a>         |||||
|: <span class="table-ref">COND</span>   {:y-style} :| <a href="#register-group-1" class="table-ref">Conditions </a>              |||||
|: <span class="table-ref">ALUOP0</span> {:y-style} :| <a href="#register-group-0" class="table-ref">ALU Operations Group 0 </a>  |||||
|: <span class="table-ref">ALUOP1</span> {:y-style} :| <a href="#register-group-1" class="table-ref">ALU Operations Group 1 </a>  |||||

# Mask / Opcodes


|:                             X = 00  {: head-style }               :||||||||||||
|: Y Y Y {: head-style }:|: Z Z Z {: head-style }:|:Instruction  {: head-style }:||||||||||
|: 0 0 0 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">NOP</span>                                            ||||||||||
|: 0 0 1 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">LD</span> [<span class="u16">u16</span>], <span class="reg">SP</span>                                   ||||||||||
|: 0 1 0 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">STOP</span>                                           ||||||||||
|: 0 1 1 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">JR</span> <span class="s8">s8</span>                                          ||||||||||
|: 1 Y Y {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">JR</span> <a href="#condition-group" class="table-ref">COND[Y]</a> <span class="s8">s8</span>                          ||||||||||
|: Y Y 0 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">LD</span> <a href="#register-1-group" class="table-ref">RG1[Y]</a>, <span class="u16">u16</span>                       ||||||||||
|: Y Y 1 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">ADD</span> <span class="reg">HL</span>, <a href="#register-1-group" class="table-ref">RG1[Y]</a>                       ||||||||||
|: 0 0 1 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> [<span class="reg">BC</span>], <span class="reg">A</span>  ||||||||||
|: 0 1 1 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> [<span class="reg">DE</span>], <span class="reg">A</span>  ||||||||||
|: 1 0 1 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> [<span class="reg">HL</span>+], <span class="reg">A</span> ||||||||||
|: 1 1 1 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> [<span class="reg">HL</span>-], <span class="reg">A</span> ||||||||||
|: Y Y 0 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op">INC</span> <a href="#register-group-1" class="table-ref">RG1[Y]</a>                           ||||||||||
|: Y Y 1 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op">DEC</span> <a href="#register-group-1" class="table-ref">RG1[Y]</a>                           ||||||||||
|: Y Y Y {:y-style} :|: 1 0 0 {:z-style} :| <span class="op">INC</span> <a href="#register-group-0" class="table-ref">RG0[Y]</a>                       ||||||||||
|: Y Y Y {:y-style} :|: 1 0 1 {:z-style} :| <span class="op">DEC</span> <a href="#register-group-0" class="table-ref">RG0[Y]</a>                       ||||||||||
|: Y Y Y {:y-style} :|: 1 1 0 {:z-style} :| <span class="op">LD</span>  <a href="#register-group-0" class="table-ref">RG0[Y]</a>, u8                   ||||||||||
|: Y Y Y {:y-style} :|: 1 1 1 {:z-style} :| <a href="#alu-operations-group-1" class="table-ref"> ALUOP1[Y] </a> ||||||||||


|:                             X = 01  {: head-style }               :||||||||||||
|: Y Y Y {: head-style }:|: Z Z Z {: head-style }:|:Instruction  {: head-style }:||||||||||
|: 1 1 0 {:y-style} :|: 1 1 0 {:z-style} :| <span class="op">HALT</span>                                            ||||||||||
|: y y y {:y-style} :|: z z z {:z-style} :| <span class="op">LD</span> <a href="#register-group-0" class="table-ref">RG0[Y]</a>, <a href="#register-group-0" class="table-ref">RG0[Z]</a>                                            ||||||||||



|:                             X = 10  {: head-style }               :||||||||||||
|: Y Y Y {: head-style }:|: Z Z Z {: head-style }:|:Instruction  {: head-style }:||||||||||
|: Y Y Y {:y-style} :|: Z Z Z {:z-style} :| <a href="#alu-operations-group-1" class="table-ref"> ALUOP0[Y] </a> <a href="#register-group-0" class="table-ref"> RG0[Z] </a>                                           ||||||||||



|:                             X = 11  {: head-style }               :||||||||||||
|: Y Y Y {: head-style }:|: Z Z Z {: head-style }:|:Instruction  {: head-style }:||||||||||
|: 0 Y Y {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">RET</span> <a href="#condition-group" class="table-ref">COND[Y]</a> ||||||||||
|: 1 0 1 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">ADD</span> <span class="reg">SP</span>, <span class="s8">s8</span> ||||||||||
|: 1 0 0 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">LD</span> [<span class="const">0xFF00</span> + <span class="u8">u8</span>], <span class="reg">A</span>                  ||||||||||
|: 1 1 0 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">LD</span> <span class="reg">A</span>, [<span class="const">0xFF00</span> + <span class="u8">u8</span>]                   ||||||||||
|: 1 1 1 {:y-style} :|: 0 0 0 {:z-style} :| <span class="op">LD</span> <span class="reg">HL</span>, <span class="reg">SP</span> + <span class="s8">s8</span>                        ||||||||||
|: y y 0 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">POP</span> <a href="#register-group-2" class="table-ref">RG2[Y]</a>                 ||||||||||
|: 0 0 1 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">RET</span>                                   ||||||||||
|: 0 1 1 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">RETI</span>                                  ||||||||||
|: 1 0 1 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">JP</span> <span class="reg">HL</span>                                 ||||||||||
|: 1 1 1 {:y-style} :|: 0 0 1 {:z-style} :| <span class="op">LD</span> <span class="reg">HL</span>, <span class="reg">SP</span>                             ||||||||||
|: 0 y y {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">JP</span> <a href="#condition-group" class="table-ref">COND[Y]</a>                     ||||||||||
|: 1 0 0 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> [<span class="const">0xFF00</span> + <span class="reg">C</span>], <span class="reg">A</span>                    ||||||||||
|: 1 0 1 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> [<span class="u16">u16</span>], <span class="reg">A</span>                           ||||||||||
|: 1 1 0 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> <span class="reg">A</span>, [<span class="const">0xFF00</span> + <span class="reg">C</span>]                    ||||||||||
|: 1 1 1 {:y-style} :|: 0 1 0 {:z-style} :| <span class="op">LD</span> <span class="reg">A</span>, [<span class="u16">u16</span>]                           ||||||||||
|: 0 0 0 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op">JP</span> <span class="u16">u16</span>                                ||||||||||
|: 0 0 1 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op">CB</span> <span class="u8">u8</span>                                 ||||||||||
|: 0 1 0 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 0 1 1 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 0 0 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 0 1 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 1 0 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op">DI</span>                                    ||||||||||
|: 1 1 1 {:y-style} :|: 0 1 1 {:z-style} :| <span class="op">EI</span>                                    ||||||||||
|: 0 y y {:y-style} :|: 1 0 0 {:z-style} :| <span class="op">CALL</span> <a href="#condition-group" class="table-ref">COND[Y]</a>, <span class="u16">u16</span>              ||||||||||
|: 1 0 0 {:y-style} :|: 1 0 0 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 0 1 {:y-style} :|: 1 0 0 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 1 0 {:y-style} :|: 1 0 0 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 1 1 {:y-style} :|: 1 0 0 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: y y 0 {:y-style} :|: 1 0 1 {:z-style} :| <span class="op">PUSH</span> <a href="#register-group-2" class="table-ref">RG2[Y]</a>                 ||||||||||
|: 0 0 1 {:y-style} :|: 1 0 1 {:z-style} :| <span class="op">CALL</span> <span class="u16">u16</span>                              ||||||||||
|: 0 1 1 {:y-style} :|: 1 0 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 0 1 {:y-style} :|: 1 0 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: 1 1 1 {:y-style} :|: 1 0 1 {:z-style} :| <span class="op-undefined">UNDEFINED</span>                             ||||||||||
|: y y y {:y-style} :|: 1 1 0 {:z-style} :| <a href="#alu-operations-group-0" class="table-ref"> ALUOP0[Y] </a> <span class="reg">A</span>, <span class="u8">u8</span> ||||||||||
|: y y y {:y-style} :|: 1 1 1 {:z-style} :| <span class="op">RST</span> <span class="const">0b00</span><span class="table-ref">YYY</span><span class="const">000</span>                        ||||||||||


# References

## Register Group 0

|: Reg Group 0 {: head-style } :|||||||||
|: Index{: head-style } :|: 0 :|: 1 :|: 2 :|: 3 :|: 4 :|: 5 :|: 6  :|:7:|
|: Value{: head-style } :|: B :|: C :|: D :|: E :|: H :|: L :|:[HL]:|:A:|

## Register Group 1

|: Reg Group 1 {: head-style } :|||||
|: Index{: head-style } :|: 0 :|: 1 :|: 2 :|: 3 :|
|: Value{: head-style } :|: BC :|: DE :|: HL :|: SP :|

## Register Group 2

|: Reg Group 2 {: head-style } :|||||
|: Index{: head-style } :|: 0 :|: 1 :|: 2 :|: 3 :|
|: Value{: head-style } :|: BC :|: DE :|: HL :|: AF :|

## Condition Group

|: Condition Group {: head-style } :|||||
|: Index{: head-style } :|: 0 :|: 1 :|: 2 :|: 3 :|
|: Value{: head-style } :|: NZ :|: Z :|: NC :|: C :|

## ALU Operations Group 0

|:                                 ALU Operation 0                    {: head-style } :|||||||||
|: Index{: head-style } :|:  0  :|:  1  :|:  2  :|:  3  :|:  4  :|:  5  :|:  6 :|:  7 :|
|: Value{: head-style } :|: ADD :|: ADC :|: SUB :|: SBC :|: AND :|: XOR :|: OR :|: CP :|

## ALU Operations Group 1

|:                                 ALU Operation 1                    {: head-style } :|||||||||
|: Index{: head-style } :|:  0   :|:   1  :|:  2  :|:  3  :|:  4  :|:  5  :|:  6  :|:  7  :|
|: Value{: head-style } :|: RLCA :|: RRCA :|: RLA :|: RRA :|: DAA :|: CPL :|: SCF :|: CCF :|

