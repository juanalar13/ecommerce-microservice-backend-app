# 🎬 GUION DE PRESENTACIÓN EN VIDEO

**Duración**: 15-20 minutos  
**Entorno**: GitHub Codespaces  
**Demostración**: 10 microservicios con Docker Compose

Lee este guion en voz alta mientras grabas el video.

---

## ⏱️ MINUTO 0:00-1:00 - INTRODUCCIÓN

**Lee esto en voz alta:**

> "Hola, bienvenidos. Hoy les voy a mostrar una arquitectura de **microservicios en Spring Boot**, desarrollada como parte de Plataformas II.
>
> Este sistema demuestra cómo construir aplicaciones distribuidas escalables con 10 microservicios independientes:
> - Servicio de Usuarios
> - Servicio de Productos
> - Servicio de Pedidos
> - Servicio de Pagos
> - Servicio de Envíos
> - Servicio de Favoritos
> 
> Además de componentes enterprise como:
> - Service Discovery automático con Eureka
> - API Gateway centralizado
> - Trazas distribuidas con Zipkin
> - Configuración centralizada
>
> Vamos a demostrar todo esto en GitHub Codespaces usando Docker Compose, que nos permite levantar el sistema completo en minutos. ¡Comencemos!"

**Acciones en pantalla:**
- Mostrar la carpeta del proyecto
- Mostrar que estás en `/workspaces/ecommerce-microservice-backend-app`

---

## ⏱️ MINUTO 1:00-2:00 - ESTRUCTURA DEL PROYECTO

**Lee esto en voz alta:**

> "Primero, déjame mostrar la estructura del proyecto. Tenemos una carpeta raíz con todos los microservicios organizados por módulos."

**Acciones en pantalla:**
```bash
ls -la
```

**Muestra y explica:**
- `compose.yml` - Archivo de Docker Compose que define todos los servicios
- Carpetas de cada servicio (user-service, product-service, etc.)
- `k8s/` - Configuración de Kubernetes para producción

**Sigue leyendo:**

> "Aquí podemos ver todos los componentes. El archivo `compose.yml` es nuestro punto de entrada, que orquesta todos los 10 microservicios con una sola línea de comando. Veamos el contenido:"

```bash
cat compose.yml | head -50
```

**Explica:**

> "Vemos que Docker Compose define cada servicio con su imagen Docker (todas públicamente disponibles en Docker Hub), sus puertos, y las variables de entorno. Esto es lo que hace posible levantar el sistema completo sin instalar nada localmente."

---

## ⏱️ MINUTO 2:00-4:00 - LEVANTAR EL SISTEMA

**Lee esto en voz alta:**

> "Ahora vamos a levantar todo el sistema. Solo necesitamos una línea de comando:"

**Acciones en pantalla:**
```bash
docker-compose -f compose.yml up -d
```

**Mientras se ejecuta, sigue leyendo:**

> "Docker Compose está:
> 1. Descargando las imágenes del repositorio público (selimhorri)
> 2. Creando contenedores para cada servicio
> 3. Levantando todos en paralelo
> 4. Registrando automáticamente cada uno con Eureka
>
> Esto toma típicamente 2-3 minutos la primera vez que ejecutas el comando. Las imágenes se cachean localmente, así que ejecuciones posteriores son más rápidas.
>
> Mientras espera, déjame explicar la arquitectura..."

**Explica mientras espera:**

> "En una arquitectura de microservicios tradicional, tenemos un monolito que hace todo. Aquí, en cambio, descomponemos la funcionalidad en servicios independientes:
>
> - **User Service**: Maneja usuarios y autenticación
> - **Product Service**: Catálogo de productos
> - **Order Service**: Creación y gestión de pedidos
> - **Payment Service**: Procesamiento de pagos
> - **Shipping Service**: Gestión de envíos
> - **Favourite Service**: Productos favoritos del usuario
>
> Todos estos servicios se comunican entre sí a través de REST HTTP, orquestados por el **API Gateway** en el puerto 8080.
>
> El **Service Discovery (Eureka)** automáticamente registra cada servicio cuando inicia. Esto significa que no necesitamos configurar URLs hardcodeadas - los servicios se descubren automáticamente."

**Después de 2-3 minutos, verifica:**

```bash
docker ps | grep ecommerce
```

**Explica:**

> "Perfecto. Puedo ver que todos los 10 microservicios están corriendo (estado 'Up'). Además tenemos:
> - Eureka en puerto 8761
> - Zipkin en puerto 9411 para trazas distribuidas
> - API Gateway en puerto 8080"

---

## ⏱️ MINUTO 4:00-5:00 - VERIFICACIÓN

**Lee esto en voz alta:**

> "Ahora vamos a verificar que el API Gateway está respondiendo:"

**Acciones en pantalla:**
```bash
curl -s http://localhost:8080/health | jq .
```

**Explica mientras aparece la respuesta:**

> "Excelente. El API Gateway está respondiendo con estado 'UP', lo que significa que todos los servicios se inicializaron correctamente y están siendo monitoreados por el gateway.
>
> Veremos que además del status principal, hay información detallada de cada servicio downstream. Esto es importante porque muestra que el Gateway puede ver todos los servicios registrados en Eureka."

---

## ⏱️ MINUTO 5:00-6:00 - COMPONENTES ENTERPRISE

**Lee esto en voz alta:**

> "Ahora vamos a explorar los componentes enterprise del sistema. Primero, Service Discovery:"

**Acciones en pantalla:**
```bash
curl -s http://localhost:8761/eureka/apps | head -50
```

**Explica:**

> "Aquí estamos llamando a Eureka directamente. Este endpoint nos devuelve TODOS los servicios registrados en la infraestructura. Si abrimos http://localhost:8761 en el navegador, veríamos un dashboard visual donde podemos ver:
> - Qué servicios están registrados
> - Su estado actual (UP, DOWN, etc.)
> - Instancias por servicio
>
> Esto es crucial en un sistema distribuido porque:
> 1. Los servicios se auto-registran cuando inician
> 2. Si un servicio se cae, Eureka automáticamente lo marca como DOWN
> 3. El API Gateway usa esta información para enrutamiento inteligente
>
> Es una alternativa moderna a tener que mantener un archivo de configuración de URLs que se actualiza manualmente."

---

## ⏱️ MINUTO 6:00-8:00 - DEMOSTRACIÓN DE PRODUCTOS

**Lee esto en voz alta:**

> "Ahora vamos a la parte más interesante: demostración en vivo de los endpoints. Todos pasan por el API Gateway, que los enruta automáticamente al servicio correcto.
>
> Comencemos con el Servicio de Productos:"

**Acciones en pantalla:**
```bash
curl -s http://localhost:8080/product-service/api/products | jq .
```

**Explica mientras aparecen los resultados:**

> "Hermoso. Obtenemos una lista de todos los productos. Cada uno tiene:
> - ID único
> - Nombre
> - Descripción
> - Categoría
> - Precio
>
> Este request fue procesado así:
> 1. Client → API Gateway (8080)
> 2. Gateway → Service Discovery (Eureka) - ¿Dónde está product-service?
> 3. Gateway → Product Service (8500)
> 4. Response vuelve al client
>
> Obtener una producto específico:"

```bash
curl -s http://localhost:8080/product-service/api/products/1 | jq .
```

**Explica:**

> "Aquí vemos los detalles de un solo producto. Same pattern - el Gateway enruta automáticamente al Product Service y devuelve un producto específico."

---

## ⏱️ MINUTO 8:00-10:00 - DEMOSTRACIÓN DE USUARIOS Y PEDIDOS

**Lee esto en voz alta:**

> "Ahora veamos el Servicio de Usuarios:"

**Acciones en pantalla:**
```bash
curl -s http://localhost:8080/user-service/api/users | jq . | head -20
```

**Explica:**

> "Aquí están todos los usuarios del sistema. Podemos listar usuarios, obtener uno específico, buscar por username, etc."

**Búsqueda por username:**
```bash
curl -s http://localhost:8080/user-service/api/users/username/john | jq .
```

**Explica:**

> "El User Service soporta búsqueda por username. Esto demuestra que cada servicio expone su propia API específica, pero toda está centralizada en el Gateway.
>
> Ahora vamos al Servicio de Pedidos. Aquí es donde vamos a ver la magia de los microservicios - comunicación entre servicios:"

```bash
curl -s http://localhost:8080/order-service/api/orders | jq . | head -20
```

**Explica:**

> "Aquí están todos los pedidos. Cada pedido referencia un usuario y múltiples productos. Este es un ejemplo perfecto de cómo los microservicios se comunican entre sí."

---

## ⏱️ MINUTO 10:00-12:00 - CREAR UN PEDIDO (MOSTRAR INTER-SERVICIO)

**Lee esto en voz alta:**

> "Ahora viene la demostración más importante: vamos a CREAR un nuevo pedido. Esto va a demostrar la comunicación entre servicios en acción:"

**Acciones en pantalla:**
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

**Explica mientras se ejecuta:**

> "Esto es lo que está pasando behind the scenes:
> 1. Enviamos un request POST al Order Service
> 2. Order Service valida que el usuario existe (llama a User Service)
> 3. Order Service valida que los productos existen (llama a Product Service)
> 4. Si ambas validaciones pasan, Order Service crea el pedido
> 5. El sistema devuelve el pedido creado con ID único
>
> Esto es lo que hace especiales los microservicios: cada servicio es independiente, pero se comunican cuando es necesario. Si Product Service se cae, el sistema podría:
> - Usar un Circuit Breaker para detectar el fallo
> - Usar un cache para servir datos antiguos
> - Reintentar automáticamente
> - O fallar de forma controlada sin derribar el sistema completo"

---

## ⏱️ MINUTO 12:00-13:00 - DEMOSTRACIÓN DE PAGOS Y ENVÍOS

**Lee esto en voz alta:**

> "Continuemos con Payment Service y Shipping Service:"

**Acciones en pantalla:**
```bash
curl -s http://localhost:8080/payment-service/api/payments | jq . | head -20
curl -s http://localhost:8080/shipping-service/api/shippings | jq . | head -20
```

**Explica:**

> "Aquí vemos los pagos procesados y los envíos registrados. Cada uno de estos servicios podría estar:
> - En servidores diferentes
> - Escalados independientemente
> - Desarrollados por equipos diferentes
> - Desplegados sin afectar otros servicios
>
> Esta es la verdadera ventaja de los microservicios: independencia y escalabilidad."

---

## ⏱️ MINUTO 13:00-14:00 - OBSERVABILIDAD CON ZIPKIN

**Lee esto en voz alta:**

> "Ahora veamos uno de los componentes más importantes: Observabilidad. En un sistema distribuido, es muy difícil rastrear un request que pasa por múltiples servicios. Para eso usamos Zipkin:"

**Acciones en pantalla:**
```bash
echo "Abriendo Zipkin en http://localhost:9411"
```

**Explica (sin abrir el navegador es necesario):**

> "Zipkin usa Spring Cloud Sleuth para rastrear cada request. Cada request tiene un ID único que lo sigue a través de todos los servicios:
>
> Client → API Gateway → Product Service → Response
>
> Todo con un ID único. Zipkin recolecta todos estos traces y los visualiza. Puedes ver:
> - Duración total del request
> - Cuánto tiempo pasó en cada servicio
> - Dónde están los cuellos de botella
> - Si hubo errores
>
> En una arquitectura monolítica, esto es trivial. En microservicios distribuidos es crítico, y Zipkin lo hace posible."

---

## ⏱️ MINUTO 14:00-15:00 - ALTERNATIVA: KUBERNETES

**Lee esto en voz alta:**

> "Esto que vemos es Docker Compose, que es perfecto para desarrollo y demos. Para producción, usaríamos Kubernetes.
>
> En el directorio `k8s/` tenemos toda la configuración de Kubernetes lista, incluyendo:
> - Helm charts para automatizar despliegues
> - Configuración de namespaces
> - Políticas de red
> - Configuración de persistencia
> - Monitoreo con Prometheus y Grafana
>
> Con Kubernetes, obtenemos:
> - Auto-escalado de servicios
> - Self-healing (reinicio automático de servicios caídos)
> - Load balancing automático
> - Actualizaciones sin downtime
> - Rollbacks automáticos en caso de error
>
> Pero para esta demostración, Docker Compose es suficiente."

---

## ⏱️ MINUTO 15:00-16:00 - PATRONES IMPLEMENTADOS

**Lee esto en voz alta:**

> "Este proyecto implementa varios patrones enterprise importantes:
>
> 1. **Microservicios**: Descomposición en servicios independientes
> 2. **Service Discovery**: Eureka auto-descubre servicios sin configuración manual
> 3. **API Gateway**: Punto de entrada único, enrutamiento centralizado
> 4. **Circuit Breaker**: Resilience4j protege contra fallos en cascada
> 5. **Distributed Tracing**: Zipkin rastrea requests a través de servicios
> 6. **Config Server**: Configuración centralizada sin redesplegar
> 7. **Docker & Docker Compose**: Containerización consistente
> 8. **Kubernetes ready**: También funciona con Kubernetes
>
> Estos patrones son estándar en la industria y se ven en sistemas como Netflix, Amazon, Google, etc."

---

## ⏱️ MINUTO 16:00-17:00 - VENTAJAS DEL ENFOQUE

**Lee esto en voz alta:**

> "¿Por qué microservicios en lugar de un monolito?
>
> **Independencia**: Cada equipo desarrolla su servicio sin interferir con otros.
> **Escalabilidad**: Puedes escalar solo el servicio que lo necesita.
> **Resiliencia**: Si un servicio falla, el resto sigue funcionando.
> **Tecnología**: Cada equipo puede elegir su propia tech stack.
> **Deploy**: Cambios en un servicio no afectan otros.
> **Testing**: Cada servicio es pequeño, más fácil de testear.
>
> Las desventajas:
> **Complejidad**: Más componentes que monitorear.
> **Latencia**: Network calls vs function calls in-process.
> **Consistencia**: Transacciones distribuidas son complicadas.
>
> Por eso los microservicios no son la mejor solución para todo. Pero para sistemas grandes, distribuidos y en evolución, son imprescindibles."

---

## ⏱️ MINUTO 17:00-18:00 - TECNOLOGÍA USADA

**Lee esto en voz alta:**

> "Este proyecto usa tecnología moderna:
>
> - **Spring Boot 2.5.7**: El framework Java más popular
> - **Spring Cloud 2020.0.4**: Herramientas para microservicios
> - **Spring Cloud Gateway**: API Gateway inteligente
> - **Eureka**: Service Discovery de Netflix
> - **Resilience4j**: Circuit Breaker moderno
> - **Zipkin + Sleuth**: Distributed tracing
> - **Docker & Docker Compose**: Containerización
> - **Kubernetes + Helm**: Orquestación enterprise
>
> Todas son tecnologías probadas en producción por las empresas más grandes del mundo."

---

## ⏱️ MINUTO 18:00-19:00 - DEMOSTRACIÓN DE LIMPIEZA

**Lee esto en voz alta:**

> "Para terminar, vamos a ver cómo limpiar todo:"

**Acciones en pantalla:**
```bash
docker-compose -f compose.yml down
```

**Explica:**

> "Con un solo comando, Docker Compose:
> - Detiene todos los 10 microservicios
> - Los apaga gracefully (da tiempo para shutdown)
> - Limpia los contenedores
>
> Si queremos liberar espacio de disco:"

```bash
docker system prune -a
```

**Explica:**

> "Esto elimina todas las imágenes locales. La próxima vez que ejecutes `docker-compose up -d`, se descargarán nuevamente de Docker Hub.
>
> Esto demuestra la portabilidad de Docker: puedes ejecutar esto en cualquier máquina (laptop, Codespaces, EC2, etc.) y obtendrás el mismo resultado."

---

## ⏱️ MINUTO 19:00-20:00 - CONCLUSIÓN

**Lee esto en voz alta:**

> "Para resumir lo que vimos hoy:
>
> ✅ Arquitectura de 10 microservicios independientes
> ✅ Service Discovery automático con Eureka
> ✅ API Gateway centralizado
> ✅ Comunicación entre servicios
> ✅ Observabilidad con Zipkin
> ✅ Containerización con Docker
> ✅ Deployable a Kubernetes
>
> Este proyecto demuestra que los microservicios no son complicados en teoría. Con las herramientas correctas (Spring Cloud, Docker, Kubernetes), implementarlos es accesible.
>
> Si quieren clonar este proyecto y experimentar:
> - El repositorio completo está en GitHub
> - Todo está documentado
> - Solo necesitan Docker y Docker Compose
> - Pueden hacerlo en Codespaces como hemos hecho hoy
>
> Gracias por ver. ¡Cualquier pregunta?"

---

## 📊 COMANDOS RÁPIDOS PARA COPIAR

```bash
# Levantar sistema
docker-compose -f compose.yml up -d

# Ver estado
docker ps

# Verificar health
curl -s http://localhost:8080/health | jq .

# Productos
curl -s http://localhost:8080/product-service/api/products | jq .

# Usuarios
curl -s http://localhost:8080/user-service/api/users | jq .

# Crear pedido
curl -s -X POST http://localhost:8080/order-service/api/orders \
  -H 'Content-Type: application/json' \
  -d '{"userId": 1, "items": [{"productId": 1, "quantity": 2}]}' | jq .

# Eureka
curl -s http://localhost:8761/eureka/apps | jq .

# Limpiar
docker-compose -f compose.yml down
```

---

**¡Listo para grabar! 🎬**
