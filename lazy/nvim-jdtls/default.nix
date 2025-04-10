{
  lib,
  plugin-nvim-jdtls,
  jdt-language-server,
  jdk23_headless,
  jdk21_headless,
  jdk17_headless,
  jdk11_headless,
  jdk8_headless,
  ...
}: let
  toLua = indent:
    lib.generators.toLua {
      multiline = true;
      inherit indent;
    };
in {
  nvim-jdtls = {
    package = {
      name = "nvim-jdtls";
      src = plugin-nvim-jdtls;
      type = "derivation";
    };

    lazy = true;
    ft = ["java"];

    after =
      # lua
      ''
        local jdtls = require('jdtls');

        local lombok_version_preference = vim.version.range('>1.18.30');

        local function get_lombok_jar(root)
          local values = vim.fn.glob(root .. '/org/projectlombok/lombok/*/lombok-*.jar', true, true);
          local matched = nil;

          for i, v in ipairs(values) do
            matched = v:match('lombok%-[%d.]+[.]jar$');

            if matched ~= nil and lombok_version_preference:has(matched) then
              return v;
            end
          end

          return nil;
        end

        local function can_open_file(target)
          local file = io.open(target, 'r');

          if file ~= nil then
            io.close(file);

            return true;
          end

          return false;
        end

        local function get_root_dir()
          local result = vim.fs.root(0, {'.git', 'mvnw', 'gradlew', 'build.xml', 'pom.xml'});

          -- TODO: Check other files too?
          if result ~= nil and can_open_file(result .. '/pom.xml') then
            local dir = vim.fs.dirname(result);

            while dir ~= nil and can_open_file(dir .. '/pom.xml') do
              result = dir;
              dir = vim.fs.dirname(result);
            end
          end

          return result;
        end

        local function compute_unique_workspace(where)
          if where == nil then
            return compute_unique_workspace(vim.fn.getcwd());
          end

          return vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. vim.fn.fnameescape(vim.fn.fnamemodify(where, ":p:h:gs?/?%?"));
        end

        local root_dir = get_root_dir();

        local cmd = {
          '${jdk21_headless}/bin/java'
        };

        if root_dir ~= nil then
          local lombok_sources = {
            -- Check locally first...
            root_dir .. '/.m2/repository',

            -- Fallback to global
            '$HOME/.m2/repository',
          };

          local lombok_jar = nil;

          for _, source in ipairs(lombok_sources) do
            lombok_jar = get_lombok_jar(source);

            if lombok_jar ~= nil then
              vim.list_extend(cmd, {
                '-javaagent:' .. lombok_jar
              });

              break;
            end
          end
        end

        vim.list_extend(cmd, {
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',

          '-Dosgi.bundles.defaultStartLevel=4',
          '-Dosgi.checkConfiguration=true',
          '-Dosgi.configuration.cascaded=true',
          '-Dosgi.sharedConfiguration.area.readOnly=true',
          '-Dosgi.sharedConfiguration.area=${jdt-language-server}/share/java/jdtls/config_linux',

          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xms1g',
          '-Xmx2G',

          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

          '-jar', vim.fn.glob('${jdt-language-server}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar', true, true)[1],
          '-data', compute_unique_workspace(root_dir)
        });

        local config = {
          cmd = cmd,
          root_dir = root_dir,

          settings = {
            java = {
              signatureHelp = { enabled = true },

              format = {
                comments = {
                  enabled = true,
                },

                tabSize = 4,
                insertSpaces = true,

                settings = {
                  url = '${./formatter.xml}',
                  profile = 'Personal',
                },
              },

              configuration = {
                runtimes = ${
          (toLua "        ") (
            lib.mapAttrsToList (name: jdk: {
              inherit name;
              path = "${jdk}/lib/openjdk/";
            }) {
              "JavaSE-23" = jdk23_headless;
              "JavaSE-21" = jdk21_headless;
              "JavaSE-17" = jdk17_headless;
              "JavaSE-11" = jdk11_headless;
              "JavaSE-1.8" = jdk8_headless;
            }
          )
        },
              },
            }
          },

          init_options = {
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            bundles = {}
          },

          on_attach = default_on_attach,
        };

        if root_dir ~= nil and vim.uv.fs_stat(root_dir .. '/.m2') then
          config.settings.java.configuration.maven = {
            globalSettings = '${./maven_settings.xml}';
          };
        end

        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'java',
          callback = function()
              jdtls.start_or_attach(config);
          end,
        });
      '';
  };
}
