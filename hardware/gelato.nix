{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix # impure
    ./UEFI.nix
  ];

  networking.hostName = "gelato"; # Define your hostname.

  services = {
    printing.enable = true;

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  # fix for https://gitlab.freedesktop.org/mesa/mesa/-/issues/11429
  # boot.extraModprobeConfig = ''
  #   options i915 reset=1 enable_dc=0 enable_psr=0 enable_fbc=0
  #   options intel_idle max_cstate=1
  # '';

  environment.variables = {
    INTEL_DEBUG = "reemit,capture-all";
  };

  # systemd.services."intel-gpu-frequency-max" = {
  #   description = "Set iGPU frequency to max";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.intel-gpu-tools}/bin/intel_gpu_frequency -m";
  #     RemainAfterExit = true;
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  system.stateVersion = "24.05";
}
