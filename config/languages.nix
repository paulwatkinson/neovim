{prettierd, ...}: {
  enableDAP = true;
  enableFormat = true;
  enableTreesitter = true;
  enableExtraDiagnostics = true;

  bash.enable = true;
  csharp.enable = true;
  clojure.enable = true;
  html.enable = true;
  lua.enable = true;
  nix.enable = true;
  python.enable = true;
  zig.enable = true;

  css = {
    enable = true;
    format.package = prettierd;
  };

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
    format.package = prettierd;
    extensions.ts-error-translator.enable = false;
  };

  java = {
    enable = true;

    # Handled by `nvim-jdtls`
    lsp.enable = false;

    treesitter.enable = true;
  };

  sql = {
    enable = true;
    extraDiagnostics.enable = true;
  };

  nu = {
    enable = true;
    lsp.enable = true;
  };
}
