# E-Commerce Microservices - Demostración en Codespaces

Sistema de **10 microservicios** con Spring Boot, Spring Cloud y Docker. **Ejecutable en GitHub Codespaces en menos de 5 minutos.**

---

## 🎯 ¿Qué es este proyecto?

Una arquitectura moderna de **microservicios escalable** que demuestra:
- ✅ 10 microservicios independientes (Spring Boot)
- ✅ Service Discovery automático (Eureka)
- ✅ API Gateway centralizado
- ✅ Trazas distribuidas (Zipkin)
- ✅ Comunicación inter-servicios eficiente

---

## 🚀 Inicio Rápido (3 pasos, ~5 minutos)

### Paso 1: Preparar el ambiente

```bash
# Todas las herramientas necesarias ya están en Codespaces
docker ps
```

### Paso 2: Levantar todos los servicios

```bash
docker-compose -f compose.yml up -d
```

**Mientras Docker inicia (1-2 minutos):**
- Se descargan 11 imágenes desde Docker Hub
- Cada servicio se registra automáticamente con Eureka
- Sistema completamente operativo cuando todos los contenedores estén `Up`

### Paso 3: Verificar que está activo

```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

✅ **¡Sistema completamente operativo!**

---

## 🎬 Demostración de Funcionalidades

### Ejecución automática (recomendada)

```bash
bash demo-requests.sh
```

Ejecuta automáticamente 15+ requests contra todos los servicios.

### Ejemplos de requests individuales

#### 1. Listar productos
```bash
curl -s http://localhost:8080/product-service/api/products | jq .
```

#### 2. Listar usuarios
```bash
curl -s http://localhost:8080/user-service/api/users | jq .
```

#### 3. **CREAR UN PEDIDO** (demuestra inter-servicios)
```bash
curl -s -X POST http://localhost:8080/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{"userId":1,"items":[{"productId":1,"quantity":2}]}' | jq .
```

#### 4. Listar todos los pedidos
```bash
curl -s http://localhost:8080/order-service/api/orders | jq .
```

#### 5. Listar pagos
```bash
curl -s http://localhost:8080/payment-service/api/payments | jq .
```

#### 6. Listar envíos
```bash
curl -s http://localhost:8080/shipping-service/api/shippings | jq .
```

#### 7. Listar favoritos
```bash
curl -s http://localhost:8080/favourite-service/api/favourites | jq .
```

---

## 📊 Componentes del Sistema

| # | Servicio | Puerto | Función |
|---|----------|--------|---------|
| 1 | **API Gateway** | 8080 | Punto de entrada único |
| 2 | **User Service** | 8700 | Gestión de usuarios |
| 3 | **Product Service** | 8500 | Catálogo de productos |
| 4 | **Order Service** | 8300 | Gestión de pedidos |
| 5 | **Payment Service** | 8400 | Procesamiento de pagos |
| 6 | **Shipping Service** | 8600 | Gestión de envíos |
| 7 | **Favourite Service** | 8800 | Gestión de favoritos |
| 8 | **Service Discovery** | 8761 | Eureka - Registro automático |
| 9 | **Cloud Config** | 9296 | Configuración centralizada |
| 10 | **Proxy/Auth** | 8900 | Autenticación |
| 11 | **Zipkin** | 9411 | Trazas distribuidas |

---

## 🌐 URLs de Observabilidad

### Service Discovery (Eureka)
Ver todos los servicios registrados:
```
http://localhost:8761
```

### Trazas Distribuidas (Zipkin)
Rastrear requests a través de múltiples servicios:
```
http://localhost:9411
```

---

## 📝 Conceptos Demostrados

✅ **Microservicios** - 10 servicios independientes y escalables  
✅ **Service Discovery** - Registro automático con Eureka  
✅ **API Gateway** - Punto de entrada centralizado  
✅ **Comunicación Inter-Servicios** - REST calls entre servicios  
✅ **Trazas Distribuidas** - Rastreo end-to-end de requests  
✅ **Tolerancia a Fallos** - Circuit Breaker con Resilience4j  
✅ **Escalabilidad** - Agregar/quitar servicios sin cambiar código  
✅ **DevOps** - Containerización con Docker  

---

## 🔍 Entender la Arquitectura

```
┌──────────────────────────────────────────┐
│   Cliente (curl / Navegador)            │
└──────────────┬───────────────────────────┘
               │
        ┌──────▼──────────┐
        │  API GATEWAY    │  (puerto 8080)
        │  :8080          │  ← Único punto de entrada
        └──────┬──────────┘
               │
      ┌────────┴────────┬──────────┬──────────┐
      │                 │          │          │
   ┌──▼──┐         ┌───▼───┐ ┌───▼───┐ ┌───▼──┐
   │User │         │Product│ │ Order │ │ ...  │
   │:8700│         │:8500  │ │:8300  │ │(6+ svc)
   └──┬──┘         └───┬───┘ └───┬───┘ └──┬───┘
      │                │         │        │

┌────────────────────────────────────────────┐
│        INFRAESTRUCTURA DE SOPORTE          │
├────────────────────────────────────────────┤
│ • Eureka :8761    - Service Discovery     │
│ • Zipkin :9411    - Trazas distribuidas   │
│ • Config :9296    - Configuración central │
└────────────────────────────────────────────┘
```

**Cómo funciona:**
1. Cliente hace request a `/product-service/api/products`
2. API Gateway recibe el request
3. Eureka dice dónde está Product Service
4. Gateway enruta al servicio correcto
5. Zipkin registra la traza completa

---

## 🧹 Detener los Servicios

```bash
# Parar todos los contenedores
docker-compose -f compose.yml down

# Liberar espacio (elimina imágenes)
docker-compose -f compose.yml down --rmi all
```

---

## 📁 Estructura de Directorios

```
ecommerce-microservice-backend-app/
├── README.md                    ← Este archivo
├── compose.yml                  ← Orquestación Docker
├── demo-requests.sh             ← Script de demostración
│
├── service-discovery/           ← Eureka Server
├── cloud-config/                ← Config Server
├── api-gateway/                 ← Spring Cloud Gateway
├── proxy-client/                ← Auth/Proxy
│
├── user-service/                ← Usuarios
├── product-service/             ← Productos
├── favourite-service/           ← Favoritos
├── order-service/               ← Pedidos
├── shipping-service/            ← Envíos
├── payment-service/             ← Pagos
│
└── k8s/                         ← Kubernetes + Helm
```

---

## 🛠️ Stack Tecnológico

- **Java 11** - Lenguaje base
- **Spring Boot 2.5.7** - Framework base
- **Spring Cloud 2020.0.4** - Microservicios
- **Spring Cloud Gateway** - API Gateway
- **Eureka** - Service Discovery
- **Resilience4j** - Circuit Breaker
- **Zipkin + Sleuth** - Trazas distribuidas
- **Docker** - Containerización

---

## ❓ FAQ Rápido

**P: ¿Cuánto tarda en levantarse?**  
R: ~3 minutos la primera vez, ~30 segundos con imágenes cacheadas.

**P: ¿Qué pasa si un servicio falla?**  
R: El Circuit Breaker lo detecta, otros servicios siguen funcionando.

**P: ¿Cómo se comunican los servicios?**  
R: HTTP/REST a través del gateway o directamente tras descubrirse con Eureka.

**P: ¿En producción usarías Docker Compose?**  
R: No, Kubernetes (manifests en `k8s/`). Docker Compose es solo para desarrollo/demo.

---

## 📞 Troubleshooting

**Puerto ya está en uso:**
```bash
lsof -i :8080
kill -9 <PID>
```

**Servicios no se registran en Eureka:**
```bash
# Esperar 30-60 segundos, Eureka es lento al iniciar
sleep 60
curl -s http://localhost:8761/eureka/apps | jq .
```

**Ver logs de un servicio:**
```bash
docker logs <nombre-contenedor>
```

---

**¡Listo para empezar! 🚀**

Ejecuta: `docker-compose -f compose.yml up -d`

En 3 minutos tendrás 10 microservicios funcionando correctamente.
