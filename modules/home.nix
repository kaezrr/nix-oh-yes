{ ... }:

{
  hjem.users.kaezr = {
    clobberFiles = true;
    user = "kaezr";
    directory = "/home/kaezr";

    xdg.config.files = {
      "kitty".source = ../dotfiles/kitty;
      "fastfetch".source = ../dotfiles/fastfetch;
      "noctalia".source = ../dotfiles/noctalia;
      "niri".source = ../dotfiles/niri;
    };

    files."Pictures/wallpapers".source = ../wallpapers;
  };
}
