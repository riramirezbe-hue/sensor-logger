#!/bin/bash

# Este es nuestro "panel de control" para el servicio sensor-logger

# Bucle infinito para que el menú se muestre una y otra vez
while true; do
    # Limpia la pantalla para que el menú siempre aparezca en el mismo lugar
    clear
    
    echo "=========================================="
    echo "   Panel de Control - Servicio Sensor   "
    echo "=========================================="
    # Verificamos el estado actual del servicio para mostrarlo en el menú
    # 'systemctl is-active' devuelve 'active' o 'inactive'
    STATUS=$(systemctl is-active sensor-logger.service)
    echo "ESTADO ACTUAL: $STATUS"
    echo "------------------------------------------"
    
    # Opciones del menú
    echo "1. Iniciar y Habilitar el Servicio"
    echo "2. Ver el Log en Tiempo Real (Presiona Ctrl+C para volver)"
    echo "3. Detener el Servicio"
    echo "4. Ver Estado Detallado del Servicio"
    echo "5. Salir"
    echo "------------------------------------------"

    # Pedimos al usuario que elija una opción
    read -p "Elige una opción [1-5]: " choice

    # Usamos un 'case' para ejecutar la acción correspondiente
    case $choice in
        1)
            echo "✅ Iniciando y habilitando el servicio..."
            sudo systemctl enable --now sensor-logger.service
            echo "¡Servicio iniciado!"
            sleep 2 # Pausa de 2 segundos para que el usuario pueda leer
            ;;
        2)
            echo "📄 Mostrando el log en tiempo real... (Presiona Ctrl+C para volver al menú)"
            sleep 1
            # -f sigue el archivo. Cuando presiones Ctrl+C, el comando terminará y el bucle continuará.
            tail -f /tmp/sensor-logger.log
            echo "Volviendo al menú..."
            sleep 1
            ;;
        3)
            echo "🛑 Deteniendo el servicio..."
            sudo systemctl stop sensor-logger.service
            echo "¡Servicio detenido!"
            sleep 2
            ;;
        4)
            echo "🔎 Obteniendo estado detallado..."
            systemctl status sensor-logger.service
            read -p "Presiona Enter para continuar..." # Pausa para que puedas leer el estado
            ;;
        5)
            echo "👋 ¡Adiós!"
            exit 0
            ;;
        *)
            # Cualquier otra opción no es válida
            echo "❌ Opción no válida. Inténtalo de nuevo."
            sleep 2
            ;;
    esac
done