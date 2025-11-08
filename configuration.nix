{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  services.getty.autologinUser = "mega_wu";

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;
  hardware.graphics.enable = true;

  # Enable bluetooh
  hardware.bluetooth.enable = true;
  
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
 };

 users.users.mega_wu = {
    isNormalUser = true;
    shell = pkgs.bashInteractive;
    description = "mega_wu";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.niri = {
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "niri";
      user = "mega_wu";
    };
  };


  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  #   withUWSM = true;
  # };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # essentials
    helix  git  curl  rio

    # command line tools
    tealdeer  xclip  bat  neofetch

    # for hyprland
    # waybar  hyprpaper  kitty
 ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  
 # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
