{ ... }:

{
  habitat.home = {
    cli = {
      bash.enable = true;
      gh.enable = true;
    };
    desktop = {
      niri = {
        enable = true;
        keyboardLayout = "gb";
        outputs = {
          "DP-1" = {
            mode = {
              width = 2560;
              height = 1600;
              refresh = 60.0;
            };
          };
        };
      };
    };
  };

  home.stateVersion = "24.05";
}
