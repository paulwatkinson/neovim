{
  config,
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
}
