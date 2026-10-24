{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    plugins = {
      inherit (pkgs.yaziPlugins)
        mount
        git
        ouch
        drag
        ;
    };

    settings.yazi = {
      mgr.show_hidden = true;

      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];

      plugin.prepend_previewers = [
        {
          mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
          run = "ouch --show-file-icons";
        }
      ];
    };

    settings.keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "C" ];
          run = "plugin ouch";
          desc = "Compress with ouch";
        }

        {
          on = [ "<C-d>" ];
          run = "plugin drag";
          desc = "Drag Files";
        }

        {
          on = [ "M" ];
          run = "plugin mount";
          desc = "Show mounted devices";
        }
      ];
    };

    initLua = ./init.lua;
  };
}
