{ pkgs, username, ... }:
let
  emacs = with pkgs; (emacsPackagesFor
    (emacs-unstable.override {
      withGTK3 = true;
      withTreeSitter = true;
    })
  ).emacsWithPackages (epkgs: with epkgs; [
    nerd-icons unicode-fonts
    doom-themes doom-modeline
    vertico orderless which-key
    evil evil-collection evil-commentary evil-vimish-fold evil-anzu
    nerd-icons-dired diredfl peep-dired
    org-superstar evil-org org-roam org-roam-ui
    magit gptel
    embark affe avy
    eglot corfu cape nerd-icons-corfu
    yasnippet yasnippet-snippets
    rust-mode nix-mode nix-ts-mode web-mode emmet-mode beancount
    typst-preview typst-ts-mode
    general dashboard
  ]);
in{
  environment.systemPackages = with pkgs; [ ripgrep ];

  home-manager.users.${username} = {
    home.packages = [ emacs ];
    home.file = {
      ".emacs.d/init.el".source = ./init.el;
    };
    services.emacs = {
      enable = true;
      package = emacs;
    };
  };
}
