{plugin-nvim-surround, ...}: {
  nvim-surround = {
    package = {
      name = "nvim-surround";
      src = plugin-nvim-surround;
      type = "derivation";
    };

    setup =
      # lua
      ''require('nvim-surround').setup({});'';
  };
}
