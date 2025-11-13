{
  pkgs,
  lib,
  nvf,
  ...
}: let
  inherit (nvf.lib.nvim.dag) entryAfter entryAnywhere;
in {
  pluginRC.nvim-lint-checkstyle =
    entryAfter ["nvim-lint"]
    # lua
    ''
      local function configure_plugin_lint()
        local plugin_lint = require("lint");
        local java_root = vim.fs.root(0, {'.git', 'mvnw', 'gradlew', 'build.xml', 'pom.xml'});

        if java_root ~= nil and vim.uv.fs_stat(java_root .. '/checkstyle.xml') then
          plugin_lint.linters.checkstyle.config_file = java_root .. '/checkstyle.xml';
          plugin_lint.linters_by_ft.java = {
            'checkstyle'
          };
        end
      end

      configure_plugin_lint();
    '';

  startPlugins = ["mini-pick"];

  pluginRC.mini-pick =
    entryAnywhere
    # lua
    ''
      vim.ui.select = require('mini.pick').ui_select;
    '';

  lsp.lspconfig.sources.openscad =
    # lua
    ''
      lspconfig.openscad_lsp.setup {
        capabilities = capabilities,
        on_attach = default_on_attach,
        cmd = { '${pkgs.openscad-lsp}/bin/openscad-lsp', '--stdio' },
        filetypes = { 'openscad' },
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
        end,
        single_file_support = true,
      };
    '';
}
