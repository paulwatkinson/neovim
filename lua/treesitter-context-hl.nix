_: {
  treesitter-context-hl =
    # lua
    ''
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", {});

      vim.api.nvim_set_hl(0, "@ibl.scope.char.1", {
        nocombine = true,
        fg = "#444659",
        force = true,
      });
    '';
}
