#!/bin/bash
# ============================================================
#  Update Script: Open WebUI (CUDA) + Open Terminal
#  With host networking + NVIDIA GPU support
# ============================================================

set -euo pipefail

# ── COLORS ──────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log()    { echo -e "${CYAN}[•]${NC} $*"; }
ok()     { echo -e "${GREEN}[✓]${NC} $*"; }
warn()   { echo -e "${YELLOW}[!]${NC} $*"; }
error()  { echo -e "${RED}[✗]${NC} $*"; exit 1; }
header() { echo -e "\n${BOLD}${CYAN}══ $* ══${NC}\n"; }

# ── CONFIG — edit these to match your setup ─────────────────

OPENWEBUI_CONTAINER="open-webui"
OPENWEBUI_IMAGE="ghcr.io/open-webui/open-webui:cuda"
OPENWEBUI_VOLUME="open-webui"
OPENWEBUI_SECRET_KEY="koudos"

OPEN_TERMINAL_CONTAINER="open-terminal"
OPEN_TERMINAL_IMAGE="ghcr.io/open-webui/open-terminal:latest"
OPEN_TERMINAL_VOLUME="open-terminal"
OPEN_TERMINAL_API_KEY="koudos"

# ── HELPERS ─────────────────────────────────────────────────

container_exists() { docker ps -a --format '{{.Names}}' | grep -q "^$1$"; }
image_newer() {
    local container="$1" image="$2"
    local running_id pulled_id
    running_id=$(docker inspect --format='{{.Image}}' "$container" 2>/dev/null || echo "")
    pulled_id=$(docker image inspect --format='{{.Id}}' "$image" 2>/dev/null || echo "")
    [[ "$running_id" != "$pulled_id" ]]
}

# ── PRE-FLIGHT ───────────────────────────────────────────────

header "Pre-flight checks"

command -v docker &>/dev/null || error "Docker not found. Install Docker first."
docker info &>/dev/null       || error "Docker daemon isn't running."
ok "Docker is ready"

# Check NVIDIA runtime is available for CUDA image
if ! docker info 2>/dev/null | grep -q "nvidia"; then
    error "NVIDIA Docker runtime not found! Install the NVIDIA Container Toolkit:\n  https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html\n  Then restart Docker and re-run this script."
fi
if ! command -v nvidia-smi &>/dev/null; then
    warn "nvidia-smi not found — make sure NVIDIA drivers are installed on the host."
else
    ok "NVIDIA GPU(s) detected:"
    nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader | \
        while IFS= read -r line; do log "  GPU: $line"; done
fi

# ── UPDATE: OPEN WEBUI ───────────────────────────────────────

header "Updating Open WebUI"

log "Pulling latest image: $OPENWEBUI_IMAGE"
docker pull "$OPENWEBUI_IMAGE"

if container_exists "$OPENWEBUI_CONTAINER"; then
    if image_newer "$OPENWEBUI_CONTAINER" "$OPENWEBUI_IMAGE"; then
        log "New image detected — recreating container..."
    else
        warn "Image is already up to date — recreating anyway to apply any config changes."
    fi
    log "Stopping & removing old container..."
    docker rm -f "$OPENWEBUI_CONTAINER"
else
    log "No existing container found — starting fresh."
fi

log "Starting Open WebUI (CUDA)..."
docker run -d \
    --name "$OPENWEBUI_CONTAINER" \
    --network host \
    --gpus all \
    -v "${OPENWEBUI_VOLUME}:/app/backend/data" \
    -e WEBUI_SECRET_KEY="$OPENWEBUI_SECRET_KEY" \
    -e PORT=3000 \
    --restart always \
    "$OPENWEBUI_IMAGE"

ok "Open WebUI is up!  →  http://localhost:8080"

# ── UPDATE: OPEN TERMINAL ────────────────────────────────────

header "Updating Open Terminal"

log "Pulling latest image: $OPEN_TERMINAL_IMAGE"
docker pull "$OPEN_TERMINAL_IMAGE"

if container_exists "$OPEN_TERMINAL_CONTAINER"; then
    if image_newer "$OPEN_TERMINAL_CONTAINER" "$OPEN_TERMINAL_IMAGE"; then
        log "New image detected — recreating container..."
    else
        warn "Image is already up to date — recreating anyway to apply any config changes."
    fi
    log "Stopping & removing old container..."
    docker rm -f "$OPEN_TERMINAL_CONTAINER"
else
    log "No existing container found — starting fresh."
fi

log "Starting Open Terminal..."
docker run -d \
    --name "$OPEN_TERMINAL_CONTAINER" \
    --network host \
    -v "${OPEN_TERMINAL_VOLUME}:/home/user" \
    -e OPEN_TERMINAL_API_KEY="$OPEN_TERMINAL_API_KEY" \
    --restart unless-stopped \
    "$OPEN_TERMINAL_IMAGE" \
    run --port 9999

ok "Open Terminal is up!  →  http://localhost:9999"

# ── CLEANUP ──────────────────────────────────────────────────

header "Cleanup"

log "Removing dangling/unused images..."
docker image prune -f
ok "Cleanup done."

# ── SUMMARY ─────────────────────────────────────────────────

echo ""
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════╗"
echo -e "║           Update Complete! 🎉            ║"
echo -e "╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Open WebUI    →  ${CYAN}http://localhost:8080${NC}"
echo -e "  Open Terminal →  ${CYAN}http://localhost:8000${NC}"
echo ""
echo -e "  ${YELLOW}Remember to clear browser cache:  Ctrl+Shift+R${NC}"
echo ""