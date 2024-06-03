{ config, pkgs, user, ... }:

{
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = [ "lasan" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
