 nixos-dotfiles

Single-host NixOS flake with home-manager wired in as a module. Target host: `nixos`.

## Commands

Aliases defined in `home/shell.nix`:

```bash
rebuild   # stage changes and switch to the new system config
update    # bump flake inputs (nixpkgs, home-manager) and switch
clean     # keep the last 2 system generations, GC the rest, refresh Limine
```

Full equivalents:

```bash
# rebuild
cd ~/nixos-dotfiles && git add . && sudo nixos-rebuild switch --flake .#nixos

# update
cd ~/nixos-dotfiles && nix flake update && git add . && sudo nixos-rebuild switch --flake .#nixos

# clean
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2 \
  && sudo nix-collect-garbage -d \
  && cd ~/nixos-dotfiles && sudo nixos-rebuild boot --flake .#nixos
```

Other useful commands:

```bash
nix flake check                          # validate the flake without building
nixos-rebuild dry-run --flake .#nixos    # preview what would change
```

## Layout

| Path | Purpose |
|---|---|
| `flake.nix` | Entry point; wires system config and home-manager |
| `hosts/nixos/default.nix` | System config: boot, desktop (KDE/Plasma 6), NVIDIA, audio, gaming, packages |
| `hosts/nixos/hardware.nix` | Auto-generated hardware config |
| `home/default.nix` | Home-manager entry; imports the `home/` modules |
| `home/gtk.nix` | GTK dark theme and dconf settings |
| `home/shell.nix` | Bash config and shell aliases |
| `home/vim.nix` | Vim setup via home-manager |
| `assets/` | Static files referenced by Nix |
