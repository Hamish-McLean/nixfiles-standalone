# Radagast
_: {
  custom.profiles = {
    core.enable = true;
    desktop.enable = true;
    gaming.enable = true;
  };

  custom.modules = {
    desktop.sunshine.enable = true;
    hardware.nvidiaGTX1080.enable = true;
    network.wakeOnLan.enable = true;
  };

  boot.loader.limine.enable = true;

  networking.hostName = "Radagast";

  system.stateVersion = "25.11";
}
