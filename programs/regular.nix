{ pkgs, ... }:

{
    imports = [
        ../programs/firefox.nix
        ../programs/vscode.nix
        ../programs/python.nix
        ../programs/git.nix
        ../programs/zsh.nix
        ../programs/virtualisation.nix
        ../programs/node.nix
    ]
}