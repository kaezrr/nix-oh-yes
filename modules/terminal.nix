{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases =
      let
        eza = "${pkgs.eza}/bin/eza";
        bat = "${pkgs.bat}/bin/bat";
      in
      {
        ll = "${eza} -l --icons=auto --group-directories-first";
        la = "${eza} -lA --icons=auto --group-directories-first";
        cat = "${bat}";
      };

    interactiveShellInit = ''
      function fish_user_key_bindings
        bind \ey forward-word
        bind \cy forward-char
      end

      fish_config theme choose catppuccin-mocha

      set -g fish_greeting
      set -g fish_key_bindings fish_default_key_bindings
    '';
  };

  programs.zoxide = {
    enable = true;
    flags = [ "--cmd cd" ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "Anjishnu Banerjee";
      user.email = "kaezr.dev@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.lazygit.enable = true;

  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    fzf
    ripgrep
    fd

    fishPlugins.pure
    fishPlugins.fzf-fish
    fishPlugins.autopair
    fishPlugins.bang-bang

    # Needed for neovim
    gcc
    tree-sitter
    lua-language-server
    stylua
  ];
}
