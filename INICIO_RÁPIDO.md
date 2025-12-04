# ⚡ INICIO RÁPIDO (One-Pager)

**¿Necesitas grabar tu video en 40 minutos? Lee esto primero.**

---

## 🎯 OBJETIVO
Grabar presentación de 15-20 minutos demostrando 10 microservicios en GitHub Codespaces, sin Postman, sin configuración compleja.

---

## 📋 3 PASOS PRINCIPALES

### 1️⃣ LEE ESTO PRIMERO (10 min)
```bash
cat PRESENTACIÓN.md
```
- ✅ Timeline paso-a-paso
- ✅ Checklist pre-grabación
- ✅ Qué problemas pueden ocurrir

### 2️⃣ LEVANTA EL SISTEMA (3 min)
```bash
bash QUICKSTART.sh
```
- ✅ Verifica Docker
- ✅ Descarga imágenes
- ✅ Inicia 11 contenedores
- ✅ Espera a que estén listos

### 3️⃣ GRABA TU VIDEO (20 min)
```bash
# Terminal 1: Lee el guion
cat SCRIPT.md

# Terminal 2: Ejecuta demostraciones
bash demo-requests.sh
```
- ✅ Sigue SCRIPT.md mientras grabas
- ✅ Ejecuta comandos
- ✅ Interpreta resultados

---

## ⏱️ TIMING TOTAL

| Paso | Tiempo |
|------|--------|
| Leer PRESENTACIÓN.md | 10 min |
| QUICKSTART.sh | 3 min |
| Grabar video | 20 min |
| Post-producción | 10 min |
| **TOTAL** | **~45 min** |

---

## 🚀 COMANDOS CLAVE

```bash
# 1. Entrar a la carpeta
cd /workspaces/ecommerce-microservice-backend-app

# 2. Levantar todo
bash QUICKSTART.sh

# 3. Ver URLs disponibles
echo "API Gateway: http://localhost:8080"
echo "Eureka: http://localhost:8761"
echo "Zipkin: http://localhost:9411"

# 4. Probar endpoint (en otra terminal)
curl -s http://localhost:8080/product-service/api/products | jq .

# 5. Ejecutar demo completa
bash demo-requests.sh

# 6. Limpiar cuando termines
docker-compose -f compose.yml down
```

---

## 📚 ARCHIVOS IMPORTANTES

| Archivo | Propósito | Lee primero |
|---------|-----------|------------|
| **PRESENTACIÓN.md** | Timeline y checklist | ✅ SÍ |
| **SCRIPT.md** | Guion a leer | ✅ SÍ (mientras grabas) |
| **demo-requests.sh** | Requests curl | ✅ SÍ (durante demo) |
| README.md | Referencia técnica | ✓ Si necesitas |
| ÍNDICE.md | Mapa completo | ✓ Si necesitas |

---

## ✅ CHECKLIST PRE-GRABACIÓN RÁPIDO

```bash
# Ejecuta esto primero
docker ps                    # ✅ Docker corriendo?
docker-compose --version     # ✅ Compose disponible?
bash QUICKSTART.sh           # ✅ Sistema levanta?
curl -s http://localhost:8080/health  # ✅ Gateway responde?
```

Si todo muestra ✅, estás listo.

---

## 🎬 ESTRUCTURA DEL VIDEO

| Tiempo | Qué hacer |
|--------|-----------|
| 0:00-1:00 | Intro (leer SCRIPT.md sección 1) |
| 1:00-3:30 | Levantamiento (docker-compose up) |
| 3:30-4:30 | Verificación (docker ps) |
| 4:30-5:00 | Explicación conceptos |
| 5:00-11:00 | Ejecutar `bash demo-requests.sh` |
| 11:00-13:00 | Explicar arquitectura |
| 13:00-14:00 | Producción/Kubernetes |
| 14:00-15:00 | Cierre |

---

## 💡 TIPS IMPORTANTES

1. **No apresures**: Habla claro, deja pausas
2. **Mientras Docker descarga (1-2 min)**: Habla sobre arquitectura, no te quedes en silencio
3. **Endpoint importante**: Cuando crees un pedido (POST), explica qué está ocurriendo
4. **Si algo falla**: Intenta de nuevo o continúa con otro endpoint
5. **Zoomea la terminal**: 150%+ para que se vea bien
6. **Graba en 1080p 30fps**: Calidad estándar YouTube

---

## 🆘 SI ALGO NO FUNCIONA

```bash
# Reinicia todo
docker-compose down
docker-compose up -d
bash QUICKSTART.sh

# O limpia completo
docker system prune -a
docker-compose up -d
```

Ver **CHECKLIST.md** para más troubleshooting.

---

## 📍 URLs DURANTE GRABACIÓN

| Componente | URL |
|-----------|-----|
| API Gateway | http://localhost:8080 |
| Service Discovery | http://localhost:8761 |
| Tracing | http://localhost:9411 |

---

## 🎉 DESPUÉS DE GRABAR

1. Export video MP4
2. Upload a YouTube/Drive
3. Compartir con profesor
4. ¡Celebra! 🏆

---

## 📞 REFERENCIAS

- **PRESENTACIÓN.md** → Timeline detallado
- **SCRIPT.md** → Guion completo
- **CHECKLIST.md** → Troubleshooting
- **README.md** → Referencia técnica
- **ÍNDICE.md** → Mapa de todo

---

## ✨ LO MÁS IMPORTANTE

- ✅ Servicios están listos (Docker Compose)
- ✅ No necesitas Postman (curl + bash script)
- ✅ No necesitas Kubernetes para demo (solo Docker)
- ✅ Todo automatizado (QUICKSTART.sh)
- ✅ Guion completo (SCRIPT.md)
- ✅ Ejemplos listos (demo-requests.sh)

**¿Listo? Ejecuta esto ahora:**

```bash
bash QUICKSTART.sh
```

**Luego sigue PRESENTACIÓN.md**

---

**¡Buena suerte! 🎬**
