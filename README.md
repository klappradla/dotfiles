# ~/dotfiles

How I set up my OSX/Unix environment.


## General

I use [zsh](http://www.zsh.org/) as a shell, [iTerm2](http://iterm2.com/) as a terminal replacement and the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) framework to manage my settings there.

Fontwise, I use Apple's [Monaco](https://github.com/cstrap/monaco-font) font in size `15pt` in both, my editors and my shell.

For managing ruby versions, I just switched to using [rbenv](https://github.com/rbenv/rbenv).


## Directory

```
.
├── agents (launchd scripts)
│
├── atom (atom files)
│
├── home (symlinked to ~/)
│   ├── gemrc            (global config for ruby gems)
│   ├── gitconfig        (global git config)
│   ├── gitignore_global (global gitignore)
│   ├── hushlogin        (omit "last login" message)
│   ├── rcdebug          (config for ruby-debug)
│   ├── vimrc            (config for vim)
│   └── zshrc            (zsh/oh-my-zsh config)
│
├── iterm2 (profile and settings for iterm)
│
├── scripts (backup scripts, etc.)
│
└── zsh (custom dir for oh-my-zsh)


```


## Getting started

### Install Dependencies

#### 1. Terminal
* [iTerm2](https://www.iterm2.com/)
* [Homebrew](http://brew.sh/)
* **zsh:** `brew install zsh`
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

#### 2. General
* [rbenv](https://github.com/rbenv/rbenv) `brew install rbenv`
* Git >= 2.8.0 `brew install git`

#### 3. Editors *(optional)*
* [Atom](https://atom.io/)
* **vim:** `brew install vim`


#### 4. Backup Script *(optional)*
* [AnyBar](https://github.com/tonsky/AnyBar)

### Install Dotfiles

Clone repo and symlink files *(old links are replaced by new ones)*:

    $ git clone --recursive git@github.com:klappradla/dotfiles.git
    $ cd dotfiles
    $ sh install.sh

#### iTerm2

Point **`Load preferences from custom folder or URL`** to `~/dotfiles/iterm2`

If the settings are not applied, run:

	defaults read com.googlecode.iterm2


## Hints to setup system from scratch

### OSX

show hidden files in finder

	defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder

show file endings

	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

install xcode command line tools

	xcode-select --install

use homebrew's zsh

	sudo sh -c echo '/usr/local/bin/zsh' > /etc/shells
	chsh -s /usr/local/bin/zsh


### SSH

check for ssh key, generating if it does not exist

	[[ -f $pub ]] || ssh-keygen -t rsa

copy public key to clipboard

	[[ -f $pub ]] && cat $pub | pbcopy
