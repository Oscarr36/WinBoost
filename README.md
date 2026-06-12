<div align="center">

# ⚡ WinBoost

### Optimizador, limpiador y reparador de Windows en un solo clic

[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Batch](https://img.shields.io/badge/Batch-Script-4D4D4D?style=for-the-badge&logo=windows-terminal&logoColor=white)](https://en.wikipedia.org/wiki/Batch_file)
[![Version](https://img.shields.io/badge/Version-2.0-blue?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen?style=for-the-badge)]()

**Limpia, optimiza y repara tu Windows en 4 fases automatizadas.**

[Características](#-características) •
[Instalación](#-instalación) •
[Uso](#-uso) •
[Qué hace](#-qué-hace-el-script) •
[FAQ](#-faq)

---

</div>

## 📋 Descripción

**WinBoost** es un script `.bat` para Windows que automatiza la limpieza, optimización y reparación del sistema en **4 fases completas**: limpieza profunda, red y rendimiento, optimización avanzada, y verificación de integridad con DISM inteligente.

> ⚡ **Resultado:** equipo más rápido, varios GB liberados, sistema reparado y verificado — todo sin tocar nada.

### ¿Qué lo diferencia de la v1?

| Característica | v1 | v2 |
|---|---|---|
| Fases | 3 | **4** |
| Pasos de limpieza | 8 | **18** |
| Limpieza de navegadores | ❌ | ✅ Edge, Chrome, Firefox |
| Cache GPU | ❌ | ✅ DirectX, NVIDIA, AMD |
| DISM con imagen local | ❌ | ✅ Auto-detecta la mejor |
| DISM ScanHealth previo | ❌ | ✅ |
| DISM ResetBase | ❌ | ✅ |
| Log de sesion | ❌ | ✅ Guardado en el Escritorio |
| Espacio antes/despues | ❌ | ✅ |
| Optimizacion de CPU | ❌ | ✅ |
| Plan de energia | ❌ | ✅ Alto rendimiento |
| NTFS optimizado | ❌ | ✅ |
| TRIM para SSD | ❌ | ✅ |
| TCP/IP avanzado | Basico | ✅ Completo |
| Volcados de memoria | ❌ | ✅ |
| Defender cache | ❌ | ✅ |

---

## ✨ Características

- 🧹 **Limpieza profunda (18 pasos)** — temporales, prefetch, papelera, miniaturas, logs, Windows Update, Store, navegadores, GPU, crash dumps y más
- 🌐 **Red y rendimiento** — flush DNS, reset Winsock, TCP/IP optimizado, TRIM SSD, RAM
- ⚙️ **Optimización avanzada** — plan de energía alto rendimiento, CPU al 100%, SysMain desactivado, NTFS, delays de inicio
- 🛡️ **DISM inteligente** — escanea todas las unidades, detecta automáticamente la imagen de Windows más reciente disponible y la usa como fuente, con 3 niveles de fallback
- 📊 **Log completo** — guarda un `.txt` en el Escritorio con todo lo ejecutado y el espacio antes/después
- 🔒 **Verificación de admin** — instrucciones claras si falta permisos
- ♻️ **Reinicio opcional** — te pregunta al terminar

---

## 📦 Instalación

### Opción 1: Clonar el repositorio

```bash
git clone https://github.com/Oscarr36/WinBoost.git
cd WinBoost
```

### Opción 2: Descarga directa

Descarga `Optimizador.bat` desde la sección [Releases](https://github.com/Oscarr36/WinBoost/releases) o directamente desde el repositorio.

---

## 🚀 Uso

1. **Clic derecho** sobre `Optimizador.bat`
2. Selecciona **"Ejecutar como administrador"**
3. Pulsa cualquier tecla para empezar
4. Espera a que terminen las 4 fases *(10–40 min según el equipo)*
5. Reinicia cuando te lo pida

> ⚠️ **Importante:** necesita **permisos de administrador** para reparar archivos del sistema y limpiar carpetas protegidas.

### 💡 Consejo: DISM más rápido y fiable

Si tienes el ISO de Windows montado o un DVD insertado, el DISM usará automáticamente esa imagen local en lugar de descargar de Windows Update — mucho más rápido y funciona sin internet.

El script escanea todas las letras de unidad y **elige automáticamente la imagen con el build más alto** (más actualizada).

---

## 🔧 Qué hace el script

<details>
<summary><b>🧹 FASE 1 — Limpieza profunda (18 pasos)</b></summary>

| Paso | Acción |
|------|--------|
| 1 | Limpia temporales del usuario (`%TEMP%`) |
| 2 | Limpia temporales de Windows (`C:\Windows\Temp`) |
| 3 | Borra caché de Prefetch |
| 4 | Vacía la papelera de reciclaje |
| 5 | Limpia caché de miniaturas (reinicia Explorer) |
| 6 | Borra logs CBS del sistema |
| 7 | Limpia caché de Windows Update (para y reinicia el servicio) |
| 8 | Borra registros de eventos de Windows |
| 9 | Limpia caché de fuentes |
| 10 | Resetea caché de Microsoft Store |
| 11 | Limpia caché de Microsoft Edge |
| 12 | Limpia caché de Google Chrome |
| 13 | Limpia caché de Firefox |
| 14 | Limpia caché GPU (DirectX Shader, NVIDIA, AMD) |
| 15 | Elimina volcados de memoria (crash dumps) |
| 16 | Borra archivos `.tmp` del sistema |
| 17 | Limpia caché de Windows Defender |
| 18 | Ejecuta `cleanmgr` automatizado con múltiples categorías |

</details>

<details>
<summary><b>🌐 FASE 2 — Red y rendimiento (7 pasos)</b></summary>

| Paso | Acción |
|------|--------|
| 1 | Vacía la caché DNS |
| 2 | Reinicia el catálogo Winsock |
| 3 | Reinicia la pila TCP/IP |
| 4 | Optimiza parámetros TCP (autotuning, ECN, RTT, timestamps) |
| 5 | Activa gestión automática de memoria virtual |
| 6 | Libera listas de espera de RAM |
| 7 | Envía comando TRIM al SSD |

</details>

<details>
<summary><b>⚙️ FASE 3 — Optimización avanzada (7 pasos)</b></summary>

| Paso | Acción |
|------|--------|
| 1 | Activa el plan de energía de **alto rendimiento** |
| 2 | Establece el procesador al **100% mínimo/máximo** |
| 3 | Desactiva SysMain (Superfetch) — innecesario en SSD |
| 4 | Ajusta efectos visuales para máximo rendimiento |
| 5 | Elimina delay del menú inicio |
| 6 | Desactiva delay de arranque de aplicaciones |
| 7 | Optimiza NTFS (disable8dot3, lastaccess) |

</details>

<details>
<summary><b>🛡️ FASE 4 — Verificación de integridad (DISM inteligente + SFC)</b></summary>

| Paso | Acción |
|------|--------|
| 1 | `DISM /ScanHealth` — escaneo rápido de corrupción |
| 2 | Escaneo automático de unidades buscando `install.wim` / `install.esd` |
| 3 | Selección de la **imagen con el build más alto** como fuente de reparación |
| 3b | `DISM /RestoreHealth` con imagen local + `/LimitAccess` |
| 3c | Fallback: sin `/LimitAccess` si falla el primero |
| 3d | Fallback final: Windows Update si no hay imagen local |
| 4 | `DISM /StartComponentCleanup /ResetBase` — elimina componentes obsoletos |
| 5 | `sfc /scannow` — verifica y repara archivos del sistema |

</details>

---

## ⚙️ Requisitos

- 🪟 Windows 10 / Windows 11
- 🔑 Permisos de administrador
- 📡 Conexión a internet *(recomendada para DISM si no hay imagen local)*

---

## ❓ FAQ

<details>
<summary><b>¿Es seguro? ¿Puede romper algo?</b></summary>

Sí, es seguro. Solo borra archivos temporales y usa herramientas oficiales de Microsoft (`DISM`, `SFC`, `cleanmgr`, `netsh`, `powercfg`). La papelera se vacía sin avisar — revísala antes de ejecutar.

Los cambios en el registro (efectos visuales, delays) son revertibles desde Configuración de Windows.

</details>

<details>
<summary><b>¿Qué hace exactamente "DISM inteligente"?</b></summary>

El script escanea **todas las letras de unidad** buscando `install.wim` o `install.esd` (imágenes de instalación de Windows, como las de un ISO montado o DVD). Compara el número de build de cada imagen encontrada y **selecciona la más reciente** para usar como fuente de reparación.

Esto es más rápido y fiable que depender de Windows Update, especialmente si tienes el ISO de tu versión de Windows a mano.

Si no encuentra ninguna imagen local, usa Windows Update como fallback — y si eso también falla, lo registra en el log con detalle.

</details>

<details>
<summary><b>¿Cuánto tarda?</b></summary>

Entre **15 y 45 minutos**, dependiendo del equipo y la conexión. La Fase 4 (DISM + SFC) es la más larga. Con una imagen local montada es considerablemente más rápida.

</details>

<details>
<summary><b>¿Pierdo archivos personales?</b></summary>

No. Solo se borran archivos temporales, caché y la papelera. Documentos, fotos y programas no se tocan. Revisa la papelera antes si tenías algo importante.

</details>

<details>
<summary><b>¿Qué pasa si desactiva SysMain en un HDD?</b></summary>

SysMain (antes Superfetch) precarga en RAM los programas más usados. En **SSD es innecesario** y consume recursos. Si usas **HDD**, puedes comentar o borrar los pasos 3 y 4 de la Fase 3 editando el `.bat` antes de ejecutarlo.

</details>

<details>
<summary><b>¿Cada cuánto debería ejecutarlo?</b></summary>

Una vez al mes para mantenimiento preventivo. Si notas el equipo lento, con errores o problemas de red, ejecútalo en cualquier momento.

</details>

<details>
<summary><b>¿Dónde queda el log?</b></summary>

En el **Escritorio** con el nombre `WinBoost_Log_AAAAMMDD_HHMMSS.txt`. Contiene todo lo ejecutado, resultados de DISM y SFC, la fuente usada para la reparación y el espacio libre antes/después.

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

**Hecho con ☕ y muchas ganas de que el PC arranque rápido**

</div>
