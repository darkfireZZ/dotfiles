{ config, pkgs, ... }:

let
  peckycheese = import ./peckycheese.nix { inherit pkgs; };
in {
  imports = [
    <home-manager/nixos>
    /etc/nixos/hardware-configuration.nix
  ];

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    # TODO: don't hardcode this path
    "nixos-config=/home/darkfire/.dotfiles/nix/nixos-config.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "diogfen";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  console = {
    font = "sun12x22";
    keyMap = "de_CH-latin1";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    displayManager.startx.enable = true;
    windowManager.dwm = {
      enable = true;
      package = peckycheese.dwm;
    };

    # Use Swiss german keyboard layout
    layout = "ch";
  };

  services.clipcat.enable = true;

  users.users.darkfire = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = [
      pkgs.xclip
    ];
  };

  programs.slock.enable = true;

  home-manager.users.darkfire = import /home/darkfire/.dotfiles/nix/home.nix;

  environment.systemPackages = [
    # have an editor available in case something goes horribly wrong
    pkgs.vim
    pkgs.xorg.xinit
  ];

  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}

