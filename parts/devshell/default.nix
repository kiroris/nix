{
  perSystem = {pkgs, ...}: {
    # For nix develop
    devShells.default = pkgs.mkShell {
      name = "flake-template";
      meta.description = "DevShell for Flake";

      # Env
      EDITOR = "${pkgs.neovim-unwrapped}/bin/nvim";

      shellHook = ''
        exec fish -C 'alias check="nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes"'
      '';

      packages = with pkgs; [
        alejandra
        yazi
        git
        curl
        neovim-unwrapped
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
