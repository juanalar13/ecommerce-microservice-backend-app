#!/bin/bash

# ============================================================================
# 🎯 INICIO RÁPIDO - E-COMMERCE MICROSERVICES EN CODESPACES
# ============================================================================
# Este script automatiza la demostración completa en 3 pasos
#
# USO:
#   bash QUICKSTART.sh
#
# Esto:
#   1. Levanta Docker Compose
#   2. Espera a que los servicios estén listos
#   3. Ejecuta la demostración completa
#   4. Muestra URLs de observabilidad
#
# ============================================================================

set -e

echo ""
echo "╔══════════════════════════════════════════════════════════════════════╗"
echo "║                                                                      ║"
echo "║     🚀 E-COMMERCE MICROSERVICES - QUICK START EN CODESPACES        ║"
echo "║                                                                      ║"
echo "╚══════════════════════════════════════════════════════════════════════╝"
echo ""

# ============================================================================
# Paso 1: Verificar Docker
# ============================================================================
echo "[1/4] Verificando Docker..."
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado"
    exit 1
fi
echo "✅ Docker disponible"

# ============================================================================
# Paso 2: Levantar Docker Compose
# ============================================================================
echo ""
echo "[2/4] Levantando servicios con Docker Compose..."
echo "    (esto descargará imágenes, puede tomar 1-2 minutos la primera vez)"
echo ""

docker-compose -f compose.yml up -d

echo ""
echo "✅ Contenedores iniciados"

# ============================================================================
# Paso 3: Esperar a que los servicios estén listos
# ============================================================================
echo ""
echo "[3/4] Esperando a que los servicios estén listos..."
echo "    (esperando respuesta del API Gateway...)"
echo ""

# Intentar conectar al API Gateway hasta 60 veces (máximo 2 minutos)
attempt=1
max_attempts=60
while [ $attempt -le $max_attempts ]; do
    if curl -s -f http://localhost:8080/health > /dev/null 2>&1; then
        echo "✅ API Gateway respondiendo"
        break
    fi
    echo -n "."
    sleep 2
    attempt=$((attempt + 1))
done

if [ $attempt -eq $max_attempts ]; then
    echo ""
    echo "❌ Timeout esperando al API Gateway"
    exit 1
fi

echo ""
echo "✅ Todos los servicios están listos"

# ============================================================================
# Paso 4: Mostrar información
# ============================================================================
echo ""
echo "[4/4] Sistema listo para demostración"
echo ""

# Listar contenedores
echo "📊 Estado de contenedores:"
echo ""
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "ecommerce|zipkin" || true

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 URLS DISPONIBLES:"
echo ""
echo "  • API Gateway:           http://localhost:8080"
echo "  • Service Discovery:     http://localhost:8761"
echo "  • Zipkin (Tracing):      http://localhost:9411"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📖 SIGUIENTE: Lee el README.md para saber qué demostrar"
echo "🎬 DEMO: bash demo-requests.sh"
echo "📋 COMANDOS: bash demo-requests.sh curl"
echo "🎥 GUION: cat SCRIPT.md"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Sistema completamente funcional. ¡A grabar! 🎬"
echo ""

# ============================================================================
# INFORMACIÓN DE PRUEBA RÁPIDA
# ============================================================================
echo "💡 PRUEBA RÁPIDA (copia y pega en otra terminal):"
echo ""
echo "   curl -s http://localhost:8080/product-service/api/products | jq ."
echo ""
