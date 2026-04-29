<div align="center">

# 🚀 System Optimizer

### Script de optimización y limpieza para Windows

[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Batch](https://img.shields.io/badge/Batch-Script-4D4D4D?style=for-the-badge&logo=windows-terminal&logoColor=white)](https://en.wikipedia.org/wiki/Batch_file)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen?style=for-the-badge)]()

**Limpia, optimiza y repara tu Windows en un solo clic.**

[Características](#-características) •
[Instalación](#-instalación) •
[Uso](#-uso) •
[Qué hace](#-qué-hace-el-script) •
[FAQ](#-faq)

---

</div>

## 📋 Descripción

**System Optimizer** es un script `.bat` para Windows que automatiza la limpieza y optimización del sistema en **3 fases**: limpieza de archivos, optimización de red y verificación de integridad. Pensado para esos momentos en los que el PC va lento al arrancar y no quieres pelearte con menús.

> ⚡ **Resultado:** equipo más rápido, menos archivos basura y sistema verificado en pocos minutos.

---

## ✨ Características

- 🧹 **Limpieza profunda** — temporales, prefetch, papelera, caché de miniaturas y logs
- 🌐 **Optimización de red** — flush DNS, reset de Winsock y pila TCP/IP
- 🛡️ **Verificación de integridad** — DISM + SFC para reparar archivos del sistema
- 🎨 **Interfaz visual** — banner ASCII, fases numeradas y feedback en tiempo real
- 🔒 **Comprobación de admin** — avisa si te falta permisos antes de ejecutar
- ♻️ **Reinicio opcional** — al terminar te pregunta si quieres reiniciar
- 📊 **Info del sistema** — muestra usuario, equipo y SO al arrancar

---

## 📦 Instalación

### Opción 1: Clonar el repositorio
```bash
git clone https://github.com/Oscarr36/system-optimizer.git
cd system-optimizer
### Opción 2: Descarga directa
Descarga el archivo `Optimizador.bat` desde la sección [Releases](https://github.com/Oscarr36/system-optimizer/releases) o directamente desde el repositorio.

---

## 🚀 Uso

1. **Clic derecho** sobre `Optimizador.bat`
2. Selecciona **"Ejecutar como administrador"**
3. Pulsa cualquier tecla para empezar
4. Espera a que terminen las 3 fases (5-30 min según el equipo)
5. Reinicia cuando te lo pida

> ⚠️ **Importante:** el script **necesita permisos de administrador** para reparar archivos del sistema y limpiar carpetas protegidas.

### 💡 Consejo
Crea un acceso directo en el escritorio con la opción "Ejecutar como administrador" siempre activada:

`Propiedades` → `Acceso directo` → `Opciones avanzadas` → ✅ `Ejecutar como administrador`

---

## 🔧 Qué hace el script

<details>
<summary><b>🧹 FASE 1 — Limpieza del sistema</b></summary>

| Paso | Acción |
|------|--------|
| 1 | Limpia temporales del usuario (`%TEMP%`) |
| 2 | Limpia temporales de Windows (`C:\Windows\Temp`) |
| 3 | Borra caché de Prefetch |
| 4 | Vacía la papelera de reciclaje |
| 5 | Limpia caché de miniaturas |
| 6 | Borra logs antiguos del sistema |
| 7 | Limpia descargas pendientes de Windows Update |
| 8 | Ejecuta limpieza de disco de Windows |

</details>

<details>
<summary><b>🌐 FASE 2 — Optimización de red y rendimiento</b></summary>

| Paso | Acción |
|------|--------|
| 1 | Vacía la caché DNS (`ipconfig /flushdns`) |
| 2 | Reinicia el catálogo Winsock |
| 3 | Reinicia la pila TCP/IP |
| 4 | Libera memoria RAM no utilizada |

</details>

<details>
<summary><b>🛡️ FASE 3 — Verificación de integridad</b></summary>

| Paso | Acción |
|------|--------|
| 1 | `DISM /RestoreHealth` repara la imagen del sistema |
| 2 | `sfc /scannow` verifica y repara archivos del sistema |

</details>

---

## ⚙️ Requisitos

- 🪟 Windows 10 / Windows 11
- 🔑 Permisos de administrador
- 📡 Conexión a internet (recomendada para DISM)

---

## ❓ FAQ

<details>
<summary><b>¿Es seguro? ¿Puede romper algo?</b></summary>

Sí, es seguro. Solo borra archivos temporales (Windows los regenera) y usa herramientas oficiales de Microsoft (`DISM`, `SFC`, `cleanmgr`). La papelera se vacía sin avisar, así que revísala antes de ejecutar.

Si usas VPN corporativa o configuración de red especial, considera quitar los pasos de `netsh` que resetean la red.
</details>

<details>
<summary><b>¿Cuánto tarda?</b></summary>

Entre **5 y 30 minutos**, dependiendo del equipo. La fase de DISM + SFC es la más larga.
</details>

<details>
<summary><b>¿Pierdo archivos personales?</b></summary>

No. Solo se borran archivos temporales y la **papelera de reciclaje**. Mira la papelera antes de ejecutar por si tenías algo importante ahí.
</details>

<details>
<summary><b>¿Hay que reiniciar?</b></summary>

Recomendado. Los cambios de red (Winsock, TCP/IP) se aplican tras reiniciar. El script te pregunta al final si quieres reiniciar automáticamente.
</details>

<details>
<summary><b>¿Cada cuánto debería ejecutarlo?</b></summary>

Una vez al mes es más que suficiente para uso normal. Si notas el equipo lento o con problemas, también vale.
</details>

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Si quieres añadir funcionalidad o mejorar algo:

1. Haz fork del repositorio
2. Crea una rama (`git checkout -b feature/nueva-funcion`)
3. Commit de tus cambios (`git commit -m 'Añade nueva función'`)
4. Push a la rama (`git push origin feature/nueva-funcion`)
5. Abre un Pull Request

---

## 📜 Licencia

Este proyecto está bajo la licencia MIT. Mira el archivo [LICENSE](LICENSE) para más detalles.

---

## 👤 Autor

<div align="center">

**Oscarr36**

[![GitHub](https://img.shields.io/badge/GitHub-Oscarr36-181717?style=for-the-badge&logo=github)](https://github.com/Oscarr36)

⭐ Si te ha sido útil, deja una estrella al repositorio

</div>

---

<div align="center">

**Hecho con ☕ 
