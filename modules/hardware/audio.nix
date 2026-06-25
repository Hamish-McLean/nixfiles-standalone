{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.hardware.audio;
in
{
  options.custom.modules.hardware.audio = {
    enable = mkEnableOption "Pipewire audio stack";
    enable32Bit = mkOption {
      default = true;
      description = "Enable 32-bit audio support (crucial for Steam/gaming).";
      type = lib.types.bool;
    };
  };

  config = mkIf cfg.enable {
    # Real-time kit for audio processing priority (prevents audio stuttering)
    security.rtkit.enable = mkDefault true;

    # Explicitly ensure legacy PulseAudio daemon doesn't conflict
    services.pulseaudio.enable = mkDefault false;

    # Core Pipewire architecture
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = cfg.enable32Bit;
      pulse.enable = true;

      # Modern session manager (required for audio routing and volume controls)
      wireplumber.enable = mkDefault true;
    };

    # Optional: Adds standard user space audio control tools globally
    environment.systemPackages = [
      pkgs.pulsemixer # Terminal audio mixer
    ];
  };
}
