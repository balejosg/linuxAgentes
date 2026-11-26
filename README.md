# Arch Linux VM para VirtualBox (Edición Agentes IA)

Máquina virtual de **Arch Linux** preconfigurada y actualizada para desarrollo, administración de sistemas y trabajo con **agentes de inteligencia artificial** en terminal (`opencode` v2, `agy`, `herdr`).

## 🚀 Enlaces y Descargas
* 🌐 **Página Web / GitHub Pages**: [https://balejosg.github.io/linuxAgentes/](https://balejosg.github.io/linuxAgentes/)
* 📦 **Descarga directa (.ova, ~1.8 GB)**: [ArchLinux-Agentes.ova (v1.0.0)](https://github.com/balejosg/linuxAgentes/releases/download/v1.0.0/ArchLinux-Agentes.ova)
  * **Checksum SHA-256**: `c9073fb7dcff2a342624cba2dde915b4857a33634bd93a7e639c71a19658be34`

---

## 🔑 Credenciales y Mapeo de Puertos NAT

| Parámetro | Valor |
| :--- | :--- |
| **Usuario** | `usuario` |
| **Contraseña** | `usuario` |
| **Permisos de Administrador** | `sudo` completo habilitado |
| **Conexión SSH** | Puerto anfitrión `2222` (`ssh -p 2222 usuario@127.0.0.1`) |
| **Servidor Web HTTP** | Puerto anfitrión `8080` (`http://localhost:8080`) |
| **Carpeta compartida Host** | Sincronización en caliente en `/home/usuario/trabajo` |
| **Localización y Teclado** | España (`es_ES.UTF-8`, `KEYMAP=es`, zona horaria `Europe/Madrid`) |
| **Guest Additions** | `virtualbox-guest-utils` preinstalado y activo |

---

## 🤖 Entorno de Agentes IA y Desarrollo

### 1. Agentes Preinstalados y Configurados
Los agentes de IA (`opencode` v2, `agy`, `herdr`) leen las directrices de `AGENTS.md`:
* **OpenCode v2 (`opencode`)**: Instalado desde el canal oficial v2 (`https://opencode.ai/v2/install`).
* **Herdr (`herdr`)**: Instalado desde `https://herdr.dev/install.sh`.
* **Antigravity CLI (`agy`)**: Compatible mediante `paru -S antigravity-cli`, con reglas preconfiguradas en `~/.gemini/antigravity-cli/rules/`.
* **Directrices técnicas (`AGENTS.md`)**: Copiadas automáticamente para `opencode` y `agy`.

### 2. Herramientas del Sistema Actualizadas
El aprovisionamiento ejecuta `pacman -Syu` completo e instala:
* **Contenedores:** `docker`, `docker-compose`.
* **Desarrollo y Terminal:** `base-devel`, `git`, `curl`, `wget`, `rsync`, `jq`, `vim`, `nano`, `tmux`, `zsh`.
* **Búsqueda y Monitorización:** `ripgrep`, `fd`, `tree`, `htop`, `glances`.
* **Redes:** `net-tools`, `iproute2`, `nmap`, `tcpdump`, `iperf3`, `bind`, `socat`, `traceroute`.
* **Python:** `python`, `python-pip`, `python-psutil`, `python-requests`, `python-rich`.

### 3. Estructura de Contexto en `~/trabajo`
```text
~/trabajo/
├── proyectos/     <-- Proyectos propios (editables desde el host)
├── AGENTS.md      <-- Directrices técnicas del asistente IA
└── LEEME.txt      <-- Guía rápida de uso
```

---

## 📁 Cómo vincular tu carpeta local de trabajo

1. En VirtualBox: **Dispositivos ➡️ Carpetas compartidas ➡️ Preferencias...**
2. Añade (+) la carpeta de tu ordenador real donde guardas tus proyectos.
3. Nombre de la carpeta: **`trabajo`**
4. Marca: **Automontar** y **Hacer permanente**.
5. Al arrancar la VM se montará sola en `~/trabajo` (o escribe `montar-trabajo` en la terminal).

---

## 💡 ¿Cómo reproducir o modificar este entorno?

Los scripts de creación y aprovisionamiento están en la carpeta `scripts/`:
* [`scripts/crear-vm.sh`](scripts/crear-vm.sh): Automatiza la descarga de la imagen base de Arch Linux, conversión a VDI y creación/configuración de la VM en VirtualBox.
* [`scripts/provision.sh`](scripts/provision.sh): Actualiza todo el sistema (`pacman -Syu`), configura localización, usuario, Docker, VirtualBox Guest Additions, **OpenCode v2**, **Herdr** y el workspace `~/trabajo`.

Para instalar OpenCode v2 manualmente en cualquier máquina Linux:
```bash
curl -fsSL https://opencode.ai/v2/install | bash
```
