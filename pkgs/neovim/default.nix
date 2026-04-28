{ wlib, config, pkgs, lib, ... }: let
  ef-themes = pkgs.vimUtils.buildVimPlugin {
    pname = "ef-themes.nvim";
    version = "1.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "oonamo";
      repo = "ef-themes.nvim";
      rev = "d9076b0e81cc1ec9f59ab6e65af9317763b7d2bb";
      hash = "sha256-1lkz3baF6bUCTdrX9+m7jtqOghakKdRSeCL1cajyD3Q=";
    };
  };
in {
  imports = [ wlib.wrapperModules.neovim ];

  specs.plugins = with pkgs.vimPlugins; [
    blink-cmp
    ef-themes
    lualine-nvim
    nvim-autopairs
    nvim-colorizer-lua
    nvim-lspconfig
    (nvim-treesitter.withPlugins (p: with p; [
      c cpp lua nix python rust
    ]))
  ];

  extraPackages = with pkgs; [
    nixd rust-analyzer clang-tools
  ];

  settings.config_directory = ./.;
}
