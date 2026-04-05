{
  inputs,
  ...
}:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices.disk = {
    # 500 GB M.2 - system
    system = {
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
    # 1000 GB SATA - data
    data = {
      type = "disk";
      device = "/dev/disk/by-id/ata-WDC_WD1003FZEX-00K3CA0_WD-WCC6Y6TA8E3P"; # "/dev/sda";
      content = {
        type = "gpt";
        partitions.data = {
          size = "100%";
          content = {
            type = "btrfs";
            subvolumes = {
              "/steam" = {
                mountpoint = "/mnt/games";
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
  };
}
