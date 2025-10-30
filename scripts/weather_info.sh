#!/bin/bash
## Script simple para Eww: Obtiene datos y devuelve JSON.

# --- Configuración ---
API_KEY="f185a144d581e8f34f30c1c9cda3cb73"
CITY_ID="3856436" # Usamos ID para evitar problemas de nombres de ciudades
UNITS="metric"
LANG="es"
URL="http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=${UNITS}&lang=${LANG}"

# === OBTENER DATOS ===
DATA=$(curl -s "$URL")

# Verificar si cURL devolvió datos o hay error
if [ -z "$DATA" ] || echo "$DATA" | grep -q '"cod":[^2]'; then
    # Datos por defecto en caso de error
    echo '{"icon":"","temp":"?°C","hex":"#adadff","stat":"Error de red","quote":"No se pudieron cargar los datos del clima."}'
    exit 1
fi

# === PARSEAR JSON (con jq) ===
if ! command -v jq &> /dev/null; then
    echo '{"icon":"Error","temp":"?","hex":"#adadff","stat":"jq no instalado","quote":"Instala jq."}'
    exit 1
fi

TEMP=$(echo "$DATA" | jq -r '.main.temp // 0 | round')
DESC=$(echo "$DATA" | jq -r '.weather[0].description // "Desconocido"' | sed 's/.*/\u&/')
ICON_CODE=$(echo "$DATA" | jq -r '.weather[0].icon // "01d"')

# === ASIGNAR ICONO, CITA Y COLOR (HEX) ===
# Combinamos los iconos y lógica de color de tu script anterior
case $ICON_CODE in
    01d) ICON=""; HEX="#ffd86b"; QUOTE="Día soleado. ¡Disfruta!" ;;
    01n) ICON=""; HEX="#fcdcf6"; QUOTE="Noche despejada. Estrellas." ;;
    02d) ICON=""; HEX="#adadff"; QUOTE="Pocas nubes. Ideal." ;;
    02n) ICON=""; HEX="#adadff"; QUOTE="Noche nublada. A descansar." ;;
    03d|03n|04d|04n) ICON=""; HEX="#adadff"; QUOTE="Cielo mayormente cubierto." ;;
    009d|09n|10d|10n) ICON=""; HEX="#6b95ff"; QUOTE="Lluvia. Saca el paraguas." ;;
    11d|11n) ICON=""; HEX="#ffeb57"; QUOTE="Tormenta eléctrica. ¡Cuidado!" ;;
    13d|13n) ICON=""; HEX="#e3e6fc"; QUOTE="Nieve. Abrígate bien." ;;
    50d|50n) ICON=""; HEX="#84afdb"; QUOTE="Neblina. Conduce con precaución." ;;
    *) ICON=""; HEX="#adadff"; QUOTE="Clima desconocido." ;;
esac

# === SALIDA PARA EWW (JSON) ===
# Eww leerá directamente este JSON.
echo "{
  \"icon\": \"$ICON\",
  \"temp\": \"$TEMP°C\",
  \"hex\": \"$HEX\",
  \"stat\": \"$DESC\",
  \"quote\": \"$QUOTE\"
}"

