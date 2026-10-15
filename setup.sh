#!/usr/bin/env bash
set -Eeuo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "This script must be run as root (use sudo)." >&2
  exit 1
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

export DEBIAN_FRONTEND=noninteractive

log() {
  echo "[setup] $*"
}

ensure_packages() {
  log "Installing required packages"
  apt-get update
  apt-get install -y --no-install-recommends \
    zsh \
    lsb-release \
    figlet \
    cron
}

install_default_shells() {
  local user_home="${HOME:-/root}"

  if [[ -f "${SCRIPT_DIR}/.vimrc" ]]; then
    log "Installing .vimrc to /etc/skel"
    install -m 0644 "${SCRIPT_DIR}/.vimrc" /etc/skel/.vimrc
    ln -sfn /etc/skel/.vimrc "${user_home}/.vimrc"
  fi

  if [[ -f "${SCRIPT_DIR}/.zshrc" ]]; then
    log "Installing .zshrc to /etc/skel"
    install -m 0644 "${SCRIPT_DIR}/.zshrc" /etc/skel/.zshrc
    ln -sfn /etc/skel/.zshrc "${user_home}/.zshrc"
  fi

  if [[ -d "${SCRIPT_DIR}/.zsh" ]]; then
    log "Installing .zsh directory to /etc/skel"
    rm -rf /etc/skel/.zsh
    cp -a "${SCRIPT_DIR}/.zsh" /etc/skel/.zsh
    ln -sfn /etc/skel/.zsh "${user_home}/.zsh"
  fi

  if command -v chsh >/dev/null 2>&1; then
    log "Setting default shell to zsh for root"
    chsh -s "$(command -v zsh)" root || true
  fi
}

configure_motd() {
  log "Configuring message of the day"
  mkdir -p /etc/update-motd.d

  find /etc/update-motd.d -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true

  if [[ -e /etc/motd ]]; then
    rm -f /etc/motd
  fi

  for file in 00-header 10-sysinfo 90-footer; do
    if [[ -f "${SCRIPT_DIR}/motd/${file}" ]]; then
      install -m 0755 "${SCRIPT_DIR}/motd/${file}" "/etc/update-motd.d/${file}"
    fi
  done
}

configure_updates_tool() {
  log "Installing update checker"
  mkdir -p /usr/local/bin/updates

  if [[ -f "${SCRIPT_DIR}/GetNumUpdates" ]]; then
    install -m 0700 "${SCRIPT_DIR}/GetNumUpdates" /usr/local/bin/updates/GetNumUpdates
  fi

  if [[ ! -f /usr/local/bin/updates/NumUpdates.txt ]]; then
    touch /usr/local/bin/updates/NumUpdates.txt
    chmod 0644 /usr/local/bin/updates/NumUpdates.txt
  fi

  local cron_line='0 0 * * * root /bin/sh /usr/local/bin/updates/GetNumUpdates'

  if ! grep -Fqx "$cron_line" /etc/crontab 2>/dev/null; then
    printf '%s\n' "$cron_line" >> /etc/crontab
  fi

  if command -v systemctl >/dev/null 2>&1; then
    systemctl restart cron 2>/dev/null || service cron restart 2>/dev/null || true
  else
    service cron restart 2>/dev/null || true
  fi
}

main() {
  ensure_packages
  install_default_shells
  configure_motd
  configure_updates_tool

  echo
  echo "Setup complete."
  echo "- zsh installed and default shell configured for root"
  echo "- dotfiles copied to /etc/skel"
  echo "- MOTD scripts installed in /etc/update-motd.d"
  echo "- update checker installed in /usr/local/bin/updates"
  echo "- cron entry added to /etc/crontab"
}

main "$@"
