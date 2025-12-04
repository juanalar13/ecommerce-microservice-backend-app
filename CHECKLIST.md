# ✅ CHECKLIST DE VERIFICACIÓN - DEMO EN VIVO

**Usa este checklist antes de grabar para asegurarte que todo funciona.**

---

## 🔍 VERIFICACIÓN PRE-GRABACIÓN

### Paso 1: Entorno
- [ ] Estoy en `/workspaces/ecommerce-microservice-backend-app`
- [ ] He ejecutado `git status` y no hay cambios no commitidos
- [ ] Terminal tiene zoom 150%+ (legible)
- [ ] Micrófono y cámara funcionan
- [ ] OBS Studio o grabador abierto y configurado

### Paso 2: Docker disponible
```bash
docker --version
docker-compose --version
```
- [ ] Ambos comandos responden (no "command not found")

### Paso 3: Levantamiento rápido
```bash
bash QUICKSTART.sh
```
- [ ] Descarga imágenes sin errores
- [ ] Todos los contenedores inician
- [ ] API Gateway responde en ~2-3 min

### Paso 4: Verificar servicios
```bash
docker ps --format "table {{.Names}}\t{{.Status}}"
```
- [ ] Al menos 11 contenedores listados
- [ ] Todos con status "Up X seconds"
- [ ] Sin "Exited" o "Dead"

### Paso 5: Primera prueba de request
```bash
curl -s http://localhost:8080/product-service/api/products | jq . | head -20
```
- [ ] Recibe respuesta JSON válida
- [ ] Sin errores "Connection refused"

### Paso 6: Script de demo funciona
```bash
bash demo-requests.sh curl | head -20
```
- [ ] Muestra lista de comandos curl
- [ ] Sin errores de sintaxis

### Paso 7: Observabilidad accesible
```bash
# Abrir en navegador:
# http://localhost:8761  (Eureka)
# http://localhost:9411  (Zipkin)
```
- [ ] Ambas URLs cargan sin error
- [ ] Eureka muestra servicios registrados

---

## ⏱️ TIMING VERIFICACIÓN

Ejecuta esto y anota los tiempos:

```bash
time bash QUICKSTART.sh
```

- [ ] `up -d`: < 5 segundos
- [ ] Descarga imágenes: 1-2 minutos (primera vez)
- [ ] Servicios listos: ~15-30 segundos
- [ ] **Total**: < 3 minutos

Si toma más:
- Verifica conexión a internet
- Limpia: `docker system prune -a`
- Reinicia Docker

---

## 🎬 DURANTE LA GRABACIÓN

### Parte 1: Introducción
- [ ] Pantalla clara, legible
- [ ] Micrófono recibe audio claro
- [ ] Leo guion natural (sin robotizado)

### Parte 2: Levantamiento
- [ ] Ejecuto `docker-compose up -d` en tiempo real
- [ ] Hablo mientras Docker descarga (esto toma tiempo)
- [ ] No me quedo en silencio > 5 segundos

### Parte 3: Verificación
- [ ] Ejecuto `docker ps` y comento resultados
- [ ] Todos los contenedores están "Up"

### Parte 4: Demo requests
- [ ] Ejecuto `bash demo-requests.sh`
- [ ] Leo y comento respuestas importantes
- [ ] Hago énfasis en:
  - Productos listados
  - Usuarios registrados
  - **Crear nuevo pedido (POST)** ← Punto más importante
  - Listado de pedidos (ver el que creé)

### Parte 5: Explicación arquitectura
- [ ] Menciono: Eureka, API Gateway, Circuit Breaker
- [ ] Hablo sobre Service Discovery
- [ ] Explico por qué microservicios > monolito

### Parte 6: Cierre
- [ ] Agradezco a viewers
- [ ] Doy info del repo (GitHub link)
- [ ] Invito a clonar y probar
- [ ] Menciono alternativas (Kubernetes)

---

## 🐛 TROUBLESHOOTING DURANTE GRABACIÓN

### Si algo falla:

**Opción A: Continuar (mejor para video)**
- Comenta que ocurrió un error temporal
- Prueba el comando nuevamente
- "Esto es lo que pasa en desarrollo — a veces hay delays"

**Opción B: Cortar y reintentar**
- Pausa la grabación
- Resuelve el problema
- Reanuda en el mismo punto

**Problemas comunes:**

**Problema: "Connection refused"**
```bash
# Restart service
docker-compose restart api-gateway
```

**Problema: Request devuelve error 500**
```bash
# Ver logs
docker logs <service-name>
# Esperar más tiempo (servicios aún iniciando)
sleep 10
```

**Problema: Imagen no encuentra**
```bash
docker-compose pull
docker-compose up -d
```

---

## ✨ VERIFICACIÓN POST-GRABACIÓN

### Video grabado:
- [ ] Audio claro, sin ruido
- [ ] Video legible (texto distinguible)
- [ ] No hay cortes ni pixelación
- [ ] Duración: 15-20 minutos (ideal)
- [ ] Archivo exportado correctamente (MP4, H.264)

### Contenido técnico:
- [ ] Todos los servicios se iniciaron
- [ ] Todos los requests funcionaron
- [ ] Explicaciones fueron claras
- [ ] Timing natural (no demasiado rápido)

### Antes de subir a YouTube:
- [ ] Probé reproducción del video
- [ ] Audio sincronizado con video
- [ ] Sin información sensible expuesta
- [ ] Incluir links del repo en descripción

---

## 💾 ANTES DE GUARDAR VIDEO

```bash
# Hacer cleanup (opcional)
docker-compose -f compose.yml down --remove-orphans

# Listar espacio usado
du -sh ~/.docker/containers/

# Si quieres liberar espacio (borra TODO)
docker system prune -a  # Cuidado: borra todo
```

---

## 📋 CHECKLIST FINAL

Marca todo esto antes de considerar la grabación completa:

```
ENTORNO:
- [ ] Repositorio clonado
- [ ] Docker funcionando
- [ ] Terminal legible
- [ ] Micrófono/cámara OK

TÉCNICO:
- [ ] QUICKSTART.sh ejecuta sin errores
- [ ] demo-requests.sh muestra comandos
- [ ] Todos los servicios se inician
- [ ] Eureka y Zipkin accesibles

GRABACIÓN:
- [ ] SCRIPT.md leído y entendido
- [ ] PRESENTACIÓN.md timeline seguido
- [ ] Video grabado completo
- [ ] Audio sin ruido
- [ ] Contenido técnico correcto

POST-GRABACIÓN:
- [ ] Video reproducible
- [ ] MP4 exportado
- [ ] Metadata (título, descripción, tags)
- [ ] Listo para subir
```

---

## 🎉 SI TODO PASA

¡Estás listo para:
1. Exportar el video final
2. Subir a YouTube/Drive
3. Compartir con profesor
4. ¡Célébrate! 🎬

---

**Tiempo total esperado**: 
- Verificación: ~5 min
- Grabación: ~20 min
- Post-procesamiento: ~10 min
- **Total: ~35-45 min**

**¡Buena suerte! 🚀**
