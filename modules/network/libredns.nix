# LibreDNS
{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.network.libredns;
in
{
  options.custom.modules.network.libredns = {
    enable = mkEnableOption "Enable libredns";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = mkDefault true;
        dns = "default"; # "systemd-resolved";
      };
      # Force a static resolv.conf pointing strictly to the local stubby daemon
      # nameservers = [ "127.0.0.1" ];
    };

    # services.resolved = {
    #   enable = true;
    #   settings.Resolve = {
    #     DNS = [
    #       "116.202.176.26#noads.libredns.gr"
    #       "2a01:4f8:1c0c:8274::1#noads.libredns.gr"
    #     ];
    #     DNSOverTLS = "opportunistic"; # "opportunistic" will attempt to encrypt DNS
    #     DNSSEC = "allow-downgrade";
    #     Domains = [ "~." ]; # "~." for prefered catch-all, "." for authoritative
    #     FallbackDNS = [
    #       "1.1.1.1#one.one.one.one"
    #       "2606:4700:4700::1111#one.one.one.one"
    #       "1.0.0.1#one.one.one.one"
    #       "2606:4700:4700::1001#one.one.one.one"
    #     ];
    #   };
    # };
    services.resolved.enable = false;

    # services.tailscale.extraUpFlags = [ "--accept-dns=false" ];

    # Enable stubby to handle the DNS-over-TLS pipeline to LibreDNS
    # services.stubby = {
    #   enable = true;
    #   settings = {
    #     resolution_type = "GETDNS_RESOLUTION_STUB";
    #     dns_transport_list = [ "GETDNS_TRANSPORT_TLS" ]; # Force TLS exclusively
    #     tls_authentication = "GETDNS_AUTHENTICATION_REQUIRED"; # Reject fallback to plain text
    #
    #     # Listen locally on standard port 53 for applications and network tools
    #     listen_addresses = [ "127.0.0.1" ];
    #
    #     # Define your strict upstream DNS endpoints with their SNI hostnames
    #     # These are evaluated sequentially so later entries are fallback
    #     upstream_recursive_servers = [
    #       {
    #         address_data = "116.202.176.26";
    #         tls_auth_name = "noads.libredns.gr";
    #       }
    #       {
    #         address_data = "2a01:4f8:1c0c:8274::1";
    #         tls_auth_name = "noads.libredns.gr";
    #       }
    #       {
    #         address_data = "1.1.1.2";
    #         tls_auth_name = "cloudflare-dns.com";
    #       }
    #       {
    #         address_data = "9.9.9.9";
    #         tls_auth_name = "dns.quad9.net";
    #       }
    #     ];
    #   };
    # };
  };
}
