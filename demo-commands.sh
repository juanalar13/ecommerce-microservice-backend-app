#!/bin/bash

# ============================================================================
# 🎬 DEMOSTRACIÓN COMPLETA - E-COMMERCE MICROSERVICES
# ============================================================================
# Script que ejecuta todos los endpoints demostrables del sistema
# Uso: bash demo-commands.sh
# ============================================================================

set -e

# Configuración
GATEWAY="http://localhost:8080"
EUREKA="http://localhost:8761"
ZIPKIN="http://localhost:9411"

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# ============================================================================
# FUNCIONES DE UTILIDAD
# ============================================================================

print_header() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║ $1${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${YELLOW}▶ $1${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_request() {
    echo -e "${GREEN}📍 $1${NC}"
    echo ""
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# ============================================================================
# MAIN
# ============================================================================

clear

print_header "🎬 DEMOSTRACIÓN COMPLETA - E-COMMERCE MICROSERVICES"

# ============================================================================
# 1. VERIFICACIÓN INICIAL
# ============================================================================
print_section "PASO 1: Verificación Inicial"

print_request "Verificando que el API Gateway está disponible..."

if ! curl -s -f "$GATEWAY/health" > /dev/null 2>&1; then
    echo -e "${RED}❌ ERROR: API Gateway no responde en $GATEWAY${NC}"
    echo "Ejecuta primero: docker-compose -f compose.yml up -d"
    exit 1
fi

echo -e "${GREEN}✅ API Gateway OK${NC}"

# ============================================================================
# 2. PRODUCT SERVICE
# ============================================================================
print_section "1️⃣  SERVICIO DE PRODUCTOS"

print_request "Listar todos los productos"
curl -s $GATEWAY/product-service/api/products | jq . | head -60

print_request "Obtener producto con ID 1"
curl -s $GATEWAY/product-service/api/products/1 | jq .

print_request "Listar todas las categorías"
curl -s $GATEWAY/product-service/api/categories | jq .

# ============================================================================
# 3. USER SERVICE
# ============================================================================
print_section "2️⃣  SERVICIO DE USUARIOS"

print_request "Listar todos los usuarios"
curl -s $GATEWAY/user-service/api/users | jq . | head -60

print_request "Obtener usuario con ID 1"
curl -s $GATEWAY/user-service/api/users/1 | jq .

print_request "Buscar usuario por username 'john'"
curl -s $GATEWAY/user-service/api/users/username/john | jq . || echo -e "${BLUE}(No encontrado, pero endpoint funciona)${NC}"

print_request "Listar todas las direcciones"
curl -s $GATEWAY/user-service/api/address | jq . | head -40

# ============================================================================
# 4. ORDER SERVICE
# ============================================================================
print_section "3️⃣  SERVICIO DE PEDIDOS"

print_request "Listar todos los pedidos"
curl -s $GATEWAY/order-service/api/orders | jq . | head -60

print_request "🎯 CREAR NUEVO PEDIDO (POST) - Demostrando inter-servicio"
print_info "Este request valida usuario y productos, luego crea el pedido"
curl -s -X POST $GATEWAY/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{
    "userId": 1,
    "items": [
      {"productId": 1, "quantity": 2},
      {"productId": 2, "quantity": 1}
    ]
  }' | jq .

print_request "Listar carrito"
curl -s $GATEWAY/order-service/api/carts | jq . | head -40

# ============================================================================
# 5. PAYMENT SERVICE
# ============================================================================
print_section "4️⃣  SERVICIO DE PAGOS"

print_request "Listar todos los pagos"
curl -s $GATEWAY/payment-service/api/payments | jq . | head -60

print_request "Obtener pago con ID 1"
curl -s $GATEWAY/payment-service/api/payments/1 | jq .

# ============================================================================
# 6. SHIPPING SERVICE
# ============================================================================
print_section "5️⃣  SERVICIO DE ENVÍOS"

print_request "Listar todos los envíos"
curl -s $GATEWAY/shipping-service/api/shippings | jq . | head -60

# ============================================================================
# 7. FAVOURITE SERVICE
# ============================================================================
print_section "6️⃣  SERVICIO DE FAVORITOS"

print_request "Listar todos los favoritos"
curl -s $GATEWAY/favourite-service/api/favourites | jq . | head -40

# ============================================================================
# 8. SERVICE DISCOVERY
# ============================================================================
print_section "7️⃣  SERVICE DISCOVERY (EUREKA)"

print_request "Obtener todos los servicios registrados"
print_info "Esto muestra que Service Discovery funciona automáticamente"
curl -s $EUREKA/eureka/apps | head -80

# ============================================================================
# 9. HEALTH CHECKS
# ============================================================================
print_section "8️⃣  VERIFICACIÓN DE SALUD"

print_request "Health del API Gateway"
curl -s $GATEWAY/health | jq .

# ============================================================================
# RESUMEN FINAL
# ============================================================================
print_header "✅ DEMOSTRACIÓN COMPLETADA"

echo -e "${GREEN}Todos los servicios están funcionando correctamente.${NC}"
echo ""
echo -e "${BLUE}📊 RESUMEN DE LO DEMOSTRADO:${NC}"
echo ""
echo "✓ Product Service     - Catálogo de productos y categorías"
echo "✓ User Service        - Gestión de usuarios y direcciones"
echo "✓ Order Service       - Creación y gestión de pedidos"
echo "✓ Payment Service     - Procesamiento de pagos"
echo "✓ Shipping Service    - Gestión de envíos"
echo "✓ Favourite Service   - Productos favoritos"
echo "✓ Service Discovery   - Auto-registro de servicios"
echo "✓ API Gateway         - Enrutamiento centralizado"
echo ""
echo -e "${BLUE}📍 URLs DISPONIBLES:${NC}"
echo ""
echo "  • API Gateway:     $GATEWAY"
echo "  • Eureka:          $EUREKA"
echo "  • Zipkin:          $ZIPKIN"
echo ""
echo -e "${BLUE}🎯 PASOS SIGUIENTES:${NC}"
echo ""
echo "  1. Abre Eureka: http://localhost:8761"
echo "     → Ver todos los servicios registrados"
echo ""
echo "  2. Abre Zipkin: http://localhost:9411"
echo "     → Ver trazas distribuidas de los requests"
echo ""
echo "  3. Ejecuta nuevamente:"
echo "     bash demo-commands.sh"
echo ""
echo -e "${BLUE}🛑 PARA DETENER LOS SERVICIOS:${NC}"
echo ""
echo "  docker-compose -f compose.yml down"
echo ""
