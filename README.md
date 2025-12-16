# 💾 Registrador de Sensores con Servicio Systemd

Este proyecto implementa un **servicio de `systemd` desarrollado en C** diseñado para la adquisición y registro periódico de datos de sensores en entornos Linux. Su función principal es leer continuamente datos de un sensor simulado y almacenarlos en un archivo de registro (`log`) junto con su marca de tiempo correspondiente.

El diseño se centró en la **robustez, la facilidad de configuración y la sencillez en la gestión** dentro de cualquier sistema Linux.

---

### ⚙️ Sobre el Sensor Simulado (Mock)

Por defecto, el proyecto utiliza el dispositivo **`/dev/urandom`** como fuente de datos simulada. Elegimos esta opción por su **disponibilidad universal** en sistemas Linux y su capacidad para generar un flujo constante de datos aleatorios sin causar bloqueos, asegurando pruebas consistentes y realistas para el servicio.

### 📝 Requisitos del Sistema

Para clonar, compilar e instalar exitosamente esta solución, necesitarás las siguientes herramientas en tu entorno Linux:

* `git`
* `gcc` y `make` (generalmente incluidos en el paquete `build-essential` en sistemas basados en Debian/Ubuntu)

Puedes instalar los requisitos en sistemas tipo Debian con el siguiente comando:

```bash
sudo apt-get update
sudo apt-get install -y build-essential git
