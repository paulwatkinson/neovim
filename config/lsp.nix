{
  # globals
  lib,
  # packages
  clang-tools,
  lemminx,
  sqls,
  # jdt-language-server,
  ...
}: {
  lightbulb.enable = true;
  trouble.enable = true;
  lspSignature.enable = true;
  lspkind.enable = true;

  null-ls.enable = true;

  lspconfig.sources = {
    clang-lsp =
      lib.mkForce
      # lua
      ''
        local clangd_cap = capabilities

        -- use same offsetEncoding as null-ls
        clangd_cap.offsetEncoding = {"utf-16"}

        lspconfig.clangd.setup {
          capabilities = clangd_cap,
          on_attach = default_on_attach,
          cmd = {
            '${lib.getExe' clang-tools "clangd"}',
            '--background-index',
            '--compile-commands-dir=' .. vim.fn.getcwd() .. '/'
          },
        }
      '';

    lemminx-lsp =
      # lua
      ''
        lspconfig.lemminx.setup {
          capabilities = capabilities,
          on_attach = default_on_attach,
          cmd = { '${lib.getExe lemminx}' },
          filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
          single_file_support = true,
        }
      '';

    sql-lsp =
      lib.mkForce
      # lua
      ''
        lspconfig.sqls.setup {
          on_attach = function(client, bufnr)
            client.server_capabilities.execute_command = true;
            default_on_attach(client, bufnr);
            require('sqls').on_attach(client, bufnr);
          end,
          cmd = {'${lib.getExe sqls}', '-config', string.format('%s/.sqls.yml', vim.fn.getcwd()) }
        }
      '';

    # jdtls =
    #   lib.mkForce
    #   # lua
    #   ''
    #     lspconfig.jdtls.setup {
    #       capabilities = capabilities,
    #       on_attach = default_on_attach,
    #       cmd = {${
    #       (builtins.concatStringsSep ", ") [
    #         ''"${lib.getExe jdt-language-server}"''
    #         ''"--jvm-arg=-javaagent:" .. vim.fn.expand("$HOME/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar")''
    #         ''"-data"''
    #         ''vim.fn.stdpath("cache") .. "/jdtls/workspace"''
    #       ]
    #     }},
    #       init_options = {
    #         extendedClientCapabilities = {
    #           classFileContentsSupport = true,
    #         },
    #       },
    #     }
    #   '';
  };
}
