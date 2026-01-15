{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        autosuggestions.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        interactiveShellInit = ''
            source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
        '';
        shellAliases = {
            q = "exit";
            ls = "ls --color=tty -A";
        };
    };
}