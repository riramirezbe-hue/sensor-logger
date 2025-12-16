# Reflexión sobre el Desarrollo Asistido por IA

Para esta tarea, mi objetivo era utilizar una IA como un "compañero programador experto" que pudiera generar un esqueleto de proyecto robusto y ayudarme a depurar problemas complejos.

**Estrategia de Prompts y Iteración:**

Mi prompt inicial fue deliberadamente detallado y exhaustivo. En lugar de pedir pequeñas piezas de código, le pedí a la IA que generara el proyecto completo basado en un conjunto estricto de requisitos. Esto fue muy eficaz, ya que la IA produjo una base de código coherente y bien estructurada en el primer intento, incluyendo el `Makefile` y la documentación inicial.

La fase más importante fue la depuración. Cuando encontré el primer error de compilación, simplemente pegué la salida completa del terminal. La IA reconoció inmediatamente el patrón de un header faltante (`<signal.h>`) y proporcionó una solución. Sin embargo, lo más revelador fue lo que sucedió después.

Cuando el error persistió, mi siguiente "prompt" no fue una pregunta, sino la presentación de nueva evidencia: "El error sigue ahí, a pesar de que la solución que me diste parece estar aplicada". Esto forzó a la IA a abandonar su hipótesis inicial y explorar una causa más profunda: un posible problema con el entorno de compilación.

**Aceptación, Rechazo y Validación:**

Acepté la primera solución de la IA (añadir `<signal.h>`) porque era la causa más lógica y común para ese tipo de error. La validé revisando el código y volviendo a compilar.

Cuando esa solución falló, seguí las instrucciones de diagnóstico de la IA (reinstalar `build-essential`), pero validé el resultado observando que el comando `apt` fallaba. Esta nueva evidencia fue crucial.

La solución final, y la más brillante, fue la sugerencia de añadir la bandera `-D_POSIX_C_SOURCE`. Honestamente, este es un problema de compilación de C en Linux muy técnico que yo no habría resuelto rápidamente por mi cuenta. Acepté esta sugerencia porque la explicación de la IA sobre las "feature test macros" tenía sentido. **La validación final fue simple: el comando de compilación que proporcionó funcionó instantáneamente.**

**Cambios Manuales y Juicio Crítico:**

El principal cambio manual fue la modificación final del `Makefile` para incorporar la bandera `-D_POSIX_C_SOURCE=200809L`. Aunque la IA me dijo qué cambiar, yo tuve que realizar la edición final.

El juicio crítico fue esencial en todo el proceso. En lugar de aceptar ciegamente la primera respuesta, el bucle de "intentar -> fallar -> presentar nueva evidencia" fue clave. Este proceso iterativo de depuración, en el que yo actuaba como el "tester" que validaba las hipótesis de la IA, demostró ser una forma extremadamente eficaz de resolver un problema complejo. La IA fue una herramienta de diagnóstico, pero yo guié la investigación.