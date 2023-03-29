# Docs

## Disk Encryption

Turn on FileVault:

```bash
fdesetup status # check status

sudo fdesetup enable
```

## Troubleshooting Guide

### XCode Command Line Tools

If not prompted when using `git` for the first time, manually install the XCode Command Line Tools:

```bash
xcode-select --install
```

### iTerm

If the preferences aren't picked up automatically: point **`Load preferences from custom folder or URL`** to `~/dotfiles/iterm2`

If the settings are not applied, run:

```bash
defaults read com.googlecode.iterm2
```

### SSH

To manually add keys to the macOS ssh-agent:

```bash
ssh-add -K ~/.ssh/id_rsa
```

The ssh-agent can then automatically load the key from the macOS keychain every time it needs it.

### Git Submodules

Update all submodules to the latest tips of their remote branches:

```bash
git submodule update --recursive --remote
```
