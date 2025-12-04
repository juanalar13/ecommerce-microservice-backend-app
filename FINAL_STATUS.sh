#!/bin/bash

# Script final para confirmar cambios en git
echo "✅ ESTADO FINAL DEL REPOSITORIO"
echo "================================"
echo ""
echo "📋 Cambios en git:"
git status --short | head -20
echo ""
echo "📄 Archivos markdown en raíz:"
ls -1 *.md 2>/dev/null | wc -l
echo "archivos .md encontrados"
echo ""
echo "✅ Archivos principales conservados:"
echo "   • README.md"
echo "   • compose.yml"
echo "   • demo-requests.sh"
echo "   • pom.xml"
echo ""
echo "🎯 Siguiente paso para el usuario:"
echo "   1. Ejecutar: docker-compose -f compose.yml up -d"
echo "   2. Ejecutar: bash demo-requests.sh"
echo ""
