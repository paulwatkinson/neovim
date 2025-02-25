{vimPlugins, ...}: {
  nvim-window-picker = {
    package = vimPlugins.nvim-window-picker;
    setup =
      # lua
      ''require('window-picker').setup({ hint = 'floating-big-letter' });'';
  };
}
