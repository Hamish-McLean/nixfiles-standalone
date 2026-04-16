# Disko file for 500 GB M.2 - system
{
  inputs,
  ...
}:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices.disk.system = {
    device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_500GB_S466NB0K406614N"; # "/dev/nvme0n1";
    type = "disk";
    content = {
      type = "gpt";
      partitions.ESP = {
        size = "4G";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };
      partitions.swap = {
        size = "8G";
        content = {
          type = "swap";
          discardPolicy = "both";
        };
      };
      partitions.root = {
        size = "100%";
        content = {
          type = "btrfs";
          subvolumes = {
            "root" = {
              mountpoint = "/";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
            "nix" = {
              mountpoint = "/nix";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
            "home" = {
              mountpoint = "/home";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
          };
        };
      };
    };
  };
}
