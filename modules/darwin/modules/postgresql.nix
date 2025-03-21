{ pkgs, config, ... }:

let
  user = "demian";
  dataDir = "/var/lib/postgresql/17";
in
{
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
      dataDir = dataDir;
      settings = {
        log_connections = true;
      };
      # initdbArgs = [
      #   "-U ${user}"
      #   "--pgdata=${dataDir}"
      #   "--auth=trust"
      #   "--no-locale"
      #   "--encoding=UTF8"
      # ];
      ensureDatabases = [ "demian" ];
      ensureUsers = [
        {
          name = "demian";
          ensurePermissions = {
            "DATABASE demian" = "ALL PRIVILEGES";
          };
        }
      ];
      authentication = ''
        # Local and TCP access with no password (dev only!)
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
      '';
    };
  };

  # Create the PostgreSQL data directory, if it does not exist.
  # system.activationScripts.preActivation = {
  #   enable = true;
  #   text = ''
  #     if [ ! -d "${dataDir}" ]; then
  #       echo "creating PostgreSQL data directory..."
  #       mkdir -m 750 -p ${dataDir}
  #       chown -R ${user}:staff ${dataDir}
  #     fi
  #   '';
  # };

  # Direct output for debugging
  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/tmp/postgres.error.log";
    StandardOutPath = "/tmp/postgres.log";
  };
}
