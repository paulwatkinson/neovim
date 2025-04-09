{
  config,
  pkgs,
  lib,
  nvf,
  ...
}: let
  inherit (nvf.lib.nvim.dag) entryAnywhere;
  inherit (nvf.lib.nvim.lua) toLuaObject;
in {
  pluginRC.nvim-lint = lib.mkForce (let
    cfg = config.diagnostics.nvim-lint;
  in
    entryAnywhere
    # lua
    ''
      local function configure_plugin_lint()
        local plugin_lint = require("lint");
        local linters_by_ft = ${toLuaObject cfg.linters_by_ft or {}};

        local java_root = vim.fs.root(0, {'.git', 'mvnw', 'gradlew', 'build.xml', 'pom.xml'});

        if java_root ~= nil and vim.uv.fs_stat(java_root .. '/checkstyle.xml') then
          plugin_lint.linters.checkstyle.config_file = java_root .. '/checkstyle.xml';

          linters_by_ft.java = {
            'checkstyle'
          };
        end

        plugin_lint.linters_by_ft = linters_by_ft;

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            plugin_lint.try_lint();
          end,
        });
      end

      configure_plugin_lint();
    '');

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

  # conform is automatically enabled by some formatters, and without setting
  # these to `null`, formatting is forceably done on save, even if disabled.
  formatter.conform-nvim.setupOpts = {
    format_on_save = lib.mkForce null;
    format_after_save = lib.mkForce null;
  };
}
