{ config, pkgs, copyparty, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix # impure
    ./UEFI.nix
  ];

  nixpkgs.overlays = [ copyparty.overlays.default ];

  system.activationScripts = {
    jonathanfacl = {
      text = ''
        # Fix syncthing running on folders in home directory
        ${pkgs.acl}/bin/setfacl -m m::r-x /home/jonathan
      '';
    };
  };

  nix = {
    gc = {
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.trusted-users = [ "@wheel" ];
  };
  system.autoUpgrade = {
    operation = "switch";
    dates = "03:00";
    allowReboot = true;
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
  };

  boot.loader = {
    timeout = 5;
    systemd-boot.configurationLimit = 10;
    efi.efiSysMountPoint = "/boot/efi";
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  networking = {
    hostName = "base"; # Define your hostname.
    networkmanager.enable = false;
    useDHCP = false;
    bridges."br0".interfaces = [ "enp1s0" ];

    interfaces = {
      br0.ipv4.addresses = [
        {
          address = "192.168.1.215";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [
      "172.64.36.1"
      "172.64.36.2"
    ]; # Cloudflare

    firewall = {
      checkReversePath = "loose";
      # 22 ssh, 53 dns, 80/443 nginx, 5357 wsdd
      allowedTCPPorts = [
        22
        53
        80
        443
        5357
      ];
      # 53 dns, 3702 wsdd
      allowedUDPPorts = [
        53
        3702
      ];
    };
  };

  users = {
    groups.backup.members = [
      "aidan"
      "jonathan"
    ];

    users = {
      jonathan.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCq1pz3ZqG8/lKjQrHGcoaTWjJQNZtWwU9EYBm5v+D/JvBDhdGLgA63B9gddOUMN9eM9w6d41PNG3eDEOCu1TOqBglg0AUEWS7XkqtmjheAnmpY2fqYxKplWN3HkPAh5qSLyUMcca5ZZaEnweWPdoY/U6HCPZmJfC4/Uj4j/Z8eCEPrPZNxp8nbu6ftztpZu7by9Y1ojniPc14Li94bnajtn3yXUzoCJDmzuuU3mE5jUPYwYURr1LyXRkd08XJsZupTxL4IazPruzTCEFTvIkoUubDCeJ0zJAB/4HbbuV5rM5JV4/EWGOgAj0p+Wp/F8EEEskdS4FSiiOBV5fNZcBvuVM9SzxFz3qIYSKPOFx8Owm2bDGhNnWp3gnH3YX++GxRfmDNw7C9MJBQqvcnEJC0I9zTP1tItzOORCehh29XYRG0U+Wg5okpjdLth7Hhi2w3/CtYACwr4+7FWSSX5A0cqNMoBGWqOGROWMOpaZ1d8xEsbGr9/eN83y38Mx3gbR7s= jonathan@hnaubox"
      ];

      backup = {
        isSystemUser = true;
        group = "backup";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    cloudflared
    btop
    ffmpeg # for copyparty

    # discord bot
    (python313.withPackages (ps: with ps; [ requests ]))
  ];

  services = {
    beesd.filesystems = {
      Data1 = {
        spec = "LABEL=Data1";
        verbosity = "err";
      };
    };

    openssh.enable = true;

    tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };

    syncthing.enable = true;

    jellyfin = {
      enable = true;
    };

    technitium-dns-server = {
      enable = true;
    };

    immich = {
      enable = true;
      port = 3001;
    };

    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "nc.bennett.place";
      https = true;
      configureRedis = true;
      config = {
        adminuser = "nextcloud";
        adminpassFile = "/var/lib/nextcloud/adminpass";
        dbtype = "sqlite";
      };
      settings = {
        trusted_domains = [
          "192.168.1.215"
          "base"
        ];
        default_phone_region = "US";
      };
    };

    actual = {
      enable = true;
      settings.port = 3002;
    };

    nginx = {
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      clientMaxBodySize = "50000m";

      virtualHosts = {
        "sso.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations = {
            "/" = {
              proxyPass = "https://localhost:3005";
            };
          };
        };

        ${config.services.nextcloud.hostName} = {
          forceSSL = true;
          useACMEHost = "bennett";
        };

        "jf.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations = {
            "/" = {
              proxyPass = "http://localhost:8096";
              proxyWebsockets = true;
            };
          };
        };

        "img.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations = {
            "/" = {
              proxyPass = "http://localhost:3001";
              proxyWebsockets = true;
            };
          };
        };

        "dns.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/" = {
            proxyPass = "http://localhost:5380";
          };
        };

        "bgt.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/".proxyPass = "http://localhost:3002";
        };

        "ls.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/".proxyPass = "http://localhost:3210";
        };
      };
    };

    cloudflared = {
      enable = true;
      tunnels."home" = {
        credentialsFile = "/var/lib/cloudflared/tunnel.json";
        default = "http_status:404";
        ingress = {
          "nc.bennett.place" = "https://nc.bennett.place";
          "jf.bennett.place" = "https://jf.bennett.place";
          "img.bennett.place" = "https://img.bennett.place";
          "sso.bennett.place" = "https://sso.bennett.place";
        };
      };
    };

    samba-wsdd.enable = true; # make shares visible for windows 10 clients
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "BASE";
          "netbios name" = "BASE";
          security = "user";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "backup" = {
          "path" = "/backup";
          "browseable" = "yes";
          "read only" = "yes";
          "guest ok" = "yes";
          "guest only" = "yes";
          "force user" = "backup";
          "force group" = "backup";
        };
      };
    };

    postfix.enable = true;

    cron = {
      enable = true;
      systemCronJobs = [
        "0 * * * * /var/lib/cloudflared/update_dns_location.py"
      ];
    };

    keycloak = {
      enable = true;
      settings = {
        hostname = "sso.bennett.place";
        http-port = 3004;
        https-port = 3005;
        proxy-headers = "xforwarded";
      };
      database = {
        type = "postgresql";
        passwordFile = "/var/src/secrets/keycloakDatabasePassword";
      };
      sslCertificate = "/var/lib/acme/bennett/fullchain.pem";
      sslCertificateKey = "/var/lib/acme/bennett/key.pem";
    };

    copyparty = {
      enable = true;
      settings = {
        i = "0.0.0.0";
        p = [ 3210 ];
        z = true; # enable zeroconf
        ed = true; # show dotfiles
        rproxy = 1; # use nginx header for ip
        http-only = true; # disable native https
        #idp-... # enable keycloak integration
        e2d = true; # enable up2k database for file search
        e2dsa = true; # rescan all folders on startup
        au-vol = 100; # set audio volume to 100% by default
        hist = "/var/lib/copyparty"; # set database location
      };

      volumes = {
        "/" = {
          path = "/backup";
          access = {
            r = "*";
          };
        };

        "/audio" = {
          path = "/backup/Audio";
          access = {
            r = "*";
          };
          flags = {
            e2t = true; # enable metadata indexing/searching
            e2ts = true; # enable scanning new files for metadata
          };
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@bennett.place";
    certs.bennett = {
      domain = "*.bennett.place";
      dnsProvider = "cloudflare";
      credentialsFile = "/var/src/secrets/acme_cloudflare_auth";
      group = config.services.nginx.group;
    };
  };

  systemd.services.discordAssociate = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "highlights only Discord bot";
    serviceConfig = {
      WorkingDirectory = "/home/aidan/Documents/highlights";
      ExecStart =
        let
          python = pkgs.python3.withPackages (ps: with ps; [ discordpy ]);
        in
        "${python.interpreter} /home/aidan/Documents/highlights/highlights.py";
      Restart = "always";
    };
  };

  system.stateVersion = "22.05";
}
