{lib, ...}: {
  borders = {
    enable = true;
    globalStyle = "single";
  };

  noice.enable = true;
  colorizer.enable = true;

  fastaction = {
    enable = true;
    setupOpts.register_ui_select = lib.mkForce false;
  };
}
