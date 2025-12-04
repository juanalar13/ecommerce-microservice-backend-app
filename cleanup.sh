#!/bin/bash

# Script para limpiar documentación antigua y preparar el repositorio

echo "🧹 Limpiando archivos de documentación innecesarios..."

# Archivos a eliminar (creados en el último commit)
files_to_delete=(
    "00_PUNTO_ENTRADA.md"
    "CHECKLIST.md"
    "ENTREGA.md"
    "ENTREGA_VISUAL.sh"
    "GUION.md"
    "INICIO.md"
    "INICIO_RÁPIDO.md"
    "INSTRUCCIONES.md"
    "PRESENTACIÓN.md"
    "SCRIPT.md"
    "RESUMEN_ENTREGA.md"
    "ÍNDICE.md"
    "DEPLOYMENT_PROGRESS.md"
    "DEPLOYMENT_READY.md"
    "IMPLEMENTATION_COMPLETE.md"
    "INDEX_AND_REFERENCES.md"
    "K8S_IMPLEMENTATION_SUMMARY.md"
    "KUBERNETES_ARCHITECTURE.md"
    "NETWORK_POLICIES_FIX.md"
    "NETWORK_POLICIES_QUICK_FIX.md"
    "OPERATIONS_GUIDE.md"
    "REQUIREMENTS_CHECKLIST.md"
    "SECURITY_GUIDE.md"
    "START_HERE.md"
    "WSL2_QUICK_START.md"
    "WSL2_UBUNTU_GUIDE.md"
    "QUICK_START.sh"
    "QUICK_START.txt"
    "Proyecto Final Plataformas II.pdf"
    "demo-commands.sh"
    "k8s-commands.sh"
    "k8s-deploy.sh"
    "k8s-verify.sh"
    "build-all-images.sh"
    "setup-wsl2.sh"
    "sync-dockerfiles.sh"
)

# Eliminar archivos
for file in "${files_to_delete[@]}"; do
    if [ -f "$file" ]; then
        rm -f "$file"
        echo "✓ Eliminado: $file"
    fi
done

echo ""
echo "✅ Limpieza completada"
echo ""
echo "Archivos conservados:"
echo "  ├── README.md (Documentación principal)"
echo "  ├── compose.yml (Orquestación Docker)"
echo "  ├── demo-requests.sh (Script de demostración)"
echo "  ├── pom.xml (Configuración Maven)"
echo "  └── [Directorios de servicios]"
