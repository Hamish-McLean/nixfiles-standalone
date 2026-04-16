# Disko file for 1000 GB SATA - data
{
  inputs,
  ...
}:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices.disk.data = {
    type = "disk";
    device = "/dev/disk/by-id/ata-WDC_WD1003FZEX-00K3CA0_WD-WCC6Y6TA8E3P"; # "/dev/sda";
    content = {
      type = "gpt";
      partitions.data = {
        size = "100%";
        content = {
          type = "btrfs";
          subvolumes = {
            "downloads" = {
              mountpoint = "/data/downloads";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
            "media" = {
              mountpoint = "/data/media";
              mountOptions = [ "noatime" ];
            };
            "games" = {
              mountpoint = "/data/games";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
            "steam" = {
              mountpoint = "/data/games/steam";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
            "minecraft" = {
              mountpoint = "/data/games/minecraft";
              mountOptions = [
                "noatime"
                "nodatacow" # Disable copy on write
              ];
            };
          };
        };
      };
    };
  };
}
