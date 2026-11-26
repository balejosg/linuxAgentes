# GUÍA RÁPIDA (ARCH LINUX VM - EDICIÓN AGENTES IA)

¡Bienvenido a tu entorno de **Arch Linux** preconfigurado para desarrollo, administración de sistemas y trabajo con **agentes de inteligencia artificial**!

---

## 🔑 CREDENCIALES DE ACCESO

* **Usuario:** `usuario`
* **Contraseña:** `usuario`
* **Privilegios de Administrador:** `sudo <comando>` (usa la contraseña `usuario`).
* **Conexión SSH desde tu PC anfitrión:**
  ```bash
  ssh -p 2222 usuario@127.0.0.1
  ```

---

## 📁 CARPETA COMPARTIDA CON EL ANFITRIÓN (`~/trabajo`)

Para editar tus scripts o proyectos cómodamente con tu editor en tu equipo real:
1. En el menú de VirtualBox: **Dispositivos ➡️ Carpetas compartidas ➡️ Preferencias...**
2. Añade tu carpeta local, dale de nombre exactamente: `trabajo`
3. Marca: **Automontar** y **Hacer permanente**.
4. En la consola de la VM escribe:
   ```bash
   montar-trabajo
   ```
   Tus archivos estarán sincronizados en tiempo real dentro de `/home/usuario/trabajo/`.

---

## 🚀 HERRAMIENTAS PREINSTALADAS

### 1. Gestión de Contenedores y Servicios
* `docker` y `docker compose` (tu usuario ya pertenece al grupo `docker`; no necesitas `sudo` para correr `docker ps`).
* Comandos útiles:
  ```bash
  docker compose up -d
  docker compose ps
  docker stats --no-stream
  ```

### 2. Herramientas de Sistema, Red y Desarrollo
* **Editores y terminal:** `vim`, `nano`, `tmux`, `zsh`, `git`, `base-devel`.
* **Búsqueda y monitorización:** `ripgrep` (`rg`), `fd`, `tree`, `htop`, `glances`, `jq`.
* **Red:** `iproute2`, `nmap`, `tcpdump`, `iperf3`, `bind` (`dig`), `socat`, `traceroute`.
* **Python:** `python`, `pip`, `psutil`, `requests`, `rich`.

### 3. Agentes de Inteligencia Artificial
* **OpenCode v2 CLI**: `opencode` (agente de código abierto para terminal).
* **Antigravity CLI**: `agy` (si está instalado en tu sistema o vía `paru -S antigravity-cli`).
* **Herdr CLI**: `herdr`.
* **Asistente Técnico**: Los agentes leen automáticamente las directrices de `AGENTS.md` para ayudarte a diseñar, configurar y depurar proyectos de forma directa y eficaz.
