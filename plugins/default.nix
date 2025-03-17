{callPackage, ...} @ args: (
  builtins.foldl' (acc: module: acc // (callPackage module args)) {} [
    ./clangd-extensions.nix
    ./window-picker.nix
  ]
)
