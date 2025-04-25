{
  nvim-dap = {
    enable = true;
    ui.enable = true;

    sources = {
      dap-pg-land-tech =
        # lua
        ''
          local dap = require('dap');

          dap.configurations.c = {
            {
              name = 'Launch',
              type = 'lldb',
              request = 'launch',
              program = function()
                local actions = require('telescope.actions');
                local config = require('telescope.config').values;
                local finders = require('telescope.finders');
                local pickers = require('telescope.pickers');
                local state = require('telescope.actions.state');

                return coroutine.create(function(coro)
                  local opts = {}

                  pickers
                    .new(opts, {
                      prompt_title = "Path to executable",
                      finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                      sorter = config.generic_sorter(opts),
                      attach_mappings = function(buffer_number)
                        actions.select_default:replace(function()
                          actions.close(buffer_number)
                          coroutine.resume(coro, state.get_selected_entry()[1])
                        end)
                        return true
                      end,
                    })
                    :find()
                end)
              end,
              -- cwd = '${"\${workspaceFolder}"}/build/Debug',
              cwd = '${"\${workspaceFolder}"}',
              stopOnEntry = false,
              args = function()
                return coroutine.create(function(coro)
                  vim.ui.input({
                    prompt = 'Args: ',
                    completion = 'file',
                  }, function(input)
                      coroutine.resume(coro, vim.fn.split(vim.fn.expand(input)));
                  end);
                end);
              end,
            }
          };

          dap.configurations.cpp = dap.configurations.c;
        '';
    };
  };
}
