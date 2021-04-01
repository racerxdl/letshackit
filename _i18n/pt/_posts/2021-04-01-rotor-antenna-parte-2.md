---
title: 'Rotor de Antena - Parte 2'
date: 2021-04-01T02:23:00-03:00
author: Lucas Teske
layout: post
image: /assets/posts/tracker-mount-2/assembled-elevation-shaft.jpg
categories:
  - Reverse Engineering
  - Satellite
  - SDR
tags:
  - Airspy
  - EMWIN
  - GOES
  - Hearsat
  - LRIT
  - RE
  - Reverse Engineering
  - Sat
  - Satellite
  - SDR

---

Continuando o projeto do tracker, consegui alguns progressos significativos. Assim como o Demilson (PY2UEP) tinha cortado os motores originais, fiz o mesmo. O motor do azimute estava bem enferrujado e acabei estragando uma de suas bobinas (queria reaproveitar o fio), mas no fim o eixo saiu.

<hr>

Após o eixo removido, quebrei o imã com um martelo até que não sobrasse mais pedaços de imã no eixo, desta maneira restando apenas o suporte sextavado de onde era preso o imã.

![Suporte Sextavado do Imã 1](/assets/posts/tracker-mount-2/azimuth-motor-shaft.jpg)
![Suporte Sextavado do Imã 2](/assets/posts/tracker-mount-2/azimuth-motor-shaft2.jpg)
![Suporte Sextavado do Imã 3](/assets/posts/tracker-mount-2/azimuth-motor-shaft3.jpg)*Eixo do motor do azimute mostrando o suporte sextavado do imã*

Já para o motor da elevação, fiz um corte lateral no motor bem em uma marca circular que tem próximo a saída do motor. Desse jeito poderia usar o mesmo suporte e eixos do motor original para melhor acoplamento com o redutor.

!["tampa" do motor de elevação cortado](/assets/posts/tracker-mount-2/elevation-shaft-support.jpg)*"tampa" do motor de elevação cortado*
![Tampa + Redutor](/assets/posts/tracker-mount-2/elevation-shaft-support-with-reduction.jpg)*Tampa + Redutor*
![Peças do motor](/assets/posts/tracker-mount-2/elevation-motor-parts2.jpg)*Peças do Motor*

Para a elevação, foi nescessário cortar o do motor original e fazer um "vinco" na lateral dele para encaixar melhor na peça que seria impressa em 3D. Para fazer isso, coloquei o eixo original entre duas madeiras (por sugestão do meu pai) e efetuamos o corte do eixo. Para os vincos, usamos a esmerilhadeira.

![Eixo cortado no meio de duas madeiras](/assets/posts/tracker-mount-2/elevation-shaft-cut.jpg)*Eixo cortado no meio de duas madeiras*
![Eixo cortado na tampa do motor](/assets/posts/tracker-mount-2/elevation-shaft-support-with-shaft.jpg)*Eixo cortado na tampa do motor*

Com isso eu poderia, então, começar os desenhos em 3D para as adaptações.

## Impressões 3D

Depois de muita tentativa e erro, consegui acertar os encaixes entre os eixos. Porém percebi um problema: O espaço para o motor do azimute estava **extremamente** limitado, a ponto de meus motores NEMA 17 de 40mm serem grandes demais para o espaço. 

![Adaptação para Azimute](/assets/posts/tracker-mount-2/try-azimuth-44adapter.jpg)
![Adaptação para Azimute](/assets/posts/tracker-mount-2/try-azimuth-44adapter-place.jpg)*Adaptação para Azimute*

Para isso tive que comprar motores "slim" para o local. Fiquei um pouco preocupado com torque, mas minhas tentativas de fazer com engrenagens e tudo mais foram por água abaixo. Os motores em questão foram comprados a Aliexpress (confira no fim do post pelos links)

Enquanto o motor não chegava, fiquei otimizando os adaptadores para serem os mais curtos possíveis, economizando todo espaço possível. Eu uso o [FreeCAD](https://www.freecadweb.org/) por ser gratuito e também onde eu sei mexer melhor. Porém não assuma que eu realmente sou um designer 3D, pois eu não sou. As peças são apenas "funcionais".

![Adaptador de eixo do azimute](/assets/posts/tracker-mount-2/azimuth-shaft-adapter.jpg)*Adaptador de eixo do azimute*
![Suporte do azimute](/assets/posts/tracker-mount-2/azimuth-support.jpg)*Suporte do azimute*
![Adaptador de eixo da elevação](/assets/posts/tracker-mount-2/elevation-shaft-adapter.jpg)*Adaptador de eixo da elevação*
![Suporte da elevação](/assets/posts/tracker-mount-2/elevation-motor-adapter.jpg)*Suporte da elevação*
![](/assets/posts/tracker-mount-2/exploded-elevation-shaft.jpg)

E o primeiro eixo a funcionar foi o da elevação. Para isso usei motores de 40 mm NEMA17 (link no fim do post), que de fabrica eram closed-loop (com encoder magnético) porém acabei usando drivers TMC2209 por serem mais práticos e silenciosos.

![](https://www.youtube.com/watch?v=cfUtCqb3oxA)
![](https://www.youtube.com/watch?v=ENTpTZaiXl4)

Após a chegada dos novos motores para o azimute, tratei de logo montar tudo e ver se ia caber. E coube!

![Azimute](/assets/posts/tracker-mount-2/assembled-azimuth-support.jpg)
![Motor de Azimute no lugar](/assets/posts/tracker-mount-2/azimuth-motor-inplace.jpg)

E também funcionando!

![](https://www.youtube.com/watch?v=-4U-ofHaF0E)

Após tudo funcionando, fiz os testes para saber a resolução final e redução de ambos eixos. Para isso usei este codigo para o ESP32 controlar o TMC2209 e o meu celular preso ao eixo da elevação para medições de angulo. 

```cpp
#include <TMCStepper.h>

#define STEP_PIN         12 // Step
#define EN_PIN           23 // Enable

#define SERIAL_PORT Serial2 // TMC2208/TMC2224 HardwareSerial port
#define DRIVER_ADDRESS 0b00 // TMC2209 Driver address according to MS1 and MS2

#define R_SENSE 0.11f 

TMC2209Stepper driver(&SERIAL_PORT, R_SENSE, DRIVER_ADDRESS);

void setup() {
  pinMode(STEP_PIN, OUTPUT);
  pinMode(EN_PIN, OUTPUT);
  digitalWrite(EN_PIN, LOW);
  
  SERIAL_PORT.begin(115200);      // HW UART drivers
  Serial.begin(115200);

  driver.begin();                 // UART: Init SW UART (if selected) with default 115200 baudrate
  driver.toff(10);                // Enables driver in software
  driver.rms_current(1000);       // Set motor RMS current
  driver.microsteps(2);           // Set microsteps to 1/16th

  driver.en_spreadCycle(false);    // Toggle spreadCycle on TMC2208/2209/2224
  driver.pwm_autoscale(true);      // Needed for stealthChop

  Serial.println("OK");
  digitalWrite(EN_PIN, HIGH);
}

bool shaft = false;

void loop() {
//  Serial.println("TURN");
  if (Serial.available() > 0) {
    int z = Serial.read();
    if (z == 'a') {
      Serial.println("Stepping 10000");
      digitalWrite(EN_PIN, LOW);
      for (uint32_t i = 10000; i>0; i--) {
        digitalWrite(STEP_PIN, HIGH);
        delayMicroseconds(350);
        digitalWrite(STEP_PIN, LOW);
        delayMicroseconds(350);
      }
      digitalWrite(EN_PIN, HIGH);
    } else if (z == 'b') {
      shaft = !shaft;
      Serial.print("Shaft direction: ");
      Serial.println(shaft);
      driver.shaft(shaft);
    }
  }
}
```

Os resultados foram:

* Eixo Elevação
  * Redução aproximada: 1:3500
  * Resolução Angular: 0,000117 graus / passo
  * Velocidade Máxima: 0,62 graus / segundo
* Eixo Azimute
  * Redução aproximada: 1:392
  * Resolução Angular: 0,0046 graus / passo
  * Velocidade Máxima: 6,3 graus / segundo

Os resultados parecem bem promissores, e caso tudo dê certo, será suficiente para rastreamento de satélites!

O próximo passo será montar o software e o hardware para controlar via rede!

Os modelos 3D (tanto Freecad quanto STL) estão disponíveis no Thingverse (ver seção de links)

## Links

* [Motor para Azimute](https://s.click.aliexpress.com/e/_AOhCSe)
* [Motor para Elevação (Closed-Loop)](https://s.click.aliexpress.com/e/_ADtVZs)
* [Motor para Elevação (Normal)](https://s.click.aliexpress.com/e/_9zgziK)
* [Drivers TMC2209](https://s.click.aliexpress.com/e/_AoG3ZC)
* [Arquivos STL / Freecad](https://www.thingiverse.com/thing:4813288)

