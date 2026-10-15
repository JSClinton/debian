# Debian base setup

This repository contains a small Debian setup bundle for creating a base server environment. It includes shell config, MOTD scripts, and an update counter used by the system message of the day.

```
     _      _     _             _            _
  __| | ___| |__ (_) __ _ _ __ | |_ ___  ___| |_
 / _` |/ _ \ '_ \| |/ _` | '_ \| __/ _ \/ __| __|
| (_| |  __/ |_) | | (_| | | | | ||  __/\__ \ |_
 \__,_|\___|_.__/|_|\__,_|_| |_|\__\___||___/\__|


Welcome to Debian GNU/Linux 13 (trixie) (6.12.111+deb13-amd64).

System information as of: Thu Oct 15 11:41:01 EDT 2026

System load:    0.07    IP Address:     10.1.2.250
Memory usage:   11.7%   System uptime:  2 min
Usage on /:     3%      Swap usage:     0.0%
Local Users:    4       Processes:      109

 packages can be updated.

Last login: Thu Oct 15 11:39:04 2026 from 10.1.2.27
```

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

This repo automatically creates a GitHub Release on each push to `main`.

The release asset is always named:

```bash
debian-main.tar.gz
```

Install it like this, without installing `git`:

```bash
wget -O /tmp/debian-setup.tar.gz \
  https://github.com/JSClinton/debian/releases/latest/download/debian-main.tar.gz
mkdir -p /tmp/debian-setup
cd /tmp/debian-setup
tar -xzf /tmp/debian-setup.tar.gz --strip-components=1
chmod +x ./setup.sh
sudo ./setup.sh
```

If you prefer a specific release, open the GitHub Releases page and download the asset you want.

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
