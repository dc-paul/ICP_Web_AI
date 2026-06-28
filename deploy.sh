#!/usr/bin/env bash
# Allusion.be — one-command deploy naar Juno (Internet Computer).
# Gebruik:  ./deploy.sh
# Doet: juiste Node activeren (nvm) -> wijzigingen committen -> pushen -> juno deploy.
set -euo pipefail

cd "$(dirname "$0")"

# --- 1. Juiste Node activeren (juno CLI is geïnstalleerd onder Node 24 via nvm) ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
  nvm use 24 >/dev/null 2>&1 || nvm use --lts >/dev/null 2>&1 || true
fi

if ! command -v juno >/dev/null 2>&1; then
  echo "✖ 'juno' niet gevonden op PATH."
  echo "  Activeer eerst de juiste Node (bv. 'nvm use 24') of installeer de CLI:"
  echo "    npm i -g @junobuild/cli"
  exit 1
fi

echo "▸ Node: $(node -v)   juno: $(command -v juno)"

# --- 2. Wijzigingen committen (alleen als er iets veranderd is) ---
if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  git commit -m "deploy: $(date '+%Y-%m-%d %H:%M')" || true
else
  echo "▸ Geen wijzigingen om te committen."
fi

# --- 3. Pushen (best effort; deploy gaat door ook als push faalt) ---
git push || echo "⚠ git push faalde of niets te pushen — deploy gaat door."

# --- 4. Deployen naar Juno (predeploy draait 'npm run build') ---
juno deploy

echo ""
echo "✅ Klaar. Live: https://www.allusion.be"
