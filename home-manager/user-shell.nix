{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    defaultKeymap = "emacs";
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${./.p10k.zsh.bak}
      source ${./functions.zsh}

      # Add some standard keybinding not present in the default keymap
      bindkey '^[[7~' beginning-of-line                               # Home key
      bindkey '^[[H' beginning-of-line                                # Home key
      bindkey '^[[8~' end-of-line                                     # End key
      bindkey '^[[F' end-of-line                                     # End key
      bindkey '^[[2~' overwrite-mode                                  # Insert key
      bindkey '^[[3~' delete-char                                     # Delete key
      bindkey '^[[C'  forward-char                                    # Right key
      bindkey '^[[D'  backward-char                                   # Left key
      bindkey '^[[5~' history-beginning-search-backward               # Page up key
      bindkey '^[[6~' history-beginning-search-forward                # Page down key

      # Navigate words with ctrl+arrow keys
      bindkey '^[Oc' forward-word                                     #
      bindkey '^[Od' backward-word                                    #
      bindkey '^[[1;5D' backward-word                                 #
      bindkey '^[[1;5C' forward-word                                  #
      bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
      bindkey '^[[Z' undo                                             # Shift+tab undo last action
    '';

    shellAliases = {
      nano = "nvim";
      vi = "nvim";
      cat = "bat -pp";
      pos = "poetry shell";
      gi = "git";
      ls = "ls --color=auto";
      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
      chez = "chezmoi";
    };
  };

  programs.z-lua = {
    enable = true;
    enableZshIntegration = true;
  };
}
