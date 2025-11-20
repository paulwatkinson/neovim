{
  self',
  vimPlugins,
  ...
}: {
  enable = true;

  context = {
    enable = true;
    setupOpts = {
      separator = null;
      max_lines = 6;
    };
  };

  grammars = with vimPlugins.nvim-treesitter.builtGrammars; [
    diff
    just

    self'.packages.tree-sitter-alloy
  ];
}
