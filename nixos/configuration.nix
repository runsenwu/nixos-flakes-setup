{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # electron app
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  services.getty.autologinUser = "mega_wu";

  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.enable = false;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32bit = true;
  # };

  hardware.graphics.enable = true;

  # Enable bluetooh
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  hardware.pulseaudio.enable = false;

  hardware.alsa.enablePersistence = true; # optional but recommended

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = false;
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "mega_wu" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  environment.shells = [
    pkgs.nushell
  ];

  users.users.mega_wu = {
    isNormalUser = true;
    description = "mega_wu";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.niri = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  boot.kernelParams = [
    "quiet"
    "splash"
    # "console=/dev/null"
  ];
  boot.plymouth.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "niri";
      # command = "${pkgs.gamescope}/bin/gamescope -W 5120 -H 2160 -f -e --xwayland-count 2 --hdr-enabled --hdr-itm-enabled -- steam -pipewire-dmabuf -gamepadui > /dev/null 2>&1";
      user = "mega_wu";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # essentials
    helix
    git
    curl
    rio
    pciutils # for lspci
    usbutils # for lsusb

    # command line tools
    tealdeer
    xclip
    bat
    neofetch

    # for niri
    fuzzel
    xwayland-satellite

    # Language supports
    omnisharp-roslyn

    # test
    discord

    pulseaudio
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
