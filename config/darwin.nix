{ pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  environment.darwinConfig = "$HOME/.dotfiles/config/darwin.nix";

  homebrew = {
    enable = true;
    casks = [
      "veracrypt"
      "keepassxc"
      "kitty"
    ];
  };
  
  users.users.darkfire = {
    name = "darkfire";
    home = "/Users/darkfire";
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  home-manager.users.darkfire = import /Users/darkfire/.dotfiles/config/home.nix;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
