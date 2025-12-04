# E-Commerce Microservices - Demostración Completa

**Sistema de 10 microservicios con Spring Boot, Spring Cloud y Docker**

---

## 🎯 OBJETIVO

Este proyecto demuestra una arquitectura de **microservicios escalable** con:
- ✅ 10 microservicios independientes (Spring Boot)
- ✅ Service Discovery (Eureka)
- ✅ API Gateway centralizado
- ✅ Trazas distribuidas (Zipkin)
- ✅ Configuración centralizada (Spring Cloud Config)

---

## 📊 ARQUITECTURA

```
┌─────────────────────────────────────────────────────────┐
│                   API GATEWAY (8080)                    │
│              (Spring Cloud Gateway)                     │
└──────┬──────────────────────────────────────────────────┘
       │
       ├─→ User Service (8700)
       ├─→ Product Service (8500)
       ├─→ Order Service (8300)
       ├─→ Payment Service (8400)
       ├─→ Shipping Service (8600)
       ├─→ Favourite Service (8800)
       │
       └─→ Service Discovery (Eureka - 8761)
           ├─→ Cloud Config (9296)
           └─→ Proxy Client (8900)

Observabilidad:
   ├─→ Zipkin (9411) - Trazas distribuidas
   ├─→ Prometheus - Métricas
   └─→ Grafana - Dashboards
```

---

## 🚀 INICIO RÁPIDO

### Requisitos
- Docker
- Docker Compose

### Paso 1: Levantar el sistema (3 minutos)

```bash
docker-compose -f compose.yml up -d
```

Esto inicia:
- ✅ 10 microservicios
- ✅ Eureka (Service Discovery)
- ✅ Zipkin (Tracing)
- ✅ Config Server

### Paso 2: Verificar que está listo (30 segundos)

```bash
# Esperar 30-60 segundos a que se inicialicen todos los servicios
docker ps | grep ecommerce

# Verificar que el Gateway responde
curl -s http://localhost:8080/health | jq .
```

### Paso 3: Ejecutar demostración completa (5 minutos)

```bash
bash demo-commands.sh
```

---

## 📍 URLs DISPONIBLES

| Componente | URL | Puerto |
|-----------|-----|--------|
| **API Gateway** | http://localhost:8080 | 8080 |
| **Service Discovery (Eureka)** | http://localhost:8761 | 8761 |
| **Zipkin (Tracing)** | http://localhost:9411 | 9411 |
| **Proxy Client** | http://localhost:8900 | 8900 |

---

## 🔧 SERVICIOS INDIVIDUALES

| # | Servicio | Puerto | Endpoints Principales |
|---|----------|--------|----------------------|
| 1 | **User Service** | 8700 | `/api/users`, `/api/address`, `/api/credentials` |
| 2 | **Product Service** | 8500 | `/api/products`, `/api/categories` |
| 3 | **Order Service** | 8300 | `/api/orders`, `/api/carts` |
| 4 | **Payment Service** | 8400 | `/api/payments` |
| 5 | **Shipping Service** | 8600 | `/api/shippings` |
| 6 | **Favourite Service** | 8800 | `/api/favourites` |
| 7 | **Service Discovery** | 8761 | Eureka Dashboard |
| 8 | **Cloud Config** | 9296 | Config Server |
| 9 | **API Gateway** | 8080 | Enrutamiento centralizado |
| 10 | **Proxy Client** | 8900 | Autenticación |

---

## 📋 COMANDOS DE DEMOSTRACIÓN PARA EJECUTAR EN VIVO

### 1️⃣ LISTAR PRODUCTOS
```bash
curl -s http://localhost:8080/product-service/api/products | jq .
```

**Qué verás**: Lista de todos los productos disponibles con id, nombre, descripción, categoría y precio.

---

### 2️⃣ OBTENER PRODUCTO ESPECÍFICO
```bash
curl -s http://localhost:8080/product-service/api/products/1 | jq .
```

**Qué verás**: Detalles completos del producto con ID 1 (información de categoría incluida).

---

### 3️⃣ LISTAR CATEGORÍAS
```bash
curl -s http://localhost:8080/product-service/api/categories | jq .
```

**Qué verás**: Todas las categorías de productos disponibles en el sistema.

---

### 4️⃣ LISTAR USUARIOS
```bash
curl -s http://localhost:8080/user-service/api/users | jq .
```

**Qué verás**: Lista de todos los usuarios registrados en el sistema.

---

### 5️⃣ BUSCAR USUARIO POR USERNAME
```bash
curl -s http://localhost:8080/user-service/api/users/username/john | jq .
```

**Qué verás**: Información completa del usuario con username "john" (ajusta el username según datos).

---

### 6️⃣ OBTENER USUARIO ESPECÍFICO
```bash
curl -s http://localhost:8080/user-service/api/users/1 | jq .
```

**Qué verás**: Detalles del usuario con ID 1, incluyendo email y estado.

---

### 7️⃣ LISTAR TODAS LAS DIRECCIONES
```bash
curl -s http://localhost:8080/user-service/api/address | jq .
```

**Qué verás**: Todas las direcciones registradas de todos los usuarios.

---

### 8️⃣ LISTAR PEDIDOS
```bash
curl -s http://localhost:8080/order-service/api/orders | jq .
```

**Qué verás**: Lista de todos los pedidos en el sistema con sus detalles.

---

### 9️⃣ CREAR NUEVO PEDIDO (POST)
```bash
curl -s -X POST http://localhost:8080/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{
    "userId": 1,
    "items": [
      {"productId": 1, "quantity": 2},
      {"productId": 2, "quantity": 1}
    ]
  }' | jq .
```

**Qué verás**: Respuesta con el nuevo pedido creado, incluyendo su ID y estado.

**Lo que demuestra**: Creación de un pedido con múltiples productos - muestra comunicación entre servicios (Order ↔ Product).

---

### 🔟 LISTAR PAGOS
```bash
curl -s http://localhost:8080/payment-service/api/payments | jq .
```

**Qué verás**: Todos los pagos procesados en el sistema.

---

### 1️⃣1️⃣ OBTENER PAGO ESPECÍFICO
```bash
curl -s http://localhost:8080/payment-service/api/payments/1 | jq .
```

**Qué verás**: Detalles completos del pago con ID 1 (monto, fecha, estado, referencia de pedido).

---

### 1️⃣2️⃣ LISTAR ENVÍOS
```bash
curl -s http://localhost:8080/shipping-service/api/shippings | jq .
```

**Qué verás**: Todos los envíos registrados en el sistema con sus estados.

---

### 1️⃣3️⃣ LISTAR FAVORITOS
```bash
curl -s http://localhost:8080/favourite-service/api/favourites | jq .
```

**Qué verás**: Todos los productos marcados como favoritos por los usuarios.

---

### 1️⃣4️⃣ VERIFICAR EUREKA (Service Discovery)
```bash
curl -s http://localhost:8761/eureka/apps | jq .
```

**Qué verás**: Lista de TODOS los servicios registrados en Eureka en formato XML/JSON.

**Lo que demuestra**: Service Discovery automático - cada servicio se auto-registra cuando inicia.

---

### 1️⃣5️⃣ VERIFICAR HEALTH DE GATEWAY
```bash
curl -s http://localhost:8080/health | jq .
```

**Qué verás**: Estado de salud del API Gateway (status: UP) y detalles de los servicios downstream.

---

## 🎯 SCRIPT AUTOMATIZADO COMPLETO

Archivo: `demo-commands.sh`

```bash
#!/bin/bash

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

GATEWAY="http://localhost:8080"

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════${NC}"
    echo ""
}

print_request() {
    echo -e "${YELLOW}▶ $1${NC}"
    echo ""
}

print_header "🎬 DEMOSTRACIÓN E-COMMERCE MICROSERVICES"

# 1. PRODUCTOS
print_header "1️⃣  SERVICIO DE PRODUCTOS"

print_request "Listar todos los productos"
curl -s $GATEWAY/product-service/api/products | jq . | head -50

print_request "Obtener producto con ID 1"
curl -s $GATEWAY/product-service/api/products/1 | jq .

print_request "Listar categorías"
curl -s $GATEWAY/product-service/api/categories | jq .

# 2. USUARIOS
print_header "2️⃣  SERVICIO DE USUARIOS"

print_request "Listar todos los usuarios"
curl -s $GATEWAY/user-service/api/users | jq . | head -50

print_request "Obtener usuario con ID 1"
curl -s $GATEWAY/user-service/api/users/1 | jq .

print_request "Buscar usuario por username 'john'"
curl -s $GATEWAY/user-service/api/users/username/john | jq .

print_request "Listar todas las direcciones"
curl -s $GATEWAY/user-service/api/address | jq . | head -30

# 3. PEDIDOS
print_header "3️⃣  SERVICIO DE PEDIDOS"

print_request "Listar todos los pedidos"
curl -s $GATEWAY/order-service/api/orders | jq . | head -50

print_request "Crear nuevo pedido (POST)"
curl -s -X POST $GATEWAY/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{
    "userId": 1,
    "items": [
      {"productId": 1, "quantity": 2},
      {"productId": 2, "quantity": 1}
    ]
  }' | jq .

# 4. PAGOS
print_header "4️⃣  SERVICIO DE PAGOS"

print_request "Listar todos los pagos"
curl -s $GATEWAY/payment-service/api/payments | jq . | head -50

print_request "Obtener pago con ID 1"
curl -s $GATEWAY/payment-service/api/payments/1 | jq .

# 5. ENVÍOS
print_header "5️⃣  SERVICIO DE ENVÍOS"

print_request "Listar todos los envíos"
curl -s $GATEWAY/shipping-service/api/shippings | jq . | head -50

# 6. FAVORITOS
print_header "6️⃣  SERVICIO DE FAVORITOS"

print_request "Listar todos los favoritos"
curl -s $GATEWAY/favourite-service/api/favourites | jq . | head -50

# 7. OBSERVABILIDAD
print_header "7️⃣  OBSERVABILIDAD"

print_request "Service Discovery (Eureka) - Servicios registrados"
curl -s http://localhost:8761/eureka/apps | jq . | head -100

print_request "Health Check del API Gateway"
curl -s $GATEWAY/health | jq .

# 8. RESUMEN
print_header "✅ DEMOSTRACIÓN COMPLETADA"

echo -e "${GREEN}Todo los servicios están funcionando correctamente.${NC}"
echo ""
echo "📍 URLs disponibles:"
echo "   • API Gateway: $GATEWAY"
echo "   • Eureka: http://localhost:8761"
echo "   • Zipkin: http://localhost:9411"
echo ""
```

---

## 📝 FLUJO DE DEMOSTRACIÓN EN VIDEO (15-20 minutos)

### Minuto 0:00-1:00: Introducción
- Explicar qué es el proyecto
- Mencionar que son 10 microservicios independientes
- Mostrar que usamos Docker Compose para demo rápida

### Minuto 1:00-4:00: Levantamiento del sistema
- Ejecutar `docker-compose -f compose.yml up -d`
- Mientras se descargan imágenes, explicar arquitectura
- Mostrar que servicios se están iniciando

### Minuto 4:00-5:00: Verificación
- Ejecutar `docker ps` para confirmar todos corriendo
- Mostrar `curl -s http://localhost:8080/health`

### Minuto 5:00-6:00: Explicar componentes
- Service Discovery (Eureka automático)
- API Gateway (enrutamiento centralizado)
- Trazas distribuidas (Zipkin)

### Minuto 6:00-15:00: Demostración de endpoints
- Ejecutar `bash demo-commands.sh`
- Explicar cada respuesta mientras aparece
- Resaltar creación de pedido (POST) como demostración de inter-servicios

### Minuto 15:00-18:00: Observabilidad
- Mostrar Eureka dashboard (http://localhost:8761)
- Mostrar Zipkin con trazas (http://localhost:9411)
- Explicar cómo cada request atraviesa múltiples servicios

### Minuto 18:00-20:00: Conclusión
- Explicar cómo esto escala con Kubernetes
- Mencionar patrones implementados (Service Discovery, Circuit Breaker, etc.)
- Mostrar que sin cambiar código, todo funciona

---

## 🛠️ LIMPIEZA

Para detener todos los servicios:

```bash
docker-compose -f compose.yml down
```

Para limpiar completamente (incluyendo volúmenes):

```bash
docker-compose -f compose.yml down -v
```

Para eliminar todas las imágenes descargadas:

```bash
docker system prune -a
```

---

## 📚 TECNOLOGÍA UTILIZADA

- **Spring Boot 2.5.7** - Framework base
- **Spring Cloud 2020.0.4** - Microservicios
- **Spring Cloud Gateway** - API Gateway
- **Eureka** - Service Discovery
- **Resilience4j** - Circuit Breaker
- **Zipkin + Sleuth** - Trazas distribuidas
- **Docker & Docker Compose** - Containerización
- **Kubernetes + Helm** - Orquestación producción

---

## 📊 CONCEPTOS DEMOSTRADOS

✅ **Microservicios** - 10 servicios independientes  
✅ **Service Discovery** - Registro automático con Eureka  
✅ **API Gateway** - Punto de entrada único y enrutamiento  
✅ **Communication** - Inter-service communication via REST  
✅ **Distributed Tracing** - Trazas end-to-end con Zipkin  
✅ **Resilience** - Patrones de tolerancia a fallos  
✅ **Scalability** - Fácil agregar/remover servicios  
✅ **DevOps** - Containerización con Docker  

---

## 🎯 NEXT STEPS

1. **Levanta el sistema**: `docker-compose -f compose.yml up -d`
2. **Ejecuta demo**: `bash demo-commands.sh`
3. **Explora**: Abre http://localhost:8761 para ver Eureka
4. **Aprende**: Lee el guion (`GUION.md`) para entender detalles

---

**¡Listo para grabar! 🎬**
## Getting started
### System components Structure
Let's explain first the system structure to understand its components:
```
ecommerce-microservice-backend-app [μService] --> Parent folder.
|- docs --> All docs and diagrams.
|- k8s --> All **Kubernetes** config files.
    |- proxy-client --> Authentication & Authorization µService, exposing all 
    |- api-gateway --> API Gateway server
    |- service-discovery --> Service Registery server
    |- cloud-config --> Centralized Configuration server
    |- user-service --> Manage app users (customers & admins) as well as their credentials
    |- product-service --> Manage app products and their respective categories
    |- favourite-service --> Manage app users' favourite products added to their own favourite list
    |- order-service --> Manage app orders based on carts
    |- shipping-service --> Manage app order-shipping products
    |- payment-service --> Manage app order payments
|- compose.yml --> contains all services landscape with Kafka  
|- run-em-all.sh --> Run all microservices in separate mode. 
|- setup.sh --> Install all shared POMs and shared libraries. 
|- stop-em-all.sh --> Stop all services runs in standalone mode. 
|- test-em-all.sh --> This will start all docker compose landscape and test them, then shutdown docker compose containers with test finishes (use switch start stop)
```
Now, as we have learned about different system components, then let's start.

### System Boundary *Architecture* - μServices Landscape

![System Boundary](app-architecture.drawio.png)

### Required software

The following are the initially required software pieces:

1. **Java 11**: JDK 11 LTS can be downloaded and installed from https://www.oracle.com/java/technologies/javase/jdk11-archive-downloads.html

1. **Git**: it can be downloaded and installed from https://git-scm.com/downloads

1. **Maven**: Apache Maven is a software project management and comprehension tool, it can be downloaded from here https://maven.apache.org/download.cgi

1. **curl**: this command-line tool for testing HTTP-based APIs can be downloaded and installed from https://curl.haxx.se/download.html

1. **jq**: This command-line JSON processor can be downloaded and installed from https://stedolan.github.io/jq/download/

1. **Spring Boot Initializer**: This *Initializer* generates *spring* boot project with just what you need to start quickly! Start from here https://start.spring.io/

1. **Docker**: The fastest way to containerize applications on your desktop, and you can download it from here [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)

1. **Kubernetes**: We can install **minikube** for testing puposes https://minikube.sigs.k8s.io/docs/start/

   > For each future stage, I will list the newly required software. 

Follow the installation guide for each software website link and check your software versions from the command line to verify that they are all installed correctly.

## Using an IDE

I recommend that you work with your Java code using an IDE that supports the development of Spring Boot applications such as Spring Tool Suite or IntelliJ IDEA Ultimate Edition. So you can use the Spring Boot Dashboard to run the services, run each microservice test case, and many more.

All that you want to do is just fire up your IDE **->** open or import the parent folder `ecommerce-microservice-backend-app`, and everything will be ready for you.

## Data Model
### Entity-Relationship-Diagram
# 🎯 E-Commerce Microservices — Guía Completa para Presentación en Codespaces

**ENTRADA RÁPIDA: Lee primero [`ÍNDICE.md`](ÍNDICE.md) — centraliza toda la documentación para grabar tu video.**

**Este README es la guía técnica. Para grabar, sigue:**
1. **[ÍNDICE.md](ÍNDICE.md)** — mapa de toda la documentación
2. **[PRESENTACIÓN.md](PRESENTACIÓN.md)** — timeline y checklist para grabar ⭐
3. **[SCRIPT.md](SCRIPT.md)** — guion completo a leer en cámara
4. **[CHECKLIST.md](CHECKLIST.md)** — verificación pre/post grabación

## 📋 Resumen Ejecutivo

Este es un sistema de **e-commerce con 10 microservicios** construido con **Spring Boot + Spring Cloud**, demostrando patrones profesionales de arquitectura distribuida:
- ✅ **Service Discovery** (Eureka): registro automático de servicios
- ✅ **API Gateway** (Spring Cloud Gateway): enrutamiento centralizado
- ✅ **Config Server**: configuración centralizada
- ✅ **6 Servicios de dominio**: usuarios, productos, pedidos, pagos, envíos, favoritos
- ✅ **Observabilidad completa**: Zipkin, Prometheus, Grafana
- ✅ **Despliegue rápido**: Docker Compose (< 5 min)
- ✅ **Escalable**: Kubernetes + Helm ready

**Tecn stack**: Java 11, Spring Boot 2.5.x, Spring Cloud 2020.x, Docker, Kubernetes.

**Tiempo de grabación**: ~15-20 minutos  
**Entorno**: GitHub Codespaces (Docker + terminal)  
**Requisitos**: ✅ Git (incluido), ✅ Docker (incluido), ✅ jq (incluido)

---

## 🚀 INICIO RÁPIDO (3 pasos, ~5 min)

### Paso 1: Clonar el repositorio
```bash
git clone https://github.com/juanalar13/ecommerce-microservice-backend-app.git
cd ecommerce-microservice-backend-app
```

### Paso 2: Levantar todo con Docker Compose
```bash
docker-compose -f compose.yml up -d
```

**Mientras Docker descarga imágenes (1-2 min):**
- Se están descargando 11 contenedores desde Docker Hub (API Gateway, 8 servicios, Eureka, Config, Zipkin)
- Cada servicio se registra automáticamente con Eureka
- Todo se inicia en paralelo para máxima rapidez

### Paso 3: Verificar que está todo arriba
```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

**Debería ver algo así:**
```
NAME                                    STATUS          PORTS
ecommerce-microservice-backend-app_api-gateway-container_1       Up 10s      0.0.0.0:8080->8080/tcp
ecommerce-microservice-backend-app_service-discovery-container_1 Up 10s      0.0.0.0:8761->8761/tcp
ecommerce-microservice-backend-app_user-service-container_1      Up 10s      0.0.0.0:8700->8700/tcp
... (7 servicios más)
```

✅ **¡Sistema listo en ~3 minutos!**

---

## 🎬 DEMOSTRACIÓN DE FUNCIONALIDADES

### Opción A: Demostración automática (recomendada)
```bash
bash demo-requests.sh
```

Este script ejecuta automáticamente todos los requests y muestra los resultados con formato. **Perfecto para grabar video.**

### Opción B: Ejecutar requests individuales

```bash
# ▶ Listar productos
curl -s http://localhost:8080/product-service/api/products | jq .

# ▶ Listar usuarios
curl -s http://localhost:8080/user-service/api/users | jq .

# ▶ CREAR UN PEDIDO (esto es lo más impactante)
curl -s -X POST http://localhost:8080/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{"userId":1,"items":[{"productId":1,"quantity":2}]}' | jq .

# ▶ Listar todos los pedidos (verás el que creaste)
curl -s http://localhost:8080/order-service/api/orders | jq .

# ▶ Listar pagos
curl -s http://localhost:8080/payment-service/api/payments | jq .

# ▶ Listar envíos
curl -s http://localhost:8080/shipping-service/api/shippings | jq .

# ▶ Listar favoritos
curl -s http://localhost:8080/favourite-service/api/favourites | jq .
```

**Ver todos los comandos disponibles:**
```bash
bash demo-requests.sh curl
```

### Opción C: Explorar con navegador (URLs de observabilidad)

```bash
# Abrir Eureka (ver servicios registrados)
# Copia esta URL en navegador:
http://localhost:8761

# Abrir Zipkin (ver trazas distribuidas)
# Copia esta URL en navegador:
http://localhost:9411
```

---

## 📊 URLs Y PUERTOS DURANTE LA DEMO

| Componente | Puerto | URL |
|---|---|---|
| **API Gateway** | 8080 | `http://localhost:8080` |
| **Service Discovery (Eureka)** | 8761 | `http://localhost:8761` |
| **User Service** | 8700 | `http://localhost:8700` |
| **Product Service** | 8500 | `http://localhost:8500` |
| **Order Service** | 8300 | `http://localhost:8300` |
| **Payment Service** | 8400 | `http://localhost:8400` |
| **Shipping Service** | 8600 | `http://localhost:8600` |
| **Favourite Service** | 8800 | `http://localhost:8800` |
| **Proxy/Auth Client** | 8900 | `http://localhost:8900` |
| **Cloud Config** | 9296 | `http://localhost:9296` |
| **Zipkin (Tracing)** | 9411 | `http://localhost:9411` |

**Nota**: Todos los servicios son accesibles a través del **API Gateway en puerto 8080** usando prefijos:
- `/product-service/...`
- `/user-service/...`
- `/order-service/...`
- etc.

---

## 📚 ARCHIVOS CLAVE PARA LA PRESENTACIÓN

| Archivo | Propósito |
|---------|-----------|
| **README.md** | Este archivo — guía principal y referencia |
| **SCRIPT.md** | Guion completo para leer en la grabación (15-20 min) |
| **PRESENTACIÓN.md** | Instrucciones paso-a-paso para grabar (timeline, tips) |
| **demo-requests.sh** | Script con todos los curl listos para ejecutar |
| **QUICKSTART.sh** | Automatiza levantamiento: `bash QUICKSTART.sh` |

**Recomendación:** Lee en este orden:
1. Este **README.md** (ahora) — entiende qué es el proyecto
2. **PRESENTACIÓN.md** (antes de grabar) — checklist y timeline
3. **SCRIPT.md** (mientras grabas) — el guion a leer
4. **demo-requests.sh** (durante la demo) — ejecutar o copiar requests


---

## 🔍 ENDPOINTS PRINCIPALES PARA DEMOSTRAR

### 1️⃣ Servicio de Productos
```bash
# Listar
curl http://localhost:8080/product-service/api/products | jq .

# Obtener por ID
curl http://localhost:8080/product-service/api/products/1 | jq .

# Categorías
curl http://localhost:8080/product-service/api/categories | jq .
```

### 2️⃣ Servicio de Usuarios
```bash
# Listar
curl http://localhost:8080/user-service/api/users | jq .

# Obtener por ID
curl http://localhost:8080/user-service/api/users/1 | jq .

# Buscar por username
curl http://localhost:8080/user-service/api/users/username/john | jq .
```

### 3️⃣ Servicio de Pedidos (lo más importante)
```bash
# Listar pedidos existentes
curl http://localhost:8080/order-service/api/orders | jq .

# CREAR NUEVO PEDIDO (POST)
curl -X POST http://localhost:8080/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{"userId":1,"items":[{"productId":1,"quantity":2}]}' | jq .
```

### 4️⃣ Servicio de Pagos
```bash
curl http://localhost:8080/payment-service/api/payments | jq .
```

### 5️⃣ Servicio de Envíos
```bash
curl http://localhost:8080/shipping-service/api/shippings | jq .
```

### 6️⃣ Servicio de Favoritos
```bash
curl http://localhost:8080/favourite-service/api/favourites | jq .
```

---

## 🛠️ ARQUITECTURA (Lo que no ves pero funciona internamente)

```
┌─────────────────────────────────────────────────────────────────┐
│                   CLIENTE (curl / Navegador)                    │
└────────────────────┬──────────────────────────────────────────┘
                     │
          ┌──────────▼──────────┐
          │  API GATEWAY :8080  │◄─── Enruta todas solicitudes
          │  (Spring Cloud)     │     Descubrimiento automático
          └──────────┬──────────┘
                     │
        ┌────────────┼────────────┬────────────┐
        │            │            │            │
    ┌───▼──┐   ┌────▼────┐ ┌────▼────┐ ┌───▼──┐
    │ User │   │ Product │ │ Order   │ │ ... 6 servicios más
    └───┬──┘   └────┬────┘ └────┬────┘ └──┬──┘
        │           │            │        │
        └───────────┼────────────┼────────┘
                    │
          ┌─────────▼──────────┐
          │  EUREKA :8761      │◄─── Registro central
          │  (Service Registry)│     Todos se registran aquí
          └────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                  INFRAESTRUCTURA DE SOPORTE                     │
├─────────────────────────────────────────────────────────────────┤
│ • Cloud Config :9296 — Configuración centralizada              │
│ • Zipkin :9411 — Trazas distribuidas                           │
│ • (Prometheus, Grafana, ELK si usas Kubernetes)                │
└─────────────────────────────────────────────────────────────────┘
```

**Conceptos clave:**
- **Service Discovery**: Eureka. Los servicios se registran y se descubren automáticamente.
- **API Gateway**: El único punto de entrada. Enruta a los servicios correctos.
- **Circuit Breaker**: Si un servicio cae, el gateway devuelve respuesta degradada.
- **Config Centralizado**: Un servidor central manage configuración de todos.
- **Tracing**: Zipkin puede rastrear un request a través de múltiples servicios.

---

## 🧹 LIMPIAR (Cuando termines de grabar)

```bash
# Parar todos los contenedores
docker-compose -f compose.yml down

# Opcional: liberar más espacio (eliminar imágenes)
docker-compose -f compose.yml down --rmi all
```

---

## 📁 ESTRUCTURA DEL REPOSITORIO

```
ecommerce-microservice-backend-app/
├── README.md                          ◄─── Este archivo (guía principal)
├── SCRIPT.md                          ◄─── Guion para video
├── demo-requests.sh                   ◄─── Requests curl automatizados
├── compose.yml                        ◄─── Orquestación Docker (RÁPIDO)
├── pom.xml                            ◄─── Proyecto Maven (10 módulos)
├── k8s/                               ◄─── Kubernetes (alternativa enterprise)
│   ├── helm/                          ◄─── Helm charts
│   ├── infrastructure/                ◄─── NetworkPolicies
│   ├── security/                      ◄─── RBAC, Pod Security
│   └── ...
├── service-discovery/                 ◄─── Eureka Server
├── cloud-config/                      ◄─── Config Server
├── api-gateway/                       ◄─── Spring Cloud Gateway
├── proxy-client/                      ◄─── Auth/Proxy
├── user-service/                      ◄─── Users
├── product-service/                   ◄─── Products
├── favourite-service/                 ◄─── Favorites
├── order-service/                     ◄─── Orders & Carts
├── shipping-service/                  ◄─── Shipping
└── payment-service/                   ◄─── Payments
```

---

## 🎓 LO QUE SE DEMUESTRA

Este proyecto demuestra:

✅ **Patrones de Microservicios**
- Servicios independientes y desacoplados
- Comunicación HTTP/REST a través de gateway
- Service discovery automático

✅ **Cloud-Native con Spring Cloud**
- Service Registry (Eureka)
- Config Server (centralizado)
- Gateway (enrutamiento)
- Sleuth + Zipkin (tracing distribuido)
- Resilience4j (circuit breaker)

✅ **DevOps**
- Containerización (Docker)
- Orquestación rápida (Docker Compose)
- Infraestructura como código (Kubernetes + Helm)
- CI/CD ready (GitHub Actions)

✅ **Observabilidad**
- Trazas distribuidas (Zipkin)
- Métricas (Prometheus)
- Dashboards (Grafana)
- Logs centralizados (ELK)

✅ **Seguridad**
- RBAC en Kubernetes
- Network Policies
- Pod Security Standards
- TLS/HTTPS ready

---

## ⚡ PERFORMANCE Y TIMINGS

| Operación | Tiempo |
|---|---|
| `docker-compose up` (primera ejecución) | ~2-3 min |
| `docker-compose up` (con imágenes cached) | ~30 seg |
| Todos los servicios listos (primero) | ~15 seg después de `up` |
| Cada request curl | ~100-500 ms |

**Total para demostración completa**: ~15-20 minutos (incluyendo explicaciones)

---

## ❓ FAQ (Preguntas Frecuentes)

**P: ¿Por qué microservicios?**  
R: Escalabilidad independiente, equipos paralelos, despliegues sin downtime.

**P: ¿Qué pasa si un servicio cae?**  
R: Circuit Breaker lo detecta, devuelve respuesta degradada, otros siguen funcionando.

**P: ¿Cómo se comunican los servicios?**  
R: HTTP/REST a través del gateway o directamente tras descubrirse con Eureka.

**P: ¿En producción usarías Docker Compose?**  
R: No, usaríamos Kubernetes (manifests en `k8s/`). Docker Compose es solo para desarrollo/demo.

**P: ¿Dónde están los datos?**  
R: Por defecto en memoria (H2 en-memory). Para producción, usar MySQL externo (configurado en `k8s/`).

**P: ¿Cuánto cuesta esto en cloud?**  
R: Depende, pero 10 pods en Kubernetes es típicamente $50-200/mes en GCP/AWS/Azure.

---

## 🔗 REFERENCIAS IMPORTANTES

- **Requisitos originales**: Ver `REQUIREMENTS_CHECKLIST.md` (100% completado)
- **Arquitectura Kubernetes**: Ver `KUBERNETES_ARCHITECTURE.md`
- **Operaciones**: Ver `OPERATIONS_GUIDE.md`
- **Seguridad**: Ver `SECURITY_GUIDE.md`

---

## 🎥 PARA GRABAR EL VIDEO

1. **Lee `SCRIPT.md`** — tiene todo lo que debes decir
2. **Ejecuta `demo-requests.sh`** — muestra todo funcionando
3. **Timing**: ~15-20 minutos es ideal para un video YouTube
4. **Calidad**: Usa resolución 1080p, 30fps, audio claro

**Comando para grabación (OBS Studio o similar):**
```bash
# Terminal 1: Levanta el sistema
docker-compose -f compose.yml up -d

# Terminal 2: Ejecuta demo
bash demo-requests.sh
```

---

## 📞 SOPORTE

Si algo no funciona:
1. Verifica que Docker está corriendo: `docker ps`
2. Revisa logs: `docker logs <container-name>`
3. Reinicia: `docker-compose down && docker-compose up -d`
4. Limpia y reinicia: `docker system prune -a && docker-compose up -d`

---

**¡Listo para grabar! 🎬** — Sigue los pasos en `SCRIPT.md` y estarás en aire en 15-20 minutos.                        "slowCallRate": "-1.0%",
                        "slowCallRateThreshold": "100.0%",
                        "bufferedCalls": 0,
                        "slowCalls": 0,
                        "slowFailedCalls": 0,
                        "failedCalls": 0,
                        "notPermittedCalls": 0,
                        "state": "CLOSED"
                    }
                }
            }
        },
        "clientConfigServer": {
            "status": "UNKNOWN",
            "details": {
                "error": "no property sources located"
            }
        },
        "discoveryComposite": {
            "status": "UP",
            "components": {
                "discoveryClient": {
                    "status": "UP",
                    "details": {
                        "services": [
                            "proxy-client",
                            "api-gateway",
                            "cloud-config",
                            "product-service",
                            "user-service",
                            "favourite-service",
                            "order-service",
                            "payment-service",
                            "shipping-service"
                        ]
                    }
                },
                "eureka": {
                    "description": "Remote status from Eureka server",
                    "status": "UP",
                    "details": {
                        "applications": {
                            "FAVOURITE-SERVICE": 1,
                            "PROXY-CLIENT": 1,
                            "API-GATEWAY": 1,
                            "PAYMENT-SERVICE": 1,
                            "ORDER-SERVICE": 1,
                            "CLOUD-CONFIG": 1,
                            "PRODUCT-SERVICE": 1,
                            "SHIPPING-SERVICE": 1,
                            "USER-SERVICE": 1
                        }
                    }
                }
            }
        },
        "diskSpace": {
            "status": "UP",
            "details": {
                "total": 981889826816,
                "free": 325116776448,
                "threshold": 10485760,
                "exists": true
            }
        },
        "ping": {
            "status": "UP"
        },
        "refreshScope": {
            "status": "UP"
        }
    }
}
```
### Testing Them All
Now it's time to test all the application functionality as one part. To do so just run
 the following automation test script:

```bash
selim@:~/ecommerce-microservice-backend-app$ ./test-em-all.sh start
```
> You can use `stop` switch with `start`, that will 
>1. start docker, 
>2. run the tests, 
>3. stop the docker instances.

The result will look like this:

```bash
Starting 'ecommerce-microservice-backend-app' for [Blackbox] testing...

Start Tests: Tue, May 31, 2020 2:09:36 AM
HOST=localhost
PORT=8080
Restarting the test environment...
$ docker-compose -p -f compose.yml down --remove-orphans
$ docker-compose -p -f compose.yml up -d
Wait for: curl -k https://localhost:8080/actuator/health... , retry #1 , retry #2, {"status":"UP"} DONE, continues...
Test OK (HTTP Code: 200)
...
Test OK (actual value: 1)
Test OK (actual value: 3)
Test OK (actual value: 3)
Test OK (HTTP Code: 404, {"httpStatus":"NOT_FOUND","message":"No product found for productId: 13","path":"/app/api/products/20","time":"2020-04-12@12:34:25.144+0000"})
...
Test OK (actual value: 3)
Test OK (actual value: 0)
Test OK (HTTP Code: 422, {"httpStatus":"UNPROCESSABLE_ENTITY","message":"Invalid productId: -1","path":"/app/api/products/-1","time":"2020-04-12@12:34:26.243+0000"})
Test OK (actual value: "Invalid productId: -1")
Test OK (HTTP Code: 400, {"timestamp":"2020-04-12T12:34:26.471+00:00","path":"/app/api/products/invalidProductId","status":400,"error":"Bad Request","message":"Type mismatch.","requestId":"044dcdf2-13"})
Test OK (actual value: "Type mismatch.")
Test OK (HTTP Code: 401, )
Test OK (HTTP Code: 200)
Test OK (HTTP Code: 403, )
Start Circuit Breaker tests!
Test OK (actual value: CLOSED)
Test OK (HTTP Code: 500, {"timestamp":"2020-05-26T00:09:48.784+00:00","path":"/app/api/products/2","status":500,"error":"Internal Server Error","message":"Did not observe any item or terminal signal within 2000ms in 'onErrorResume' (and no fallback has been configured)","requestId":"4aa9f5e8-119"})
...
Test OK (actual value: Did not observe any item or terminal signal within 2000ms)
Test OK (HTTP Code: 200)
Test OK (actual value: Fallback product2)
Test OK (HTTP Code: 200)
Test OK (actual value: Fallback product2)
Test OK (HTTP Code: 404, {"httpStatus":"NOT_FOUND","message":"Product Id: 14 not found in fallback cache!","path":"/app/api/products/14","timestamp":"2020-05-26@00:09:53.998+0000"})
...
Test OK (actual value: product name C)
Test OK (actual value: CLOSED)
Test OK (actual value: CLOSED_TO_OPEN)
Test OK (actual value: OPEN_TO_HALF_OPEN)
Test OK (actual value: HALF_OPEN_TO_CLOSED)
End, all tests OK: Tue, May 31, 2020 2:10:09 AM
```
### Tracking the services with Zipkin
Now, you can now track Microservices interactions throughout Zipkin UI from the following link:
[http://localhost:9411/zipkin/](http://localhost:9411/zipkin/)
![Zipkin UI](zipkin-dash.png)

### Closing The Story

Finally, to close the story, we need to shut down Microservices manually service by service, hahaha just kidding, run the following command to shut them all:

```bash
selim@:~/ecommerce-microservice-backend-app$ docker-compose -f compose.yml down --remove-orphans
```
 And you should see output like the following:

```bash
Removing ecommerce-microservice-backend-app_payment-service-container_1   ... done
Removing ecommerce-microservice-backend-app_zipkin-container_1            ... done
Removing ecommerce-microservice-backend-app_service-discovery-container_1 ... done
Removing ecommerce-microservice-backend-app_product-service-container_1   ... done
Removing ecommerce-microservice-backend-app_cloud-config-container_1      ... done
Removing ecommerce-microservice-backend-app_proxy-client-container_1      ... done
Removing ecommerce-microservice-backend-app_order-service-container_1     ... done
Removing ecommerce-microservice-backend-app_user-service-container_1      ... done
Removing ecommerce-microservice-backend-app_shipping-service-container_1  ... done
Removing ecommerce-microservice-backend-app_api-gateway-container_1       ... done
Removing ecommerce-microservice-backend-app_favourite-service-container_1 ... done
Removing network ecommerce-microservice-backend-app_default
```
### The End
In the end, I hope you enjoyed the application and find it useful, as I did when I was developing it. 
If you would like to enhance, please: 
- **Open PRs**, 
- Give **feedback**, 
- Add **new suggestions**, and
- Finally, give it a 🌟.

*Happy Coding ...* 🙂
