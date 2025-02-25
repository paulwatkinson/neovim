{callPackage, ...} @ args: (
  builtins.foldl' (acc: module: acc // (callPackage module args)) {} [
    ./clangd-extensions.nix
    ./tree-sitter-nu.nix
    ./window-picker.nix
    ./nvim-surround.nix
  ]
)
