---
title: "Big Gate Boy | Lets Hack It"
description: "An open FPGA Game Boy experiment built around a Lattice ECP5, a Verilog CPU core, and six reverse-engineered LED panels."
image: "https://lucasteske.dev/assets/lyd6168/20201029_001922.jpg"
---

Written by Lucas Teske   
on 16 January 2021

# Big Gate Boy

An open FPGA experiment that rebuilds the Game Boy in programmable logic and aims it at a gloriously oversized six-panel display.

Open hardware · FPGA · Verilog
## Game Boy, rebuilt gate by gate.

Big Gate Boy explores a Game Boy-compatible CPU in Verilog for a Lattice ECP5, with six LED panels as the oversized display target. The source, tests, live sessions, and panel reverse engineering are collected here.

[Browse the source](https://github.com/racerxdl/biggateboy/)[Watch the build](https://www.youtube.com/playlist?list=PLEP_M2UAh9q7uSd0U_beeeF6FGvOSb_zy)

 ![Game Boy graphics running across a large LED panel](/assets/lyd6168/20201029_001922.jpg)

1. [CPU core and opcode map](/biggateboy/microcode)
2. [Assembly tests](https://github.com/racerxdl/biggateboy/tree/main/testdata)
3. [Panel reverse engineering](/lyd6168)
4. Six-panel display target

Processor reference
### CPU core and instruction map

Read the opcode conventions, register groups, ALU operations, and instruction map used while implementing the core.

[Open the microcode reference](/biggateboy/microcode)

Display hardware
### LYD6168 panel research

Follow the investigation that identified the undocumented LYD6168 panels as MBI5153-compatible hardware.

[Read the panel investigation](/lyd6168)

Build in public
### Development sessions

Watch the project take shape in the recorded livestream sessions, from CPU work to hardware experiments.

[Open the YouTube playlist](https://www.youtube.com/playlist?list=PLEP_M2UAh9q7uSd0U_beeeF6FGvOSb_zy)

Open source
### Verilog, tests, and tooling

Browse the CPU modules, ALU and register-bank test benches, assembly test programs, constraints, and build tooling.

[View the repository](https://github.com/racerxdl/biggateboy/)

- [Identify and test the panel controller](/lyd6168/testing-ic)A step-by-step path through the vendor software and driver-IC detection process.
- [Change the receiver-card FPGA firmware](/lyd6168/upgrade-fpga)Notes for loading the S-PWM-capable firmware required by these panels.
- [MBI5153 controller datasheet](/assets/lyd6168/MBI-MBI5153GP_C183654.pdf)The controller reference that made the LYD6168 behavior understandable.

Project status

This is an honest work in progress. The CPU notes, source, tests, and panel research are published as they exist; unfinished timing documentation is not presented as complete.
