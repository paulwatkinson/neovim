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

      set_ft_indent("xml", 2);
      set_ft_indent("java", 4);
      set_ft_indent("sql", 4);
    '';
}
