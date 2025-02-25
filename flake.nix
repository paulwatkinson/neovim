{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/bc27f0fde01ce4e1bfec1ab122d72b7380278e68";

    flake-utils.url = "github:numtide/flake-utils";

    nvf = {
      url = "github:notashelf/nvf/73660af2e36e9881c6cf7d82600950785b4cd51d";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        plugin-nvim-surround.follows = "plugin-nvim-surround";
      };
    };

    plugin-nvim-surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };

    plugin-nvim-jdtls = {
      url = "github:mfussenegger/nvim-jdtls";
      flake = false;
    };

    plugin-clangd-extensions-nvim = {
      flake = false;
      url = "github:p00f/clangd_extensions.nvim";
    };

    tree-sitter-nu = {
      flake = false;
      url = "github:nushell/tree-sitter-nu";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      inherit (pkgs) lib;

      scope = lib.makeScope pkgs.newScope (_: {
        inherit lib;
        inherit
          (inputs)
          nvf
          plugin-clangd-extensions-nvim
          plugin-nvim-jdtls
          plugin-nvim-surround
          tree-sitter-nu
          ;
      });
    in {
      packages = rec {
        neovim = scope.callPackage ./default.nix {};
        default = neovim;
      };
    });
}
