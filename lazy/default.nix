{callPackage, ...} @ args: (
  builtins.foldl' (acc: module: acc // (callPackage module args)) {} [
    ./nvim-jdtls
    ./CopilotChat.nvim
  ]
)
