# 🎬 INSTRUCCIONES PARA GRABAR VIDEO EN CODESPACES

**Objetivo**: Grabar una presentación de 15-20 minutos demostrando todos los microservicios.  
**Ambiente**: GitHub Codespaces  
**Requisitos**: Docker (incluido en Codespaces)

---

## 📋 CHECKLIST PRE-GRABACIÓN

- [ ] Terminal de Codespaces abierta
- [ ] Micrófono y cámara funcionando (si quieres incluir tu rostro)
- [ ] OBS Studio o similar para grabar (o usar grabador de pantalla nativo)
- [ ] Zoom o tamaño de fuente al 150% para visibilidad
- [ ] README.md, SCRIPT.md y demo-requests.sh listos

---

## ⏱️ TIMELINE DE GRABACIÓN (16 minutos total)

| Tiempo | Duración | Actividad |
|--------|----------|-----------|
| 0:00 | 1 min | Introducción + estructura |
| 1:00 | 2-3 min | `docker-compose up -d` + esperar |
| 3:30 | 1 min | Verificar con `docker ps` |
| 4:30 | 0.5 min | Explicar Eureka y Service Discovery |
| 5:00 | 6 min | Ejecutar `demo-requests.sh` (todos los endpoints) |
| 11:00 | 2 min | Explicar arquitectura y patrones implementados |
| 13:00 | 1 min | Mencionar alternativas (Kubernetes, etc) |
| 14:00 | 1 min | Cierre y conclusiones |
| 15:00 | 1 min | Buffer/final |

---

## 🎬 PASO A PASO PARA GRABAR

### PARTE 1: INTRODUCCIÓN (1 minuto)

**Actividad:**
1. Abre terminal en Codespaces
2. Maximiza la ventana (para que el texto sea legible)
3. Inicia grabación

**Guion a leer:**
> "Hola, bienvenidos. Hoy voy a demostrar un sistema de e-commerce construido con microservicios en Spring Boot. El proyecto implementa 10 microservicios independientes con Service Discovery, API Gateway, configuración centralizada y observabilidad completa. Vamos a ejecutarlo aquí en GitHub Codespaces usando Docker Compose."

**Comandos:**
```bash
# Posiciónate en la carpeta correcta
cd /workspaces/ecommerce-microservice-backend-app

# Muestra la estructura
ls -la
```

**Tiempo**: ~1 min

---

### PARTE 2: INICIAR SISTEMA (2-3 minutos)

**Guion:**
> "Primero, levantaremos el sistema completo con Docker Compose. Esto descargará las imágenes Docker y levantará todos los servicios en paralelo. Puede tomar 1-2 minutos en la primera ejecución."

**Comandos:**
```bash
# Levantar servicios
docker-compose -f compose.yml up -d

# Mientras se inicia (dice esto en la grabación):
# "Docker está descargando las imágenes de los 11 servicios: API Gateway, 
#  Eureka para service discovery, Config Server, Zipkin para tracing distribuido, 
#  y 6 servicios de dominio: usuarios, productos, pedidos, pagos, envíos y favoritos."
```

**Esperar tiempo**: ~1-2 minutos para que descargue y levante todo

**Tiempo**: ~2-3 min

---

### PARTE 3: VERIFICACIÓN (1 minuto)

**Guion:**
> "Verifiquemos que todo está corriendo correctamente."

**Comandos:**
```bash
# Ver contenedores
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep ecommerce

# Debería mostrar algo así:
# api-gateway-container       Up 45 seconds       0.0.0.0:8080->8080/tcp
# service-discovery-container Up 45 seconds       0.0.0.0:8761->8761/tcp
# user-service-container      Up 45 seconds       0.0.0.0:8700->8700/tcp
# ... etc
```

**Mencionar:**
> "Perfecto. Todos los 11 contenedores están corriendo. Ahora vamos a probar los endpoints."

**Tiempo**: ~1 min

---

### PARTE 4: DEMONSTRATION TÉCNICA (6 minutos)

**Guion:**
> "Ahora vamos a demostrar la funcionalidad de los 6 servicios de dominio. Todos se acceden a través del API Gateway en el puerto 8080, que automáticamente enruta los requests al servicio correcto usando Service Discovery."

**Ejecutar demo (automática):**
```bash
bash demo-requests.sh
```

**Qué ocurre:**
- Script ejecuta ~12 requests curl automaticamente
- Muestra respuestas JSON formateadas
- Incluye ejemplo de **crear un pedido** (POST) que es lo más impactante
- Muestra todos los servicios funcionando

**Durante la ejecución (mientras muestra resultados), di:**

En primer request (productos):
> "Aquí estamos listando los productos. El gateway enruta automáticamente a Product Service."

En segundo request (usuarios):
> "Usuarios registrados en el sistema. El User Service gestiona autenticación y perfiles."

Cuando crea pedido (POST):
> "Ahora el **punto más importante** — creamos un nuevo pedido. Enviamos un JSON con usuario, productos y cantidades. El Order Service lo procesa y devuelve el ID del pedido. Esto muestra cómo los servicios comunican entre sí de forma síncrona a través del gateway."

Al listar pedidos nuevamente:
> "Y aquí vemos que el pedido que acabamos de crear aparece en la lista. Esto comprueba que los datos persisten."

**Tiempo**: ~5-6 min (el script se ejecuta automáticamente)

---

### PARTE 5: EXPLICACIÓN DE ARQUITECTURA (2 minutos)

**Guion:**
> "Déjame explicar cómo funciona esto internamente. El sistema implementa varios patrones enterprise de microservicios:"

**Mostrar/Explicar:**

1. **Service Discovery**
```bash
# Mostrar URL de Eureka
echo "http://localhost:8761"
```
> "Eureka es el registro central. Todos los servicios se registran automáticamente cuando inician. El API Gateway consulta Eureka para saber dónde está cada servicio. Si un servicio cae, Eureka lo detecta y deja de enviarlo requests."

2. **API Gateway**
> "El API Gateway es el único punto de entrada. Hace routing, load-balancing, y puede implementar políticas de seguridad centralizadas. Todo en el puerto 8080."

3. **Servicios independientes**
> "Cada servicio es independiente, con su propia base de datos lógica y su puerto. Pueden deployarse, escalarse y fallar sin afectar a otros."

4. **Observabilidad**
```bash
# Mencionar
echo "http://localhost:9411"  # Zipkin
```
> "Zipkin nos permite ver trazas distribuidas. Si un request pasa por 5 servicios, Zipkin nos muestra cuánto tiempo tardó en cada uno. Muy útil para encontrar cuellos de botella."

**Mencionar patrones implementados:**
> "El sistema también implementa:
> - **Circuit Breaker**: Si un servicio no responde, devuelve error degradado sin saturar
> - **Health Checks**: Cada servicio expone /health para que otros sepan si está disponible
> - **Config Centralizado**: Todas las propiedades en un lugar, sin recompilar código
> - **Trazas distribuidas**: Ver el viaje de un request a través de múltiples servicios"

**Tiempo**: ~2 min

---

### PARTE 6: ALTERNATIVAS Y ESCALADO (1 minuto)

**Guion:**
> "Hoy demostramos Docker Compose que es perfecto para desarrollo. En producción, usaríamos Kubernetes con Helm. El repositorio incluye toda esa configuración lista."

**Mencionar:**
> "En Kubernetes:
> - Los servicios se replican automáticamente (3-10 copies cada uno)
> - Se hacen health-checks automáticos y restarts si fallan
> - Se hace rolling updates sin downtime
> - Se integra con Prometheus para métricas y alertas
> - Se implementa Network Policies para seguridad de red
> 
> Todo listo en la carpeta k8s/ del repo."

**Tiempo**: ~1 min

---

### PARTE 7: CIERRE (1-2 minutos)

**Guion:**
> "En resumen, hemos visto:
> ✅ 10 microservicios desplegados en menos de 3 minutos
> ✅ Service Discovery automático con Eureka
> ✅ API Gateway que enruta todas las solicitudes
> ✅ 6 servicios de dominio completamente funcionales
> ✅ Observabilidad con Zipkin para trazas distribuidas
> ✅ Patrones enterprise como Circuit Breaker y Health Checks
> 
> Este es el tipo de arquitectura que usa Netflix, Amazon, Google. Es escalable, resiliente y maintenibl a a cualquier tamaño.
> 
> El código completo está en GitHub y es open-source. Gracias por ver la demostración."

**Al final:**
```bash
# Limpia (opcional, pero buena práctica)
docker-compose -f compose.yml down
```

**Tiempo**: ~1-2 min

---

## 🎥 CONFIGURACIÓN RECOMENDADA (OBS STUDIO)

Si usas OBS para grabar:

**Video:**
- Resolución: 1920x1080 (Full HD)
- FPS: 30
- Bitrate: 6000 kbps

**Audio:**
- Micrófono
- Sample Rate: 48 kHz
- Bitrate: 128 kbps

**Temas de OBS:**
- Fuente: Window Capture (Codespaces)
- Tamaño fuente terminal: Zoom 150%+
- Filtro: Sharpen para mejorar legibilidad

---

## 💾 ARCHIVO DE SALIDA

**Recomendado:**
- Formato: MP4
- Codec: H.264
- Tamaño típico: 200-400 MB para 15-20 minutos

---

## ⚠️ POSIBLES PROBLEMAS Y SOLUCIONES

### Problema: `docker-compose up` cuelga
**Solución:**
```bash
docker system prune -a
docker-compose pull
docker-compose up -d
```

### Problema: Servicios no responden
**Solución:**
```bash
# Esperar más tiempo (15-30 segundos)
docker logs <container-name>  # Ver logs específicos
docker-compose down
docker-compose up -d  # Reintentar
```

### Problema: curl dice "Connection refused"
**Solución:**
```bash
# Verificar que docker está corriendo
docker ps

# Si está vacío, levantar de nuevo
docker-compose -f compose.yml up -d
```

### Problema: La pantalla está muy pequeña
**Solución:**
```bash
# Usar zoom del navegador o terminal
# En Codespaces: Ctrl+Shift+P > "Terminal: Change Font Size"
```

---

## 📹 TIPS DE GRABACIÓN

1. **Pausas naturales**: No hables constantemente. Deja que los viewers procesen.
2. **Señalar con cursor**: Mueve el mouse para resaltar lo importante.
3. **Zoom al paste**: Cuando hagas `docker ps`, amplía el resultado para que se vea bien.
4. **Edición post-grabación**: Puedes cortar, acelerar partes lentas, añadir música.
5. **Subtítulos**: Considera grabar en audio claro o añadir subtítulos en post-producción.

---

## 📊 ESTRUCTURA DE CONTENIDO PARA YOUTUBE

**Título sugerido:**
> "10 Microservicios en Spring Boot — Service Discovery, API Gateway, Docker Compose y Kubernetes"

**Descripción:**
```
Demostración completa de un sistema de e-commerce basado en microservicios con Spring Boot y Spring Cloud.

0:00 - Introducción
1:00 - Levantando sistema con Docker Compose
3:30 - Verificación
4:30 - Service Discovery (Eureka)
5:00 - Demostración de endpoints
11:00 - Explicación de arquitectura
13:00 - Producción con Kubernetes
14:00 - Cierre

Repositorio: https://github.com/juanalar13/ecommerce-microservice-backend-app
Stack: Java 11, Spring Boot 2.5, Spring Cloud, Docker, Kubernetes, Helm
```

**Tags:**
`microservices, spring-boot, spring-cloud, docker, kubernetes, java, architecture, eureka, api-gateway, scalability, distributed-systems`

---

## ✅ CHECKLIST FINAL ANTES DE DESCARGAR VIDEO

- [ ] Audio claro sin ruido de fondo
- [ ] Texto/comandos legibles (fuente grande)
- [ ] Timings correctos (no demasiado rápido)
- [ ] Todos los servicios funcionando en demo
- [ ] Explicaciones claras y concisas
- [ ] Archivo exportado en MP4/H.264
- [ ] Video probado (reproducción sin problemas)

---

**¡Estás listo para grabar! 🎬** Sigue este plan paso a paso y tendrás una presentación profesional en 15-20 minutos.
