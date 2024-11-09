system:
	sudo nixos-rebuild switch --flake ./#default 
home:
	home-manager switch --flake ./home-manager
full: system home
