{ ... }:

{
  hjem.users.kaezr = {
    clobberFiles = true;
    user = "kaezr";
    directory = "/home/kaezr";
  };

  hjem.users.kaezr.files = {
    ".config/kitty".source = ../dotfiles/kitty;
    ".config/fastfetch".source = ../dotfiles/fastfetch;
    ".config/noctalia".source = ../dotfiles/noctalia;
    ".config/niri".source = ../dotfiles/niri;
  };
}
