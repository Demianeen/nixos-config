{ pkgs }:

with pkgs; [
  # General packages for development and system management
  wezterm
  neovim
  aspell
  aspellDicts.en
  bash-completion
  btop
  coreutils
  killall
  fastfetch
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  k9s
  (pkgs.google-cloud-sdk.withExtraComponents
    (with pkgs.google-cloud-sdk.components; [
      gke-gcloud-auth-plugin
      kubectl
      minikube
    ]))

  # Media-related packages
  emacs-all-the-icons-fonts
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  jetbrains-mono
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  pnpm
  nodePackages.npm
  nodePackages.prettier
  nodejs

  # Text and terminal utilities
  difftastic
  yazi
  htop
  hunspell
  iftop
  jq
  ripgrep
  bat
  tree
  unrar
  unzip
  nixfmt-classic
  tokei

  # Python packages
  python39
  python39Packages.virtualenv
]
