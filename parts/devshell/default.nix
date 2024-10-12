{
  perSystem = { pkgs, ... }: {
    # For nix develop.
    devShells.default = pkgs.mkShell {
      name = "flake-template";
      meta.description = "DevShell for Flake.";

      # Env.
      EDITOR = "${pkgs.neovim}/bin/nvim";

      shellHook = ''
        exec fish
      '';

      packages = with pkgs; [
        yazi
        git
        curl
        neovim
        fish
        tmux
        lynx
        ripgrep
        htop
        disko
        fzf
      ];
    };
  };
}
