{config, ...}: let
  cfg = config.assistant.copilot;
in {
  copilot = {
    enable = true;
    cmp.enable = cfg.enable;

    setupOpts = {
      suggestion.enabled = cfg.enable;
      copilot_model = "claude-4-sonnet";
    };

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
