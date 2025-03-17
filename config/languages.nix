_: {
  enableDAP = true;
  enableLSP = true;
  enableFormat = true;
  enableTreesitter = true;
  enableExtraDiagnostics = true;

  clang = {
    enable = true;
    # dap.package = pkgs.lldb_17;
  };

  rust = {
    enable = true;

    crates = {
      enable = true;
      codeActions = true;
    };
  };

  ts = {
    enable = true;
    extensions.ts-error-translator.enable = false;
  };

  java = {
    enable = true;

    # Handled by `nvim-jdtls`
    lsp.enable = false;

    treesitter.enable = true;
  };

  bash.enable = true;
  html.enable = true;
  nix.enable = true;
  python.enable = true;
  zig.enable = true;

  sql = {
    enable = true;
    extraDiagnostics.enable = true;
  };
}
