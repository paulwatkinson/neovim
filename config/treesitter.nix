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

  grammars = [
    (tree-sitter.buildGrammar {
      language = "nu";
      version = tree-sitter-nu.shortRev;
      src = tree-sitter-nu;
    })
  ];
}
