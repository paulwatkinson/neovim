{config, ...}: let
  cfg = config.assistant.copilot;
in {
  copilot = {
    enable = false;
    cmp.enable = cfg.enable;

    setupOpts.suggestion.enabled = cfg.enable;

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
