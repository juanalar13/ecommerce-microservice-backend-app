# 📑 ÍNDICE DE DOCUMENTACIÓN - E-COMMERCE MICROSERVICES

**Navega este repositorio usando este índice. Todo está documentado para que grabes tu video en GitHub Codespaces.**

---

## 🎯 PARA GRABAR VIDEO (EMPIEZA AQUÍ)

### 1️⃣ **PRESENTACIÓN.md** ⭐ COMIENZA AQUÍ
- Timeline paso-a-paso para grabar
- Checklist pre-grabación
- Tips de video/audio
- Problemas comunes y soluciones
- **Tiempo de lectura**: ~10 min
- **Tiempo de preparación**: ~15 min

### 2️⃣ **SCRIPT.md**
- Guion completo para leer en cámara
- Timings de cada sección (1-20 min)
- Qué decir en cada punto
- Preguntas frecuentes con respuestas
- **Tiempo de lectura**: ~15 min
- **Tiempo de grabación**: ~15-20 min

### 3️⃣ **README.md**
- Guía general del proyecto
- Inicio rápido (3 pasos)
- Descripción de componentes
- URLs y puertos
- **Tiempo de lectura**: ~10 min

### 4️⃣ **CHECKLIST.md**
- Verificación antes de grabar
- Troubleshooting durante grabación
- Validación post-grabación
- **Tiempo**: ~5 min (ejecutar antes de grabar)

---

## 🚀 SCRIPTS AUTOMATIZADOS

### **QUICKSTART.sh**
Levanta todo automáticamente en 3 pasos:
```bash
bash QUICKSTART.sh
```
- ✅ Verifica Docker
- ✅ Inicia contenedores
- ✅ Espera a que servicios estén listos
- ✅ Muestra URLs
- **Tiempo**: ~3 minutos

### **demo-requests.sh**
Ejecuta demostraciones de endpoints:
```bash
bash demo-requests.sh          # Ejecución completa
bash demo-requests.sh curl     # Solo listar comandos
bash demo-requests.sh info     # Solo mostrar URLs
```
- ✅ 12+ requests listos
- ✅ Formato JSON
- ✅ Copiar/pegar individual
- **Tiempo**: ~5-6 minutos

---

## 📊 INFORMACIÓN TÉCNICA

### **Microservicios (10 total)**

| # | Nombre | Puerto | Propósito |
|---|---|---|---|
| 1 | Service Discovery | 8761 | Eureka - Registro de servicios |
| 2 | Cloud Config | 9296 | Configuración centralizada |
| 3 | API Gateway | 8080 | Enrutamiento y balanceo |
| 4 | Proxy Client | 8900 | Autenticación y autorización |
| 5 | User Service | 8700 | Gestión de usuarios |
| 6 | Product Service | 8500 | Catálogo de productos |
| 7 | Favourite Service | 8800 | Productos favoritos |
| 8 | Order Service | 8300 | Pedidos y carritos |
| 9 | Payment Service | 8400 | Procesamiento de pagos |
| 10 | Shipping Service | 8600 | Envíos y seguimiento |

### **Servicios de Observabilidad**
- **Zipkin** (9411): Trazas distribuidas
- **Prometheus** (accesible vía Kubernetes)
- **Grafana** (accesible vía Kubernetes)

---

## 📈 TIMING DE DEMOSTRACIÓN

| Sección | Tiempo | Descripción |
|---------|--------|-------------|
| Introducción | 1 min | Explicar qué es el proyecto |
| Levantamiento | 2-3 min | `docker-compose up -d` |
| Verificación | 1 min | Confirmar servicios |
| Demo requests | 5-6 min | Ejecutar `demo-requests.sh` |
| Explicación | 2 min | Arquitectura y patrones |
| Cierre | 1-2 min | Conclusiones |
| **TOTAL** | **15-20 min** | **Ideal para YouTube** |

---

## 🛠️ STACK TÉCNICO

**Lenguaje**: Java 11  
**Framework**: Spring Boot 2.5.7  
**Cloud**: Spring Cloud 2020.0.4  
**Containerización**: Docker  
**Orquestación rápida**: Docker Compose  
**Orquestación producción**: Kubernetes + Helm  
**Tracing**: Zipkin + Sleuth  
**Métricas**: Prometheus + Micrometer  
**Dashboards**: Grafana  
**Logs**: ELK Stack (Elasticsearch, Logstash, Kibana)  
**Resiliencia**: Resilience4j (Circuit Breaker)  

---

## 📁 ESTRUCTURA DEL REPOSITORIO

```
ecommerce-microservice-backend-app/
│
├── 📖 DOCUMENTACIÓN PARA GRABAR
│   ├── README.md                    ← Guía general (EMPIEZA SI ERES NUEVO)
│   ├── PRESENTACIÓN.md              ← Timeline y checklist para grabación ⭐
│   ├── SCRIPT.md                    ← Guion a leer en cámara
│   ├── CHECKLIST.md                 ← Verificación pre/post grabación
│   └── ÍNDICE.md                    ← Este archivo
│
├── 🚀 SCRIPTS DE DEMOSTRACIÓN
│   ├── QUICKSTART.sh                ← Automatiza levantamiento
│   ├── demo-requests.sh             ← Requests curl listos
│   └── compose.yml                  ← Docker Compose config
│
├── 📚 DOCUMENTACIÓN TÉCNICA
│   ├── REQUIREMENTS_CHECKLIST.md    ← Requisitos del proyecto
│   ├── KUBERNETES_ARCHITECTURE.md   ← Arquitectura Kubernetes
│   ├── OPERATIONS_GUIDE.md          ← Guía operacional
│   ├── SECURITY_GUIDE.md            ← Guía de seguridad
│   └── K8S_IMPLEMENTATION_SUMMARY.md ← Resumen implementación K8s
│
├── 🏗️ CÓDIGO FUENTE (10 Microservicios)
│   ├── service-discovery/           ← Eureka Server
│   ├── cloud-config/                ← Config Server
│   ├── api-gateway/                 ← Spring Cloud Gateway
│   ├── proxy-client/                ← Auth/Proxy
│   ├── user-service/                ← Users
│   ├── product-service/             ← Products
│   ├── favourite-service/           ← Favorites
│   ├── order-service/               ← Orders & Carts
│   ├── payment-service/             ← Payments
│   └── shipping-service/            ← Shipping
│
├── ☸️ KUBERNETES & HELM
│   ├── k8s/
│   │   ├── helm/
│   │   │   └── ecommerce-microservices/  ← Helm Chart
│   │   ├── namespaces/
│   │   ├── infrastructure/
│   │   ├── security/
│   │   ├── persistence/
│   │   ├── monitoring/
│   │   └── logging/
│   ├── k8s-deploy.sh
│   ├── k8s-verify.sh
│   └── k8s-commands.sh
│
├── 🔧 CONFIGURACIÓN
│   ├── pom.xml                      ← POM padre (10 módulos)
│   ├── .github/
│   │   └── workflows/               ← CI/CD (GitHub Actions)
│   ├── azure-pipelines.yml          ← Azure DevOps
│   └── system.properties            ← Java runtime config
│
└── 📊 DIAGRAMA & ASSETS
    ├── app-architecture.drawio
    ├── app-architecture.drawio.png  ← Diagrama de arquitectura
    ├── ecommerce-ERD.drawio
    └── ecommerce-ERD.drawio.png    ← Diagrama de BD
```

---

## ⏱️ RUTA RÁPIDA PARA GRABAR (40 minutos total)

1. **[5 min]** Lee **PRESENTACIÓN.md** (checklist y tips)
2. **[5 min]** Ejecuta `bash CHECKLIST.md` (verificación)
3. **[3 min]** Ejecuta `bash QUICKSTART.sh` (levanta servicios)
4. **[20 min]** Graba siguiendo **SCRIPT.md** + `demo-requests.sh`
5. **[5 min]** Post-producción básica (cortes, audio)
6. **[2 min]** Export MP4 H.264

**Total**: ~40 minutos → Video listo de 15-20 minutos ✅

---

## 🎬 PARA YOUTUBE

**Título sugerido:**
> "10 Microservicios con Spring Boot — Service Discovery, API Gateway y Docker Compose en Vivo"

**Tags:**
```
microservices spring-boot spring-cloud docker kubernetes java 
architecture eureka api-gateway scalability distributed-systems 
containerization devops cloud-native spring
```

**Descripción:**
```
Demostración en vivo de un sistema e-commerce completo con 10 microservicios.

▶ Lo que se muestra:
✓ Service Discovery automático (Eureka)
✓ API Gateway centralizado
✓ 6 servicios de dominio (usuarios, productos, pedidos, pagos, envíos, favoritos)
✓ Observabilidad con Zipkin
✓ Escalabilidad con Docker y Kubernetes
✓ Patrones enterprise (Circuit Breaker, Health Checks)

▶ Stack:
Java 11 | Spring Boot 2.5 | Spring Cloud | Docker | Kubernetes | Helm

▶ Recursos:
Repo: https://github.com/juanalar13/ecommerce-microservice-backend-app
README: instrucciones paso-a-paso
SCRIPT.md: guion completo
PRESENTACIÓN.md: timeline de grabación

▶ Timestamps:
0:00 - Introducción
1:00 - Levantando sistema
3:30 - Verificación
4:30 - Explicación conceptos
5:00 - Demostración endpoints
11:00 - Arquitectura explicada
13:00 - Próximos pasos
14:00 - Cierre

#Microservices #SpringBoot #Docker #Kubernetes
```

---

## ❓ PREGUNTAS RÁPIDAS

**P: ¿Por dónde empiezo?**
R: Lee **PRESENTACIÓN.md** (~10 min), luego ejecuta `bash QUICKSTART.sh`.

**P: ¿Cuánto tarda grabar?**
R: 20 minutos grabando + 10 min de setup = ~30 min total.

**P: ¿Es necesario tener Kubernetes?**
R: No, Docker Compose es suficiente para demostración. Kubernetes es para alternativa enterprise.

**P: ¿Dónde están los datos?**
R: En memoria (H2 in-memory). Listo para conectar MySQL en producción.

**P: ¿Necesito Postman?**
R: No, usamos `curl` en terminal. Script incluido.

**P: ¿Puedo grabar en Codespaces?**
R: Sí, todo está optimizado para Codespaces. Docker está incluido.

---

## 🔗 LINKS IMPORTANTES

| Recurso | URL |
|---------|-----|
| Repository | https://github.com/juanalar13/ecommerce-microservice-backend-app |
| Issues | https://github.com/juanalar13/ecommerce-microservice-backend-app/issues |
| Spring Boot | https://spring.io/projects/spring-boot |
| Spring Cloud | https://spring.io/projects/spring-cloud |
| Docker Docs | https://docs.docker.com/ |
| Kubernetes | https://kubernetes.io/ |
| Helm | https://helm.sh/ |

---

## ✅ CHECKLIST PRE-GRABACIÓN RÁPIDO

```bash
# Verifica esto antes de grabar
docker --version           # ✅ Docker presente
docker-compose --version   # ✅ Docker Compose presente
cd /workspaces/ecommerce-microservice-backend-app  # ✅ Carpeta correcta
bash QUICKSTART.sh         # ✅ Sistema levanta sin errores
bash demo-requests.sh curl # ✅ Requests disponibles
```

**Si todo da ✅, estás listo para grabar!**

---

## 📞 SOPORTE

Si algo no funciona:

1. **Revisa CHECKLIST.md** — troubleshooting section
2. **Verifica logs**: `docker logs <container-name>`
3. **Reinicia**: `docker-compose down && docker-compose up -d`
4. **Limpia**: `docker system prune -a`

---

**Actualizado**: Diciembre 2025  
**Versión del Proyecto**: 0.1.0  
**Stack**: Spring Boot 2.5.7 + Spring Cloud 2020.0.4  
**Entorno**: GitHub Codespaces

---

**¡Listo para grabar! 🎬** Sigue este índice y tendrás un video profesional en 30-40 minutos.
