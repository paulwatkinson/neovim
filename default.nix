{
  # globals
  lib,
  pkgs,
  callPackage,
  # inputs
  nvf,
  overrides ? {},
  ...
}: let
  config.vim = let
    callPackage' = target:
      builtins.removeAttrs
      (callPackage target {config = config.vim;})
      ["override" "overrideDerivation"];
  in
    {
      globals.mapleader = ",";

      undoFile.enable = true;

      options = {
        shiftwidth = 4;
        tabstop = 4;
      };

      extraPackages = with pkgs; [
        fzf
        fd
        ripgrep
        ueberzug
        xsel

        cargo
        rustc
        lldb

        checkstyle
      ];

      keymaps = import ./config/keymaps.nix;

      extraPlugins = callPackage' ./plugins;
      lazy.plugins = callPackage' ./lazy;

      luaConfigRC = callPackage' ./lua;

      assistant = callPackage' ./config/assistant.nix;
      autocomplete = callPackage' ./config/autocomplete.nix;
      binds = callPackage' ./config/binds.nix;
      comments = callPackage' ./config/comments.nix;
      debugger = callPackage' ./config/debugger.nix;
      diagnostics = callPackage' ./config/diagnostics.nix;
      filetree = callPackage' ./config/filetree.nix;
      git = callPackage' ./config/git.nix;
      languages = callPackage' ./config/languages.nix;
      lsp = callPackage' ./config/lsp.nix;
      notify = callPackage' ./config/notify.nix;
      projects = callPackage' ./config/projects.nix;
      statusline = callPackage' ./config/statusline.nix;
      telescope = callPackage' ./config/telescope.nix;
      theme = callPackage' ./config/theme.nix;
      treesitter = callPackage' ./config/treesitter.nix;
      ui = callPackage' ./config/ui.nix;

      utility = callPackage' ./config/utility.nix;
      visuals = callPackage' ./config/visuals.nix;
    }
    // (callPackage' ./patches.nix);
in
  (nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [(lib.recursiveUpdate {inherit config;} {config.vim = overrides;})];
  })
  .neovim
