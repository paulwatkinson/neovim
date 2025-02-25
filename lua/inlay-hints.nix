_: {
  inlay_hints =
    # lua
    ''
      vim.api.nvim_set_hl(0, "LspInlayHint", {
        link = "@punctuation",
        force = true,
      });

      vim.lsp.inlay_hint.enable(true);
    '';
}
