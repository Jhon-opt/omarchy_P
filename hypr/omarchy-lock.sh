#!/bin/bash
# Nuestro lock screen: hyprlock personalizado (morado + batería) en vez de omarchy-shell.
# Replica los extras de omarchy-system-lock para no perder nada.

# Mata el salvapantallas si está activo (igual que el original)
pkill -x ttfx 2>/dev/null || true
timeout 1s pidwait -x ttfx 2>/dev/null || true
pkill -f '[o]rg.omarchy.screensaver' 2>/dev/null || true

# Reset del layout de teclado
hyprctl switchxkblayout all 0 > /dev/null 2>&1

# Bloquear 1Password si está corriendo (igual que el original)
if pgrep -x "1password" >/dev/null && omarchy-cmd-present 1password; then
  (
    flock -n 9 || exit 0
    timeout --kill-after=1s 3s 1password --lock >/dev/null 2>&1 || true
  ) 9>"${XDG_RUNTIME_DIR:-/tmp}/omarchy-1password-lock.lock" &
fi

# Tu pantalla de bloqueo personalizada
exec hyprlock
