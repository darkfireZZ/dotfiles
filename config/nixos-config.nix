{ config, pkgs, ... }:

let
  custom_dwm = pkgs.dwm.override {
    conf = builtins.readFile ./dwm-config.h;
  };
  custom_st = pkgs.st.override {
    conf = builtins.readFile ./st-config.h;
  };
in {
  imports = [
    <home-manager/nixos>
    /etc/nixos/hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      package = custom_dwm;
    };

    # Use Swiss german keyboard layout
    layout = "ch";
  };

  services.clipcat.enable = true;

  users.users.darkfire = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = [
      custom_st
      pkgs.dmenu
      pkgs.xclip
    ];
  };

  programs.slock.enable = true;

  home-manager.users.darkfire = import /home/darkfire/.dotfiles/config/home.nix;

  environment.systemPackages = [
    # have an editor available in case something goes horribly wrong
    pkgs.vim
    pkgs.xorg.xinit
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
