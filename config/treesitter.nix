{
  # inputs
  tree-sitter-nu,

  # packges
  tree-sitter,
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
}
