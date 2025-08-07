{
  lib,
  config,
  plugin-copilot-chat-nvim,
  ...
}:
lib.optionalAttrs config.assistant.copilot.enable {
  copilot-chat-nvim = {
    package = {
      name = "copilot-chat-nvim";
      src = plugin-copilot-chat-nvim;
      type = "derivation";
    };

    after =
      # lua
      ''
        require('CopilotChat').setup();
      '';
  };
}
