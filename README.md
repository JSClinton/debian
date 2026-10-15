# Debian base setup

This repository contains a small Debian setup bundle for creating a base server environment. It includes shell config, MOTD scripts, and an update counter used by the system message of the day.

## Included files

- `.vimrc` – Vim configuration for the base environment
- `.zshrc` – Zsh startup config
- `.zsh/` – custom Zsh config directory loaded by `.zshrc`
- `GetNumUpdates` – script that checks how many packages are available for upgrade
- `motd/00-header` – MOTD header
- `motd/10-sysinfo` – MOTD system info section
- `motd/90-footer` – MOTD footer
- `setup.sh` – script that installs the base configuration on a new Debian machine

## Setup script

Run this on a fresh Debian system:

```bash
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/JSClinton/debian/main/setup.sh)"
```

Or save it locally first:

```bash
wget -O setup.sh https://raw.githubusercontent.com/JSClinton/debian/main/setup.sh
sudo bash ./setup.sh
```

## What the script does

- installs `zsh`, `lsb-release`, `figlet`, and `cron`
- copies `.vimrc`, `.zshrc`, and `.zsh` into `/etc/skel`
- sets root to use `zsh` as the default shell
- creates `/etc/update-motd.d` and installs the MOTD scripts
- removes any existing MOTD files in that directory
- installs the update count script to `/usr/local/bin/updates`
- adds a daily cron entry to `/etc/crontab`

## Notes

- The script expects to be run as root via `sudo`.
- The `motd` scripts are intended for Debian systems using `/etc/update-motd.d`.
- The update checker writes its output to `/usr/local/bin/updates/NumUpdates.txt` and reads from that file in the sysinfo MOTD script.
