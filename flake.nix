{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    plugin-nvim-jdtls = {
      url = "github:mfussenegger/nvim-jdtls";
      flake = false;
    };

    plugin-clangd-extensions-nvim = {
      flake = false;
      url = "github:p00f/clangd_extensions.nvim";
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
