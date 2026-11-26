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

## 📁 CARPETA COMPARTIDA CON WINDOWS (`~/trabajo`)

Para editar tus scripts o proyectos cómodamente en Windows (con VS Code, etc.):
1. Crea o elige tu carpeta en Windows (por ejemplo, `C:\Users\TuUsuario\proyectos`).
2. En VirtualBox: **Dispositivos ➡️ Carpetas compartidas ➡️ Preferencias...**
3. Pulsa **Añadir (+)**, selecciona tu carpeta de Windows y dale de nombre exactamente: `trabajo`
4. Marca **Automontar** y **Hacer permanente** (deja *Solo lectura* desmarcado y *Punto de montaje* vacío).
5. En la consola de la VM se montará en `/home/usuario/trabajo` (o escribe `montar-trabajo` si la añadiste con la VM encendida).

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
