# 🎬 GUION DE PRESENTACIÓN - E-COMMERCE MICROSERVICES

**Duración total**: ~15-20 minutos  
**Entorno**: GitHub Codespaces  
**Demostración**: Docker Compose (rápido y ligero)

---

## 📋 ÍNDICE DEL GUION
1. Introducción (1 min)
2. Explorar estructura del repo (1.5 min)
3. Iniciar sistema con Docker Compose (2-3 min)
4. Verificar servicios registrados en Eureka (1 min)
5. Demostración de endpoints (5-7 min)
6. Observabilidad con Zipkin (2 min)
7. Cierre y conclusiones (1 min)

---

## ⏱️ SECCIÓN 1: INTRODUCCIÓN (1 minuto)

**Guion para leer:**

> "Hola, bienvenidos. Hoy voy a demostrar la arquitectura de un sistema de e-commerce implementado con **microservicios en Spring Boot y Spring Cloud**. Este proyecto fue desarrollado como parte de la asignatura 'Plataformas II' y demuestra patrones enterprise de desarrollo distribuido.
> 
> El sistema incluye:
> - **10 microservicios** independientes (usuarios, productos, pedidos, pagos, envíos, favoritos)
> - **Service Discovery** con Eureka para registro dinámico
> - **API Gateway** con Spring Cloud Gateway como punto de entrada único
> - **Configuración centralizada** con Spring Cloud Config
> - **Observabilidad completa** con Zipkin, Prometheus y Grafana
> - **Despliegue containerizado** con Docker y Kubernetes (Helm)
> 
> Hoy ejecutaremos todo en **GitHub Codespaces** usando **Docker Compose** para una demostración rápida y ligera. Sin necesidad de instalar Postman ni herramientas adicionales."

**Acciones:**
- Mostrar pantalla de GitHub Codespaces
- Mencionar que el repo está en `ecommerce-microservice-backend-app`

---

## ⏱️ SECCIÓN 2: EXPLORAR ESTRUCTURA (1.5 minutos)

**Guion para leer:**

> "Primero, déjame mostrar la estructura del repositorio. Tenemos:"

**Acciones:**
1. Abrir terminal en Codespaces
2. Listar estructura raíz:
   ```bash
   ls -la
   ```
   Mencionar:
   - `compose.yml` → orquestación rápida
   - `pom.xml` → proyecto Maven con 10 módulos
   - `k8s/` → configuración Kubernetes y Helm (alternativa enterprise)
   - `.github/workflows/` → CI/CD automático

3. Mostrar módulos de servicios:
   ```bash
   ls -la | grep -E "(service|gateway|discovery|config|proxy)"
   ```
   Leer:
   > "Como ves, tenemos:
   > - `service-discovery/` - Eureka para registro de servicios
   > - `cloud-config/` - Servidor de configuración centralizado
   > - `api-gateway/` - Gateway que ruteará todas las solicitudes
   > - `proxy-client/` - Autenticación y autorización
   > - 6 servicios de dominio: user, product, order, payment, shipping, favourite"

4. Mostrar archivo compose.yml (preview):
   ```bash
   head -30 compose.yml
   ```
   Mencionar:
   > "Como ves en compose.yml, cada servicio tiene su puerto mapeado:
   > - API Gateway: 8080
   > - User Service: 8700
   > - Product Service: 8500
   > - Eureka: 8761
   > - Zipkin (trazas): 9411"

---

## ⏱️ SECCIÓN 3: INICIAR SISTEMA (2-3 minutos)

**Guion para leer:**

> "Ahora vamos a levantar el sistema completo con Docker Compose. Esto descargará las imágenes de Docker Hub y levantará todos los servicios en paralelo."

**Acciones:**
1. Ejecutar comando de inicio:
   ```bash
   docker-compose -f compose.yml up -d
   ```
   **Tiempo**: ~1-2 minutos mientras descarga imágenes

   Mencionar en voz mientras espera:
   > "Docker está descargando las imágenes públicas de todos los servicios (api-gateway, user-service, product-service, etc.) desde Docker Hub. Esto incluye también Eureka, Config Server, Zipkin y otros componentes."

2. Después de que termine, verificar que todo está arriba:
   ```bash
   docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
   ```

   Leer resultado:
   > "Perfecto. Todos los contenedores están corriendo. Podemos ver:
   > - api-gateway-container corriendo en puerto 8080
   > - service-discovery-container en 8761 (Eureka)
   > - Los 8 servicios de dominio (user, product, order, payment, shipping, favourite, proxy-client, cloud-config)
   > - zipkin-container en 9411"

3. Esperar unos 10 segundos más:
   > "Déjame esperar un momento adicional a que todos los servicios terminen de iniciar y se registren con Eureka. Esto puede tomar 10-15 segundos en total."

---

## ⏱️ SECCIÓN 4: EUREKA SERVICE DISCOVERY (1 minuto)

**Guion para leer:**

> "Ahora vamos a ver el Service Discovery de Eureka. Este es el registro central donde todos los microservicios se registran automáticamente cuando inician."

**Acciones:**
1. Copiar la URL de Eureka:
   ```
   http://localhost:8761
   ```

2. Mencionar en voz:
   > "Si copias esta URL en tu navegador, verás la dashboard de Eureka con todos los servicios registrados. Los servicios se autoregistran cuando inician gracias a Spring Cloud Discovery."

3. *Opcional: mostrar en navegador si es posible, sino solo mencionar*

---

## ⏱️ SECCIÓN 5: DEMOSTRACIÓN DE ENDPOINTS (5-7 minutos)

**Guion para leer:**

> "Ahora vamos a probar los endpoints de la API a través del API Gateway. Todos los servicios están expuestos a través del gateway en el puerto 8080, con prefijos específicos para cada uno."

**Acciones:**

### 5.1 - Listar Productos
```bash
curl -s http://localhost:8080/product-service/api/products | jq .
```

Mientras se ejecuta, leer:
> "Este request va a través del API Gateway, que lo enruta automáticamente al Product Service. El Gateway hace load-balancing automático usando Eureka."

Cuando aparezca respuesta, mencionar:
> "Como ves, recibimos una lista de productos. Cada producto tiene id, nombre, descripción y categoría."

### 5.2 - Listar Usuarios
```bash
curl -s http://localhost:8080/user-service/api/users | jq .
```

Mencionar:
> "Mismo proceso: el gateway nos enruta al User Service. Aquí tenemos usuarios del sistema con sus datos de perfil."

### 5.3 - Buscar Usuario por Username
```bash
curl -s http://localhost:8080/user-service/api/users/username/john | jq .
```

> "También podemos hacer búsquedas específicas, como buscar un usuario por su username."

### 5.4 - Crear un Pedido (POST)
```bash
curl -s -X POST http://localhost:8080/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{"userId":1,"items":[{"productId":1,"quantity":2}]}' | jq .
```

Leer mientras se ejecuta:
> "Ahora vamos a crear un nuevo pedido. Estamos enviando un JSON con:
> - userId: 1 (el usuario que hace el pedido)
> - items: array con el producto y cantidad
> 
> El Order Service recibe esto, crea el pedido, y responde con el ID del pedido creado."

Si la respuesta es exitosa (201 o 200), mencionar:
> "Perfecto, el pedido fue creado exitosamente. El sistema asignó el ID y timestamp automáticamente."

### 5.5 - Listar todos los Pedidos
```bash
curl -s http://localhost:8080/order-service/api/orders | jq .
```

> "Ahora podemos ver todos los pedidos en el sistema. Incluye tanto los que estaban preexistentes como el que acabamos de crear."

### 5.6 - Listar Favoritos
```bash
curl -s http://localhost:8080/favourite-service/api/favourites | jq .
```

> "El Favourite Service mantiene los productos que los usuarios marcan como favoritos. Esto es importante para personalización."

### 5.7 - Listar Pagos
```bash
curl -s http://localhost:8080/payment-service/api/payments | jq .
```

> "El Payment Service gestiona todos los pagos. Puede integrar con gateways reales como Stripe o PayPal."

### 5.8 - Listar Envíos
```bash
curl -s http://localhost:8080/shipping-service/api/shippings | jq .
```

> "Y finalmente, el Shipping Service gestiona el envío de los pedidos, con seguimiento y estados."

**Resumen de la sección:**
> "Como ves, tenemos 6 servicios de dominio completamente independientes:
> - User Service (gestión de usuarios)
> - Product Service (catálogo)
> - Order Service (pedidos y carritos)
> - Payment Service (pagos)
> - Shipping Service (envíos)
> - Favourite Service (favoritos)
> 
> Todos se comunican a través del API Gateway, que se encarga del routing y load-balancing automático."

---

## ⏱️ SECCIÓN 6: OBSERVABILIDAD CON ZIPKIN (2 minutos)

**Guion para leer:**

> "Uno de los aspectos más importantes de los microservicios es la observabilidad. Con Zipkin podemos ver las trazas distribuidas de cada request."

**Acciones:**
1. Ejecutar un request para generar trazas:
   ```bash
   curl -s http://localhost:8080/product-service/api/products > /dev/null
   ```

   > "Acabamos de hacer un request. Ahora vamos a verlo en Zipkin para ver cómo viaja a través de los servicios."

2. Mencionar URL de Zipkin:
   ```
   http://localhost:9411
   ```

   > "Si abres Zipkin en el navegador, verás un timeline de todas las solicitudes. Puede ver cuánto tiempo tardó en cada servicio y dónde están los cuellos de botella."

3. *Opcional: mostrar en navegador si es posible*

---

## ⏱️ SECCIÓN 7: INFORMACIÓN TÉCNICA Y ARQUITECTURA (2 minutos)

**Guion para leer:**

> "Ahora déjame explicar la arquitectura técnica detrás de lo que acabamos de ver."

**Mostrar información:**
1. Tecnologías utilizadas:
   ```bash
   cat pom.xml | grep -A2 "<parent>" | head -5
   ```

   > "Este es un proyecto Maven multi-módulo basado en Spring Boot 2.5.x y Spring Cloud 2020.x"

2. Java version:
   ```bash
   cat system.properties
   ```

   > "Usamos Java 11, que es LTS (Long Term Support) y muy estable para producción."

3. Mencionar características:
   > "Internamente, el sistema implementa:
   > - **Circuit Breaker** con Resilience4j (manejo de fallos)
   > - **Distributed Tracing** con Sleuth + Zipkin
   > - **Health Checks** con Spring Boot Actuator
   > - **Configuración externalizada** con Spring Cloud Config
   > - **Service Registry** con Eureka
   > - **API Gateway** con Spring Cloud Gateway
   > 
   > Todo esto hace que el sistema sea resiliente, observable y fácil de mantener a escala."

---

## ⏱️ SECCIÓN 8: PARAR EL SISTEMA (1 minuto)

**Guion para leer:**

> "Finalmente, vamos a parar el sistema de forma limpia."

**Acciones:**
```bash
docker-compose -f compose.yml down --remove-orphans
```

Mencionar:
> "Docker Compose está deteniendo todos los contenedores y eliminando la red. Esto es importante para limpiar recursos cuando terminas de trabajar."

Mientras se ejecuta:
> "Esta arquitectura es escalable. En producción, en lugar de Docker Compose, usaríamos Kubernetes con Helm (tenemos los manifests en la carpeta k8s/ del repositorio)."

---

## ⏱️ SECCIÓN 9: CIERRE Y CONCLUSIONES (1-2 minutos)

**Guion para leer:**

> "En resumen, hoy hemos visto:
> 
> ✅ **Despliegue rápido** de 10 microservicios con Docker Compose (menos de 3 minutos)
> ✅ **Service Discovery automático** con Eureka
> ✅ **API Gateway centralizado** que enruta todas las solicitudes
> ✅ **6 servicios de dominio** independientes (usuarios, productos, pedidos, pagos, envíos, favoritos)
> ✅ **Observabilidad** con Zipkin, incluyendo trazas distribuidas
> ✅ **Resiliencia** con Circuit Breaker y Health Checks
> 
> Este proyecto demuestra patrones profesionales de arquitectura de microservicios que se usan en empresas como Netflix, Airbnb y Amazon. 
> 
> El código está en GitHub y es completamente open-source. En el repositorio también encontrarás:
> - Configuración Kubernetes (k8s/) para desplegar en producción
> - Scripts de automatización para CI/CD
> - Documentación detallada de cada componente
> 
> Gracias por ver la demostración."

---

## 💡 TIPS PARA LA GRABACIÓN

1. **Timing**: Asegúrate de que Docker esté iniciado antes de grabar (puede tomar 1-2 min en la primera ejecución).
2. **Copiar/Pegar requests**: Los comandos curl están listos en `demo-requests.sh`. Puedes copiarlos directamente.
3. **Pausas naturales**: No hables constantemente. Deja espacios para que los usuarios procesen la información.
4. **Errores**: Si algún endpoint devuelve error, menciona que podría ser porque los servicios todavía se están inicializando (tarda ~15-30 segundos).
5. **Navegadores**: Para Zipkin y Eureka, si usas `xdg-open` o `open` funcionará en la mayoría de sistemas.

---

## 🎯 PUNTOS CLAVE A RESALTAR

- **Rapidez**: Todo el sistema levantó en menos de 3 minutos
- **Independencia**: Cada servicio es totalmente independiente
- **Descubrimiento automático**: Los servicios se encuentran automáticamente
- **Escalabilidad**: Puede crecer sin cambiar la arquitectura
- **Observabilidad**: Tenemos visibilidad completa en trazas distribuidas
- **Resiliencia**: Implementa patrones como Circuit Breaker
- **Enterprise-ready**: Listo para producción con Kubernetes

---

## ⚠️ POSIBLES PREGUNTAS (ANTICIPAR)

**P: ¿Por qué microservicios y no una aplicación monolítica?**
R: Los microservicios permiten:
- Equipos independientes trabajar en paralelo
- Despliegues más rápidos (cada servicio por separado)
- Escalado selectivo (solo crece lo que necesita)
- Resiliencia (si cae un servicio, los otros siguen funcionando)

**P: ¿Cómo se comunican los servicios?**
R: HTTP/REST a través del API Gateway o directamente entre servicios (después de discoveryvia Eureka).

**P: ¿Qué pasa si un servicio cae?**
R: El Circuit Breaker automáticamente devuelve una respuesta degradada o usa un fallback. Eureka detecta que no está disponible y deja de rutear solicitudes.

**P: ¿Cómo se ve esto en producción?**
R: En producción usaríamos Kubernetes (tenemos manifests en k8s/). Automáticamente crearía replicas de cada servicio, haría health-checks, reinicios automáticos, etc.

---

**TIEMPO TOTAL ESPERADO**: 15-20 minutos
**Archivo de requests**: Ver `demo-requests.sh` en el repositorio
**Información adicional**: Ver `README.md` para instrucciones detalladas
