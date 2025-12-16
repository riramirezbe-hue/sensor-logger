# Log de Interacción con IA para el Proyecto `sensor-logger`

Este documento registra los prompts enviados a la IA (Google Gemini) y las respuestas condensadas recibidas durante el desarrollo del servicio `sensor-logger`.

---

### 1. Prompt Inicial: Generación del Proyecto Completo

**Prompt:**
> Actúa como un desarrollador experto en sistemas embebidos de Linux. Tu tarea es generar un proyecto completo en lenguaje C que funcione como un servicio de systemd. El proyecto se llamará `sensor-logger`. A continuación, se detallan todos los requisitos que debes implementar (manejo de señales, argumentos CLI, `Makefile` completo, unidad de `systemd`, `README.md`).

**Respuesta de la IA (Condensada):**
La IA generó el contenido completo para los cuatro archivos solicitados: `Makefile`, `src/main.c`, `systemd/sensor-logger.service` y `README.md`. La estructura y el contenido inicial parecían cumplir con todos los requisitos de la tarea.

---

### 2. Interacción de Depuración 1: Error de Compilación Inicial

**Mi Entrada (Error de `make`):**
> `teddy@LAPTOP-F9HV3UMH:~/sensor-logger$ make`
> `gcc -Wall -Wextra -g -std=c11 -o sensor-logger src/main.c`
> `src/main.c: In function ‘main’: src/main.c:70:22: error: storage size of ‘action’ isn’t known`
> `... make: *** [Makefile:19: sensor-logger] Error 1`

**Respuesta de la IA:**
La IA identificó correctamente que el error se debía a la falta de una librería.
> **IA:** "La causa del problema es que olvidé incluir la librería `#include <signal.h>` en el archivo `src/main.c`."
>
> Proporcionó el código corregido para `src/main.c`.

---

### 3. Interacción de Depuración 2: Persistencia del Error

**Mi Entrada:**
> El error de compilación persiste incluso después de añadir `#include <signal.h>`. He verificado que la línea está en el archivo.

**Respuesta de la IA:**
La IA cambió de hipótesis. Sugirió que el problema podría no ser el código, sino el entorno de compilación de WSL.
> **IA:** "Esto significa que el problema está en tu entorno de compilación de WSL. El compilador `gcc` no está encontrando el archivo `<signal.h>` en tu sistema."
>
> Propuso un plan de diagnóstico:
> 1.  Verificar si `/usr/include/signal.h` existe.
> 2.  Reinstalar `build-essential` y `libc6-dev`.

---

### 4. Interacción de Depuración 3: Falla de `apt` y Diagnóstico Final

**Mi Entrada (Error de `apt` y persistencia del error de `make`):**
> Al intentar reinstalar los paquetes, obtengo un error de "lock file" de `apt`. El error de compilación sigue siendo el mismo.

**Mi Entrada (Resultados de los comandos de diagnóstico):**
> Pegué la salida de `grep sigaction ...`, `apt-cache policy ...`, y `gcc -v ...`.

**Respuesta de la IA:**
Con la información de diagnóstico, la IA llegó a la causa raíz del problema.
> **IA:** "El problema es mucho más sutil. Las librerías del sistema 'ocultan' funciones avanzadas como `sigaction` a menos que el programa se lo pida explícitamente. Necesitamos añadir la bandera de compilación `-D_POSIX_C_SOURCE=200809L`."
>
> Proporcionó el comando de compilación directo para probar la solución y las instrucciones para modificar permanentemente el `Makefile`.

**Resultado:** Esta fue la solución final y correcta. El programa compiló exitosamente.

---