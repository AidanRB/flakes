{
  config,
  pkgs,
  copyparty,
  lib,
  ...
}:

{
  networking = {
    firewall = {
      allowedTCPPorts = [
        # 8124 # going to start switching to home-assistant native nixos module
      ];
    };
  };

  services = {
    nginx = {
      virtualHosts = {
        "ha.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/" = {
            proxyPass = "http://localhost:8123";
            proxyWebsockets = true;
          };
        };

        "zw.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/" = {
            proxyPass = "http://10.88.0.2:8091";
            proxyWebsockets = true;
          };
        };

        "zb.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/" = {
            proxyPass = "http://localhost:8080";
            proxyWebsockets = true;
          };
        };

        "esp.bennett.place" = {
          forceSSL = true;
          useACMEHost = "bennett";
          locations."/" = {
            proxyPass = "http://10.88.0.3:6052";
            proxyWebsockets = true;
          };
        };
      };
    };

    cloudflared = {
      enable = true;
      tunnels."home" = {
        ingress = {
          "ha.bennett.place" = "https://ha.bennett.place";
        };
      };
    };

    zigbee2mqtt = {
      enable = true;
      settings = {
        serial = {
          port = "tcp://192.168.1.75:6638";
          adapter = "ember";
        };
        homeassistant = lib.mkForce true;
        permit_join = true;
        frontend = true;
      };
    };

    mosquitto = {
      enable = true;
      listeners = [
        {
          acl = [ "pattern readwrite #" ];
          omitPasswordAuth = true;
          settings.allow_anonymous = true;
        }
      ];
    };

    wyoming = {
      faster-whisper.servers.base = {
        enable = true;
        zeroconf.enable = true;
        uri = "tcp://0.0.0.0:10300";
        model = "tiny.en";
        language = "en";
      };

      piper.servers.base = {
        enable = true;
        zeroconf.enable = true;
        uri = "tcp://0.0.0.0:10200";
        voice = "en_US-lessac-high";
      };
    };
  };

  virtualisation.oci-containers.containers = {
    "homeassistant" = {
      autoStart = true;
      image = "ghcr.io/home-assistant/home-assistant:stable";
      volumes = [
        "home-assistant:/config"
        "/etc/localtime:/etc/localtime:ro"
      ];
      extraOptions = [
        "--network=host"
      ];
    };

    "zwave" = {
      autoStart = true;
      image = "zwavejs/zwave-js-ui";
      volumes = [
        "zwave-data:/usr/src/app/store"
      ];
      extraOptions = [
        "--device=/dev/serial/by-id/usb-Zooz_800_Z-Wave_Stick_533D004242-if00"
      ];
      networks = [
        "podman:ip=10.88.0.2"
      ];
    };

    "esphome" = {
      autoStart = true;
      image = "ghcr.io/esphome/esphome";
      volumes = [
        "esphome-data:/config"
        "/etc/localtime:/etc/localtime:ro"
      ];
      networks = [
        "podman:ip=10.88.0.3"
      ];
      environment.ESPHOME_DASHBOARD_USE_PING = "true";
      capabilities.NET_RAW = true;
    };
  };
}
