{ pkgs, config, ... }:

let user = "demian";
in {
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      settings = { log_connections = true; };
      initdbArgs = [
        "-U ${user}"
        "--pgdata=/var/lib/postgresql/15"
        "--auth=trust"
        "--no-locale"
        "--encoding=UTF8"
      ];
      # dataDir = /. + "/var/lib/postgresql/"; # Default value
    };
  };

  # Create the PostgreSQL data directory, if it does not exist.
  system.activationScripts.preActivation = {
    enable = true;
    text = ''
      if [ ! -d "/var/lib/postgresql/15/" ]; then
        echo "creating PostgreSQL data directory..."
        sudo mkdir -m 750 -p /var/lib/postgresql/15/
        chown -R ${user}:staff /var/lib/postgresql/15/
      fi
    '';
  };

  # Direct output for debugging
  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/tmp/postgres.error.log";
    StandardOutPath = "/tmp/postgres.log";
  };
}
