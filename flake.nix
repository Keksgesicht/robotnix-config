{
  description = "robotnix configuration";

  inputs = {
    # https://docs.robotnix.org/
    # https://github.com/nix-community/robotnix
    robotnix.url = "github:nix-community/robotnix";
  };

  outputs = {
    self,
    robotnix,
  }@inputs: {
    robotnixConfigurations = {
      "Fairphone4" = robotnix.lib.robotnixSystem ({ config, pkgs, ... }: {
        device = "FP4";
        flavor = "lineageos";

        # buildDateTime is set by default by the flavor, and is updated when those flavors have new releases.
        # If you make new changes to your build that you want to be pushed by the OTA updater, you should set this yourself.
        # buildDateTime = 1584398664; # Use `date "+%s"` to get the current time

        # signing.enable = true;
        # signing.keyStorePath = "/var/secrets/android-keys"; # A _string_ of the path for the key store.

        # Build with ccache
        # ccache.enable = true;
      });

      "Xiaomi-Redmi-Note9" = robotnix.lib.robotnixSystem ({ config, pkgs, ... }: {
        # These two are required options
        device = "merlinx";
        flavor = "lineageos";
      });
    };

    # "nix build .#robotnixConfigurations.<name>.ota"
    defaultPackage.x86_64-linux = self.robotnixConfigurations."Fairphone4".img;
  };
}
