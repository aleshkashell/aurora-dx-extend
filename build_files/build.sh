#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 copr enable sdegler/hyprland -y
dnf5 copr enable lihaohong/yazi -y

echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' > /etc/yum.repos.d/charm.repo
rpm --import https://repo.charm.sh/yum/gpg.key

dnf5 install -y \
  NetworkManager-wifi \
  alsa-sof-firmware \
  alsa-utils \
  blueman \
  dua-cli \
  duf \
  figlet \
  fzf \
  gum \
  gvfs \
  gvfs-mtp \
  hypridle \
  hyprland \
  hyprlock \
  hyprpaper \
  hyprpicker \
  hyprpolkitagent \
  hyprsunset \
  hyprsysteminfo \
  iwl* \
  jq \
  kitty \
  nautilus \
  nm-connection-editor-desktop \
  pavucontrol \
  qemu-user-static \
  ripgrep \
  tuned \
  tuned-ppd \
  uwsm \
  waybar \
  xdg-desktop-portal-hyprland \
  yazi \
  yq
# Printer package
# https://raw.githubusercontent.com/aleshkashell/binaries/refs/heads/master/rpm/epson-inkjet-printer-escpr-1.8.6-1.x86_64.rpm

dnf5 copr disable sdegler/hyprland -y
dnf5 copr disable lihaohong/yazi -y
rm /etc/yum.repos.d/charm.repo
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
