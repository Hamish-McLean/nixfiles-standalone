/*
  NixOS module for lenny's 06cb-009a fingerprint sensor.
  From: https://github.com/ahbnr/nixos-06cb-009a-fingerprint-sensor
*/
{
  inputs,
  ...
}:
{
  # First, setup fprintd and enroll fingerprints
  # imports = [
  #   lenny-fingerprint.nixosModules.open-fprintd
  #   lenny-fingerprint.nixosModules.python-validity
  # ];

  # services.open-fprintd.enable = true;
  # services.python-validity.enable = true;

  # Second, comment out the above to remove fprintd and rebuild

  # Third, install fprintd from nixpkgs using the custom driver
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = inputs.lenny-fingerprint.lib.libfprint-2-tod1-vfs0090-bingch {
        calib-data-file = ./calib-data.bin;
      };
    };
  };

  # Finally, rebuild system and start fprintd
  # It might need to be restarted: `systemctl restart fprintd`
  # Use `fprintd-enroll` to enroll fingerprints again
}
