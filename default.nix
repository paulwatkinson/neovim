{
  # globals
  lib,
  pkgs,
  callPackage,
  # inputs
  nvf,
  ...
}: let
  config.vim = let
    callPackage' = target:
      builtins.removeAttrs
      (callPackage target {config = config.vim;})
      ["override" "overrideDerivation"];
  in {
    globals.mapleader = ",";

    undoFile.enable = true;

    extraPackages = with pkgs; [
      fzf
      fd
      ripgrep
      ueberzug
      xsel

      cargo
      rustc
      lldb
    ];

    keymaps = import ./config/keymaps.nix;

    extraPlugins = callPackage' ./plugins;
    lazy.plugins = callPackage' ./lazy;

    luaConfigRC = callPackage' ./lua;

    autocomplete = callPackage' ./config/autocomplete.nix;
    binds = callPackage' ./config/binds.nix;
    comments = callPackage' ./config/comments.nix;
    debugger = callPackage' ./config/debugger.nix;
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
  };
in
  (nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [{inherit config;}];
  })
  .neovim
