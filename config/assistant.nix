_: {
  copilot = {
    enable = true;
    cmp.enable = true;

    setupOpts.suggestion.enabled = true;

    mappings = {
      panel.open = "<leader>s";
      suggestion = {
        accept = "<C-l>";
        next = "<C-n>";
        prev = "<C-p>";
      };
    };
  };
}
