{config, ...}: {
  lualine = {
    enable = true;
    theme = config.theme.name;
    globalStatus = false;

    activeSection = {
      a = [
        # lua
        ''
          {
            "mode",
            icons_enabled = true,
            separator = {
              right = ''
            },
          }
        ''

        # lua
        ''
          {
            "",
            draw_empty = true,
            separator = { left = '', right = '' }
          }
        ''
      ];

      b = [
        # lua
        ''
          {
            "filetype",
            colored = true,
            icon_only = true,
            icon = { align = 'center' }
          }
        ''

        # lua
        ''
          {
            "filename",
            path = 1,
            symbols = {modified = ' ', readonly = ' '},
            separator = {right = ''}
          }
        ''

        # lua
        ''
          {
            "",
            draw_empty = true,
            separator = { left = '', right = '' }
          }
        ''
      ];

      c = [
        # lua
        ''
          {
            "diff",
            colored = false,
            diff_color = {
              -- Same color values as the general color option can be used here.
              added    = 'DiffAdd',    -- Changes the diff's added color
              modified = 'DiffChange', -- Changes the diff's modified color
              removed  = 'DiffDelete', -- Changes the diff's removed color you
            },
            symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the diff symbols
            separator = {right = ''}
          }
        ''

        # lua
        ''
          {
            "navic",
            color_correction = nil,
            navic_opts = {
              highlight = true,
              lsp = { auto_attach = true, },
            },
          },
        ''
      ];
    };
  };
}
