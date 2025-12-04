# ⚡ INSTRUCCIONES FINALES - GRABAR VIDEO

**Lee esto primero, luego sigue paso a paso**

---

## 🎯 OBJETIVO

Grabar video de presentación de **15-20 minutos** demostrando:
- 10 microservicios independientes
- Service Discovery automático
- API Gateway centralizado
- Inter-service communication
- Observabilidad

---

## ✅ CHECKLIST PRE-GRABACIÓN

- [ ] Docker instalado
- [ ] Docker Compose disponible
- [ ] Terminal a 150%+ de zoom (legible)
- [ ] Micrófono funcionando
- [ ] OBS Studio o grabador abierto
- [ ] Espacio en disco (mín 2GB)

---

## 🚀 EJECUCIÓN (Paso-a-Paso)

### PASO 1: Levanta el sistema (3 minutos)

Abre terminal y ejecuta:

```bash
docker-compose -f compose.yml up -d
```

**Qué verás**: Docker descargando imágenes y levantando 11 contenedores.

**Mientras espera**: Prepara pantalla, zoom terminal, abre OBS.

**Cuándo continuar**: Espera a que veas todos los "Up" en `docker ps`.

---

### PASO 2: Verifica que funciona (30 segundos)

```bash
curl -s http://localhost:8080/health | jq .
```

**Qué verás**: `{"status":"UP"}` - Sistema listo.

**Si no funciona**: Espera 30 segundos más y reinenta.

---

### PASO 3: Presiona REC en OBS

**Empezar grabación**.

---

### PASO 4: Lee el GUION.md (15-20 minutos)

Abre el guion:

```bash
cat GUION.md
```

O ábrelo en editor de texto para poder scrollear mejor.

**Instrucciones en GUION.md**:
- Minuto 0:00-1:00: Lee introducción
- Minuto 1:00-2:00: Muestra estructura (`ls -la`)
- Minuto 2:00-4:00: Muestra `docker ps`
- Minuto 5:00-6:00: Verifica Eureka
- Minuto 6:00-15:00: Ejecuta demo
- Minuto 15:00-20:00: Explicación y cierre

---

### PASO 5: Ejecuta la demostración en vivo (minuto 6:00 del video)

Cuando el GUION.md te indique (aproximadamente minuto 6:00):

```bash
bash demo-commands.sh
```

**Qué verás**: 
- Demostración de Products
- Demostración de Users
- Demostración de Orders (incluyendo POST)
- Demostración de Payments
- Demostración de Shipping
- Demostración de Favourites
- Service Discovery (Eureka)
- Health Check

**Duración**: ~5-6 minutos.

---

### PASO 6: Continúa leyendo el GUION.md

De minuto 12:00 hasta el final.

---

### PASO 7: Presiona STOP en OBS

**Termina grabación**.

---

## 📁 ARCHIVOS A USAR

**Solo 3 archivos necesitas:**

1. **README.md** - Para referencia rápida de URLs y comandos
2. **GUION.md** - Lee esto mientras grabas (tienes el guion completo)
3. **demo-commands.sh** - Ejecuta esto cuando GUION.md lo indique

---

## 🎬 ESTRUCTURA FINAL DEL VIDEO

```
[0:00-1:00]   Introducción - Lee GUION.md sección 1
[1:00-2:00]   Estructura - Ejecuta: ls -la
[2:00-4:00]   Levanta sistema - Ejecuta: docker-compose -f compose.yml up -d
[4:00-5:00]   Verificación - Ejecuta: docker ps
[5:00-6:00]   Explica componentes - Lee GUION.md
[6:00-12:00]  Demostración - Ejecuta: bash demo-commands.sh
[12:00-15:00] Observabilidad - Explica Eureka y Zipkin
[15:00-20:00] Conclusión y cierre - Lee GUION.md final
```

---

## 🛠️ COMANDOS CLAVE

```bash
# Levanta
docker-compose -f compose.yml up -d

# Verifica
docker ps

# Demostración completa
bash demo-commands.sh

# Detiene
docker-compose down

# Limpia (borra imágenes)
docker system prune -a
```

---

## 📍 URLs DURANTE GRABACIÓN

Menciona estas URLs en el video (usuarios pueden probarlo después):

- API Gateway: `http://localhost:8080`
- Eureka: `http://localhost:8761`
- Zipkin: `http://localhost:9411`

---

## 🎯 LO IMPORTANTE

✅ **Read GUION.md while recording** - Tienes todo el guion ahí  
✅ **Use demo-commands.sh** - Script automatiza todo  
✅ **Take your time** - No apresures, habla claro  
✅ **Explain responses** - Mientras ves JSON, explica qué ves  

---

## 🆘 SI ALGO FALLA

**Endpoint no responde:**
```bash
# Espera más tiempo (servicios iniciando)
sleep 30
bash demo-commands.sh
```

**Docker no funciona:**
```bash
docker --version
docker-compose --version
# Si error: instala Docker
```

**Contenedores se caen:**
```bash
docker-compose down
docker-compose up -d
```

---

## ✨ RESULTADO ESPERADO

Después de seguir esto:

✅ Video de 15-20 minutos  
✅ Profesional y técnico  
✅ Demostrando 10 microservicios  
✅ Con explicaciones claras  
✅ Listo para YouTube/evaluación  

---

## 📞 REFERENCIA

- **README.md** - Documentación completa y comandos
- **GUION.md** - Guion palabra-por-palabra  
- **demo-commands.sh** - Automatiza todas las demostraciones  
- **compose.yml** - Configuración de Docker (no tocar)

---

**¡TODO ESTÁ LISTO!**

**Comienza con:**
```bash
docker-compose -f compose.yml up -d
```

**Luego abre:**
```bash
cat GUION.md
```

**Y graba! 🎬**
