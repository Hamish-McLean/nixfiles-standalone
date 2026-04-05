{
  inputs,
  ...
}:
{
  imports = [ inputs.disko.nixosModules.disko ];

  disko.devices.disk = {
    # 500 GB M.2 - system
    system = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions.ESP = {
          size = "8G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        partitions.root = {
          size = "100%";
          content = {
            type = "btrfs";
            subvolumes = {
              "/root" = { mountpoint = "/"; mountOptions = [ "compress=zstd" "noatime" ]; };
              "/nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
              "/home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd" "noatime" ]; };
            };
          };
        };
      };
    };
    # 1000 GB SATA - data
    data = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions.data = {
          size = "100%";
          content = {
            type = "btrfs";
            subvolumes = {
              "/steam" = { mountpoint = "/mnt/games"; mountOptions = [ "compress=zstd" "noatime" ]; };
            };
          };
        };
      };
    };
  };
}
