---
title: "BGB - Instructions | Lets Hack It"
description: "Escrito por Lucas Teske em 16 Janeiro 2021 DISCLAIMER This document is only a reference and is poorly written. I promise I will do a better one in the future. Instruction Decoding For better explanation and instruction decoding, I did some convention to explain the opcode masks and functions. The..."
image: "https://lucasteske.dev/assets/cropped-logo.png"
---

Escrito por Lucas Teske   
em 16 Janeiro 2021

# 

# DISCLAIMER

This document is only a reference and is poorly written. I promise I will do a better one in the future.

# Instruction Decoding

For better explanation and instruction decoding, I did some convention to explain the opcode masks and functions. The first part is the instruction decoding, we define three bit mask groups: X, Y and Z

| Instruction Byte |
| --- |
| Bit Number | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
| Mask | X | X | Y | Y | Y | Z | Z | Z |

I also did some ALU opcode, call/jump conditions mask grouping. Along with that, I will define the terms I will be using in this document.

| Term | Meaning |
| IMM | Immediate value. Comes from next position in memory |
| s8 | Signed 8 bit value IMM |
| u8 | Unsigned 8 bit value IMM |
| u16 | Unsigned 16 bit value IMM |
| RG0 | [Register Group 0](#register-group-0) |
| RG1 | [Register Group 1](#register-group-1) |
| COND | [Conditions](#register-group-1) |
| ALUOP0 | [ALU Operations Group 0](#register-group-0) |
| ALUOP1 | [ALU Operations Group 1](#register-group-1) |

# Mask / Opcodes

| X = 00 |
| Y Y Y | Z Z Z | Instruction |
| 0 0 0 | 0 0 0 | NOP |
| 0 0 1 | 0 0 0 | LD [u16], SP |
| 0 1 0 | 0 0 0 | STOP |
| 0 1 1 | 0 0 0 | JR s8 |
| 1 Y Y | 0 0 0 | JR [COND[Y]](#condition-group) s8 |
| Y Y 0 | 0 0 1 | LD [RG1[Y]](#register-1-group), u16 |
| Y Y 1 | 0 0 1 | ADD HL, [RG1[Y]](#register-1-group) |

| 0 0 0 | 0 1 0 | LD [BC], A |
| 0 0 1 | 0 1 0 | LD A, [BC] |
| 0 1 0 | 0 1 0 | LD [DE], A |
| 0 1 1 | 0 1 0 | LD A, [DE] |

| 1 0 0 | 0 1 0 | LD [HL+], A |
| 1 0 1 | 0 1 0 | LD A, [HL+] |
| 1 1 0 | 0 1 0 | LD [HL-], A |
| 1 1 1 | 0 1 0 | LD A, [HL-] |

| Y Y 0 | 0 1 1 | INC [RG1[Y]](#register-group-1) |
| Y Y 1 | 0 1 1 | DEC [RG1[Y]](#register-group-1) |
| Y Y Y | 1 0 0 | INC [RG0[Y]](#register-group-0) |
| Y Y Y | 1 0 1 | DEC [RG0[Y]](#register-group-0) |
| Y Y Y | 1 1 0 | LD[RG0[Y]](#register-group-0), u8 |
| Y Y Y | 1 1 1 | [ALUOP1[Y] ](#alu-operations-group-1) |

| X = 01 |
| Y Y Y | Z Z Z | Instruction |
| 1 1 0 | 1 1 0 | HALT |
| y y y | z z z | LD [RG0[Y]](#register-group-0), [RG0[Z]](#register-group-0) |

| X = 10 |
| Y Y Y | Z Z Z | Instruction |
| Y Y Y | Z Z Z | [ALUOP0[Y] ](#alu-operations-group-1) [RG0[Z] ](#register-group-0) |

| X = 11 |
| Y Y Y | Z Z Z | Instruction |
| 0 Y Y | 0 0 0 | RET [COND[Y]](#condition-group) |
| 1 0 1 | 0 0 0 | ADD SP, s8 |
| 1 0 0 | 0 0 0 | LD [0xFF00 + u8], A |
| 1 1 0 | 0 0 0 | LD A, [0xFF00 + u8] |
| 1 1 1 | 0 0 0 | LD HL, SP + s8 |
| y y 0 | 0 0 1 | POP [RG2[Y]](#register-group-2) |
| 0 0 1 | 0 0 1 | RET |
| 0 1 1 | 0 0 1 | RETI |
| 1 0 1 | 0 0 1 | JP HL |
| 1 1 1 | 0 0 1 | LD HL, SP |
| 0 y y | 0 1 0 | JP [COND[Y]](#condition-group) |
| 1 0 0 | 0 1 0 | LD [0xFF00 + C], A |
| 1 0 1 | 0 1 0 | LD [u16], A |
| 1 1 0 | 0 1 0 | LD A, [0xFF00 + C] |
| 1 1 1 | 0 1 0 | LD A, [u16] |
| 0 0 0 | 0 1 1 | JP u16 |
| 0 0 1 | 0 1 1 | CB u8 |
| 0 1 0 | 0 1 1 | UNDEFINED |
| 0 1 1 | 0 1 1 | UNDEFINED |
| 1 0 0 | 0 1 1 | UNDEFINED |
| 1 0 1 | 0 1 1 | UNDEFINED |
| 1 1 0 | 0 1 1 | DI |
| 1 1 1 | 0 1 1 | EI |
| 0 y y | 1 0 0 | CALL [COND[Y]](#condition-group), u16 |
| 1 0 0 | 1 0 0 | UNDEFINED |
| 1 0 1 | 1 0 0 | UNDEFINED |
| 1 1 0 | 1 0 0 | UNDEFINED |
| 1 1 1 | 1 0 0 | UNDEFINED |
| y y 0 | 1 0 1 | PUSH [RG2[Y]](#register-group-2) |
| 0 0 1 | 1 0 1 | CALL u16 |
| 0 1 1 | 1 0 1 | UNDEFINED |
| 1 0 1 | 1 0 1 | UNDEFINED |
| 1 1 1 | 1 0 1 | UNDEFINED |
| y y y | 1 1 0 | [ALUOP0[Y] ](#alu-operations-group-0) A, u8 |
| y y y | 1 1 1 | RST 0b00YYY000 |

# Prefix CB

After a `0xCB` byte, the next byte should determine the instruction to execute

| XX | Y Y Y | Z Z Z | Instruction |
| 00 | Y Y Y | Z Z Z | [ALUOP2[Y] ](#alu-operations-group-2) [RG0[Z] ](#register-group-0) |
| 01 | Y Y Y | Z Z Z | BIT Y, [RG0[Z] ](#register-group-0) |
| 10 | Y Y Y | Z Z Z | RES Y, [RG0[Z] ](#register-group-0) |
| 11 | Y Y Y | Z Z Z | SET Y, [RG0[Z] ](#register-group-0) |

# References

## Register Group 0

| Reg Group 0 |
| Index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| Value | B | C | D | E | H | L | [HL] | A |

## Register Group 1

| Reg Group 1 |
| Index | 0 | 1 | 2 | 3 |
| Value | BC | DE | HL | SP |

## Register Group 2

| Reg Group 2 |
| Index | 0 | 1 | 2 | 3 |
| Value | BC | DE | HL | AF |

## Condition Group

| Condition Group |
| Index | 0 | 1 | 2 | 3 |
| Value | NZ | Z | NC | C |

## ALU Operations Group 0

| ALU Operation 0 |
| Index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| Value | ADD | ADC | SUB | SBC | AND | XOR | OR | CP |

## ALU Operations Group 1

| ALU Operation 1 |
| Index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| Value | RLCA | RRCA | RLA | RRA | DAA | CPL | SCF | CCF |

## ALU Operations Group 2

| ALU Operation 2 |
| Index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
| Value | RLC | RRC | RL | RR | SLA | SRA | SWAP | SRL |
