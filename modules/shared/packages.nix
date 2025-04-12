{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  neovim
  neovim-remote
  aspell
  aspellDicts.en
  bash-completion
  btop
  coreutils-full
  killall
  fastfetch
  openssh
  wget
  zip
  mpv
  postgresql
  pgcli
  aichat

  # Encryption and security tools
  age
  age-plugin-yubikey
  yubikey-manager
  gnupg
  libfido2
  gitleaks

  # Cloud-related tools and SDKs
  k9s
  (pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
      kubectl
      minikube
    ]
  ))

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  jetbrains-mono
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Text and terminal utilities
  difftastic
  delta
  htop
  hunspell
  iftop
  ripgrep
  tree
  unrar
  unzip
  nixfmt-rfc-style
  tokei
  fh
  lazydocker
  cmatrix
  sd
  jq
  yq
  # xq-xml
  entr
  rsync
  speedtest-cli
  silicon
  gobang

  # yazi plugins
  clipboard-jh
  glow

  # tui
  sshs
  discordo

  # rust
  rustup

  # Node.js development tools
  nodejs
  nodePackages.npm
  nodePackages.prettier
  pnpm
  nest-cli

  # Python packages
  python312
  python312Packages.virtualenv
  poetry

  # TODO: This is just for rest.nvim luarocks package. It is better to isolate it with nvim
  (pkgs.lua5_1.withPackages (
    ps: with ps; [
      luarocks
    ]
  ))
]
