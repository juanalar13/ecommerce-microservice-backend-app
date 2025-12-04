#!/bin/bash

# ============================================================================
# 🚀 DEMO REQUESTS - E-COMMERCE MICROSERVICES
# ============================================================================
# Script con todos los curl listos para copiar/pegar y demostrar funcionalidades
# Ejecutar desde la raíz del repositorio después de: docker-compose -f compose.yml up -d
#
# USO:
#   bash demo-requests.sh          # Ejecutar todo automáticamente
#   bash demo-requests.sh info     # Solo mostrar URLs e información
#   bash demo-requests.sh curl     # Solo mostrar comandos curl
#
# ============================================================================

set -e

GATEWAY="http://localhost:8080"
EUREKA="http://localhost:8761"
ZIPKIN="http://localhost:9411"

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================================================
# FUNCIÓN: Print banner
# ============================================================================
print_banner() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# ============================================================================
# FUNCIÓN: Print section
# ============================================================================
print_section() {
    echo ""
    echo -e "${YELLOW}▶ $1${NC}"
}

# ============================================================================
# FUNCIÓN: Ejecutar curl con formato pretty
# ============================================================================
execute_curl() {
    local endpoint=$1
    local method=$2
    local data=$3
    local description=$4
    
    print_section "$description"
    echo -e "${BLUE}Endpoint: ${GREEN}$endpoint${NC}"
    
    if [ "$method" == "POST" ]; then
        echo -e "${BLUE}Payload:${NC} $data"
        echo ""
        curl -s -X POST "$endpoint" \
            -H 'Content-Type: application/json' \
            -d "$data" | jq . || echo "Request failed or returned no JSON"
    else
        echo ""
        curl -s "$endpoint" | jq . || echo "Request failed or returned no JSON"
    fi
    
    echo ""
}

# ============================================================================
# FUNCIÓN: Mostrar solo URLs
# ============================================================================
show_urls_only() {
    print_banner "📍 URLS DISPONIBLES"
    echo ""
    echo -e "${GREEN}API Gateway:${NC}        $GATEWAY"
    echo -e "${GREEN}Eureka (Service Discovery):${NC}  $EUREKA"
    echo -e "${GREEN}Zipkin (Distributed Tracing):${NC}  $ZIPKIN"
    echo ""
    echo -e "${YELLOW}Endpoints disponibles a través del Gateway:${NC}"
    echo "  • Productos: $GATEWAY/product-service/api/products"
    echo "  • Usuarios: $GATEWAY/user-service/api/users"
    echo "  • Pedidos: $GATEWAY/order-service/api/orders"
    echo "  • Pagos: $GATEWAY/payment-service/api/payments"
    echo "  • Envíos: $GATEWAY/shipping-service/api/shippings"
    echo "  • Favoritos: $GATEWAY/favourite-service/api/favourites"
    echo ""
}

# ============================================================================
# FUNCIÓN: Mostrar solo comandos curl
# ============================================================================
show_curl_commands() {
    print_banner "📋 COMANDOS CURL DISPONIBLES"
    echo ""
    
    echo "# 1. LISTAR PRODUCTOS"
    echo "curl -s $GATEWAY/product-service/api/products | jq ."
    echo ""
    
    echo "# 2. OBTENER PRODUCTO POR ID"
    echo "curl -s $GATEWAY/product-service/api/products/1 | jq ."
    echo ""
    
    echo "# 3. LISTAR CATEGORÍAS"
    echo "curl -s $GATEWAY/product-service/api/categories | jq ."
    echo ""
    
    echo "# 4. LISTAR USUARIOS"
    echo "curl -s $GATEWAY/user-service/api/users | jq ."
    echo ""
    
    echo "# 5. OBTENER USUARIO POR ID"
    echo "curl -s $GATEWAY/user-service/api/users/1 | jq ."
    echo ""
    
    echo "# 6. BUSCAR USUARIO POR USERNAME"
    echo "curl -s $GATEWAY/user-service/api/users/username/john | jq ."
    echo ""
    
    echo "# 7. LISTAR PEDIDOS"
    echo "curl -s $GATEWAY/order-service/api/orders | jq ."
    echo ""
    
    echo "# 8. CREAR NUEVO PEDIDO (POST)"
    echo "curl -s -X POST $GATEWAY/order-service/api/orders \\"
    echo "  -H 'Content-Type: application/json' \\"
    echo "  -d '{\"userId\":1,\"items\":[{\"productId\":1,\"quantity\":2}]}' | jq ."
    echo ""
    
    echo "# 9. LISTAR CARRITOS"
    echo "curl -s $GATEWAY/order-service/api/carts | jq ."
    echo ""
    
    echo "# 10. LISTAR PAGOS"
    echo "curl -s $GATEWAY/payment-service/api/payments | jq ."
    echo ""
    
    echo "# 11. LISTAR ENVÍOS"
    echo "curl -s $GATEWAY/shipping-service/api/shippings | jq ."
    echo ""
    
    echo "# 12. LISTAR FAVORITOS"
    echo "curl -s $GATEWAY/favourite-service/api/favourites | jq ."
    echo ""
}

# ============================================================================
# FUNCIÓN: Ejecutar todas las demostraciones
# ============================================================================
run_full_demo() {
    print_banner "🎬 DEMOSTRACIÓN COMPLETA - E-COMMERCE MICROSERVICES"
    
    # Verificar que los servicios están arriba
    echo ""
    print_section "Verificando que los servicios estén disponibles..."
    
    if ! curl -s -f http://localhost:8080/health > /dev/null 2>&1; then
        echo -e "${RED}❌ El API Gateway no está disponible.${NC}"
        echo "Asegúrate de que Docker Compose está corriendo:"
        echo "  docker-compose -f compose.yml up -d"
        exit 1
    fi
    echo -e "${GREEN}✅ API Gateway disponible${NC}"
    
    echo ""
    echo "Aguardando a que todos los servicios estén listos..."
    sleep 5
    
    # ========================================================================
    # SECCIÓN 1: PRODUCTOS
    # ========================================================================
    print_banner "🛍️ SERVICIO DE PRODUCTOS"
    
    execute_curl \
        "$GATEWAY/product-service/api/products" \
        "GET" \
        "" \
        "1.1 Listar todos los productos"
    
    execute_curl \
        "$GATEWAY/product-service/api/products/1" \
        "GET" \
        "" \
        "1.2 Obtener un producto específico (ID=1)"
    
    execute_curl \
        "$GATEWAY/product-service/api/categories" \
        "GET" \
        "" \
        "1.3 Listar todas las categorías"
    
    # ========================================================================
    # SECCIÓN 2: USUARIOS
    # ========================================================================
    print_banner "👥 SERVICIO DE USUARIOS"
    
    execute_curl \
        "$GATEWAY/user-service/api/users" \
        "GET" \
        "" \
        "2.1 Listar todos los usuarios"
    
    execute_curl \
        "$GATEWAY/user-service/api/users/1" \
        "GET" \
        "" \
        "2.2 Obtener un usuario específico (ID=1)"
    
    execute_curl \
        "$GATEWAY/user-service/api/users/username/john" \
        "GET" \
        "" \
        "2.3 Buscar usuario por username (john)"
    
    # ========================================================================
    # SECCIÓN 3: PEDIDOS
    # ========================================================================
    print_banner "📦 SERVICIO DE PEDIDOS"
    
    execute_curl \
        "$GATEWAY/order-service/api/orders" \
        "GET" \
        "" \
        "3.1 Listar todos los pedidos existentes"
    
    execute_curl \
        "$GATEWAY/order-service/api/orders" \
        "POST" \
        '{"userId":1,"items":[{"productId":1,"quantity":2}]}' \
        "3.2 CREAR UN NUEVO PEDIDO (POST) - Usuario 1 compra 2x Producto 1"
    
    sleep 2
    
    execute_curl \
        "$GATEWAY/order-service/api/orders" \
        "GET" \
        "" \
        "3.3 Listar pedidos nuevamente (verás el que acabamos de crear)"
    
    execute_curl \
        "$GATEWAY/order-service/api/carts" \
        "GET" \
        "" \
        "3.4 Listar carritos de compra"
    
    # ========================================================================
    # SECCIÓN 4: PAGOS
    # ========================================================================
    print_banner "💳 SERVICIO DE PAGOS"
    
    execute_curl \
        "$GATEWAY/payment-service/api/payments" \
        "GET" \
        "" \
        "4.1 Listar todos los pagos registrados"
    
    # ========================================================================
    # SECCIÓN 5: ENVÍOS
    # ========================================================================
    print_banner "🚚 SERVICIO DE ENVÍOS"
    
    execute_curl \
        "$GATEWAY/shipping-service/api/shippings" \
        "GET" \
        "" \
        "5.1 Listar envíos registrados"
    
    # ========================================================================
    # SECCIÓN 6: FAVORITOS
    # ========================================================================
    print_banner "❤️ SERVICIO DE FAVORITOS"
    
    execute_curl \
        "$GATEWAY/favourite-service/api/favourites" \
        "GET" \
        "" \
        "6.1 Listar productos marcados como favoritos"
    
    # ========================================================================
    # INFORMACIÓN FINAL
    # ========================================================================
    print_banner "📊 INFORMACIÓN ADICIONAL"
    
    echo ""
    echo -e "${YELLOW}URLs de Observabilidad:${NC}"
    echo -e "  • Eureka (Service Discovery): ${GREEN}$EUREKA${NC}"
    echo -e "  • Zipkin (Distributed Tracing): ${GREEN}$ZIPKIN${NC}"
    echo ""
    echo -e "${YELLOW}Para obtener más información:${NC}"
    echo "  • Lee README.md para instrucciones detalladas"
    echo "  • Lee SCRIPT.md para el guion de presentación"
    echo "  • Ejecuta 'bash demo-requests.sh curl' para ver todos los comandos curl"
    echo ""
    echo -e "${GREEN}✅ DEMOSTRACIÓN COMPLETADA${NC}"
    echo ""
}

# ============================================================================
# MAIN
# ============================================================================

case "${1:-demo}" in
    info)
        show_urls_only
        ;;
    curl)
        show_curl_commands
        ;;
    demo)
        run_full_demo
        ;;
    *)
        echo "Uso: bash demo-requests.sh [opciones]"
        echo ""
        echo "Opciones:"
        echo "  demo   - Ejecutar demostración completa con curl (default)"
        echo "  curl   - Mostrar solo comandos curl listos para copiar/pegar"
        echo "  info   - Mostrar solo URLs e información"
        echo ""
        exit 1
        ;;
esac
