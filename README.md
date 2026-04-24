# my-nix-repo

> [!NOTE]
> A personal Nix repository built specifically for **nix-on-droid**. 
> Created as a test project while learning Nix to package and distribute my custom tools.

## Installation

### Add as a channel

> [!TIP]
> Recommended if you want to keep the tools updated seamlessly.

```bash
nix-channel --add https://github.com/Anon4You/my-nix-repo/archive/main.tar.gz mnr
nix-channel --update
```

```bash
nix-env -iA mnr.fuckyou
```

### Install directly

> [!NOTE]
> Bypass channels entirely and install a package on the fly.

```bash
nix-env -if https://github.com/Anon4You/my-nix-repo/archive/main.tar.gz -A fuckyou
```
