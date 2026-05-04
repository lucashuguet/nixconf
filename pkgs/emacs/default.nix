{ wlib, pkgs, ... }: {
  imports = [ wlib.wrapperModules.emacs ];

  emacsPackages = epkgs: with epkgs; [
    # appearance
    nerd-icons unicode-fonts
    ef-themes doom-modeline
    vertico orderless
    dashboard

    # behaviour related
    evil evil-collection evil-commentary evil-vimish-fold evil-anzu
    nerd-icons-dired diredfl peep-dired
    eglot corfu nerd-icons-corfu cape
    tempel

    # major modes
    org-superstar evil-org org-roam org-roam-ui
    rust-mode nix-ts-mode web-mode emmet-mode beancount
    typst-ts-mode
    (treesit-grammars.with-grammars (g: with g; [
      tree-sitter-bash
      tree-sitter-c
      tree-sitter-cmake
      tree-sitter-cpp
      tree-sitter-dockerfile
      tree-sitter-html
      tree-sitter-javascript
      tree-sitter-json
      tree-sitter-lua
      tree-sitter-nix
      tree-sitter-python
      tree-sitter-rust
      tree-sitter-toml
      tree-sitter-typescript
      tree-sitter-typst
      tree-sitter-yaml
    ]))

    # utilities
    magit gptel embark consult embark-consult affe avy

    # keybindings
    which-key general
  ];

  configFile = builtins.readFile ./init.el;
  package = pkgs.emacs.override {
    withGTK3 = true;
    withTreeSitter = true;
  };
}
