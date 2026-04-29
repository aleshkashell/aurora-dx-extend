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
rpm --import http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG

dnf5 install -y \
  ImageMagick \
  NetworkManager-wifi \
  SwayNotificationCenter \
  alsa-sof-firmware \
  alsa-utils \
  bc \
  blueman \
  brightnessctl \
  btop \
  cava \
  cliphist \
  curl \
  dua-cli \
  duf \
  fastfetch \
  figlet \
  findutils \
  fzf \
  gawk \
  git \
  gnome-system-monitor \
  grim \
  gum \
  gvfs \
  gvfs-mtp \
  helix \
  hypridle \
  hyprland \
  hyprlock \
  hyprpaper \
  hyprpicker \
  hyprpolkitagent \
  hyprsunset \
  hyprsysteminfo \
  inxi \
  iwl* \
  jq \
  kitty \
  kvantum \
  kvantum-qt5 \
  loupe \
  mousepad \
  mpv \
  mpv-mpris \
  nano \
  nautilus \
  network-manager-applet \
  nm-connection-editor-desktop \
  nvtop \
  nwg-displays \
  nwg-look \
  openssl \
  pamixer \
  pamixer \
  pavucontrol \
  pipewire-alsa \
  pipewire-utils \
  playerctl \
  pulseaudio-utils \
  python3-pip \
  python3-pyquery \
  python3-requests \
  qalculate-gtk \
  qemu-user-static \
  qt5-qtdeclarative \
  qt5-qtquickcontrols2 \
  qt5ct \
  qt6-qtdeclarative \
  qt6-qtsvg \
  qt6ct \
  ripgrep \
  rofi \
  rsync \
  slurp \
  swappy \
  swww \
  tuned \
  tuned-ppd \
  unzip \
  uwsm \
  wallust \
  waybar \
  wget2 \
  wl-clipboard \
  wlogout \
  xdg-desktop-portal-hyprland \
  xdg-user-dirs \
  xdg-utils \
  yad \
  yazi \
  yq

installFromUrl() {
  wget $1
  rpm -ivh --nodigest --nofiledigest ${1##*/}
  rm ${1##*/}
}
# Printer package
installFromUrl https://raw.githubusercontent.com/aleshkashell/binaries/refs/heads/master/rpm/epson-inkjet-printer-escpr-1.8.6-1.x86_64.rpm
# Yandex disk
installFromUrl http://repo.yandex.ru/yandex-disk/yandex-disk-latest.x86_64.rpm

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
