{callPackage, ...} @ args: (
  builtins.foldl' (acc: module: acc // (callPackage module args)) {} [
    ./fastaction-keymap.nix
    ./filetype-nu.nix
    ./inlay-hints.nix
    ./treesitter-context-hl.nix
    ./indents.nix
  ]
)
