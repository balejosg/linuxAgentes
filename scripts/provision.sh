#!/usr/bin/env bash
# ==============================================================================
# Script de aprovisionamiento interno para Arch Linux VM (Edición Agentes IA)
# Se ejecuta dentro de la máquina virtual (vía SSH o durante la creación)
# ==============================================================================
set -euo pipefail

VM_USER="${VM_USER:-usuario}"
VM_PASS="${VM_PASS:-usuario}"
USER_HOME="/home/${VM_USER}"

echo "======================================================================"
echo "🤖 APROVISIONANDO ENTORNO ARCH LINUX: SISTEMA Y AGENTES IA"
echo "======================================================================"

# 1. Localización y Teclado Español
echo "[1/8] Configurando localización española (es_ES.UTF-8, KEYMAP=es)..."
sed -i 's/^#\(es_ES.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sed -i 's/^#\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen

cat << 'EOF' > /etc/locale.conf
LANG=es_ES.UTF-8
LC_COLLATE=C
EOF

cat << 'EOF' > /etc/vconsole.conf
KEYMAP=es
FONT=eurlatgr
EOF

ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
timedatectl set-timezone Europe/Madrid || true

# 2. Actualización completa del sistema y paquetes base
echo "[2/8] Actualizando todo el sistema e instalando paquetes base..."
pacman -Syu --noconfirm
pacman -S --noconfirm --needed \
    base-devel git curl wget rsync jq vim nano tmux zsh \
    htop glances ripgrep fd tree \
    net-tools iproute2 nmap tcpdump iperf3 bind socat traceroute \
    docker docker-compose \
    python python-pip python-psutil python-requests python-rich \
    virtualbox-guest-utils

# 3. Configuración del usuario principal
echo "[3/8] Configurando usuario '${VM_USER}' y permisos sudo..."
if ! id -u "${VM_USER}" >/dev/null 2>&1; then
    useradd -m -G wheel -s /bin/bash "${VM_USER}"
    echo "${VM_USER}:${VM_PASS}" | chpasswd
fi

mkdir -p /etc/sudoers.d
cat << 'EOF' > /etc/sudoers.d/wheel
%wheel ALL=(ALL:ALL) ALL
EOF
chmod 440 /etc/sudoers.d/wheel

# 4. Configuración del servicio Docker
echo "[4/8] Habilitando Docker y asignando permisos al usuario '${VM_USER}'..."
systemctl enable docker.service
systemctl start docker.service || true
usermod -aG docker "${VM_USER}"

# 5. Soporte para Carpetas Compartidas de VirtualBox
echo "[5/8] Habilitando VirtualBox Guest Additions..."
systemctl enable vboxservice.service || true
usermod -aG vboxsf "${VM_USER}"

# 6. Instalación de Agentes de IA (OpenCode v2, Herdr)
echo "[6/8] Configurando herramientas de Inteligencia Artificial Agéntica..."

# Instalar OpenCode v2 (100% Libre y de código abierto)
if ! command -v opencode >/dev/null 2>&1; then
    echo "Instalando OpenCode v2 CLI..."
    curl -fsSL https://opencode.ai/v2/install | bash -s -- --no-modify-path || true
    if [ -f /root/.opencode/bin/opencode ]; then
        install -m 755 /root/.opencode/bin/opencode /usr/local/bin/opencode
    fi
fi

# Instalar Herdr
if ! command -v herdr >/dev/null 2>&1; then
    echo "Instalando Herdr CLI..."
    curl -fsSL https://herdr.dev/install.sh | bash || true
    if [ -f /root/.herdr/bin/herdr ]; then
        install -m 755 /root/.herdr/bin/herdr /usr/local/bin/herdr
    fi
fi

# 7. Configuración de directrices de los agentes
echo "[7/8] Instalando directrices técnicas en los agentes..."
mkdir -p "${USER_HOME}/.config/opencode"
mkdir -p "${USER_HOME}/.gemini/antigravity-cli/rules"
mkdir -p "${USER_HOME}/.gemini/rules"

if [ -f /tmp/AGENTS.md ]; then
    cp /tmp/AGENTS.md "${USER_HOME}/.config/opencode/AGENTS.md"
    cp /tmp/AGENTS.md "${USER_HOME}/.gemini/antigravity-cli/rules/asistente-tecnico.md"
    cp /tmp/AGENTS.md "${USER_HOME}/.gemini/rules/asistente-tecnico.md"
fi

# 8. Espacio de Trabajo (~/trabajo) y comando 'montar-trabajo'
echo "[8/8] Preparando workspace ~/trabajo y utilidades..."
mkdir -p "${USER_HOME}/trabajo/proyectos"

if [ -f /tmp/AGENTS.md ]; then
    cp /tmp/AGENTS.md "${USER_HOME}/trabajo/" || true
fi

if [ -f /tmp/LEEME.md ]; then
    cp /tmp/LEEME.md "${USER_HOME}/trabajo/LEEME.txt" || true
fi

if [ -f /tmp/montar-trabajo ]; then
    install -m 755 /tmp/montar-trabajo /usr/local/bin/montar-trabajo
fi

# Configurar entrada en /etc/fstab para la carpeta compartida con 'nofail'
USER_UID="$(id -u "${VM_USER}")"
USER_GID="$(id -g "${VM_USER}")"
if ! grep -q "trabajo ${USER_HOME}/trabajo" /etc/fstab; then
    cat << EOF >> /etc/fstab
trabajo ${USER_HOME}/trabajo vboxsf rw,uid=${USER_UID},gid=${USER_GID},dmode=755,fmode=644,nofail 0 0
EOF
fi

# Asignar permisos al usuario principal
chown -R "${VM_USER}:${VM_USER}" "${USER_HOME}"

echo "======================================================================"
echo "✓ APROVISIONAMIENTO COMPLETADO SATISFACTORIAMENTE"
echo "======================================================================"
