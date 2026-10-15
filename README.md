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

## Setup from the latest GitHub release tarball

This repo automatically creates a GitHub Release on each push to `main`, with a tag like `main-abc1234` and a matching tarball name like `debian-main-abc1234.tar.gz`.

Install the latest auto-generated release like this:

```bash
wget -O /tmp/debian-setup.tar.gz \
  https://github.com/JSClinton/debian/releases/latest/download/debian-main-$(git ls-remote https://github.com/JSClinton/debian.git HEAD | cut -c1-7).tar.gz
mkdir -p /tmp/debian-setup
cd /tmp/debian-setup
tar -xzf /tmp/debian-setup.tar.gz --strip-components=1
chmod +x ./setup.sh
sudo ./setup.sh
```

If you prefer to install a specific release, replace the URL with the exact release asset you want.

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
