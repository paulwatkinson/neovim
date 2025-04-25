{
  nvim-web-devicons.enable = true;
  nvim-scrollbar.enable = true;

  fidget-nvim = {
    enable = false;
    setupOpts = {
      notification.window = {
        winblend = 20;
        border = "none";
      };
    };
  };

  indent-blankline = {
    enable = true;
    setupOpts = {
      indent.char = "┊";
      scope = {
        char = "│";
        enabled = true;
        show_start = false;
        show_end = false;
      };
    };
  };
}
