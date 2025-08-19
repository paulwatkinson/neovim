{
  lib,
  config,
  plugin-copilot-chat-nvim,
  luajitPackages,
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
        package.cpath = package.cpath .. ';${luajitPackages.tiktoken_core}/lib/lua/5.1/?.so';

        require('CopilotChat').setup();
      '';
  };
}
