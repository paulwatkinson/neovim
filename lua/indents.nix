_: {
  indents =
    # lua
    ''
      local function set_ft_indent(pattern, value)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = pattern,
          callback = function()
            vim.opt_local.shiftwidth = value;
            vim.opt_local.tabstop = value;
          end,
        });
      end

      set_ft_indent("css", 2);
      set_ft_indent("html", 2);
      set_ft_indent("java", 4);
      set_ft_indent("json", 4);
      set_ft_indent("sql", 4);
      set_ft_indent("toml", 2);
      set_ft_indent("xml", 2);
      set_ft_indent("rust", 4);
      set_ft_indent("nu", 2);
      set_ft_indent("nix", 2);

      set_ft_indent("typescript", 4);
      set_ft_indent("typescriptreact", 4);

      set_ft_indent("javascript", 4);
      set_ft_indent("javascriptreact", 4);
    '';
}
