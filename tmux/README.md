# Tmux Configuration

Seamless pane/split navigation between tmux and nvim using [nvim-tmux-navigation](https://github.com/alexghergh/nvim-tmux-navigation).

## Setup

Symlink the tmux config so tmux picks it up automatically:

```sh
mkdir -p ~/.config/tmux
ln -sf ~/.config/nvim/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

## Dev Environment

Add the `dev` alias to your shell:

```sh
echo 'alias dev="bash ~/.config/nvim/tmux/dev-env.sh"' >> ~/.zshrc
```

Then launch a tmux session with claude (left 1/4) and nvim (right 3/4):

```sh
dev
```

- `Ctrl+h/j/k/l` navigates between tmux panes and nvim splits
- `Ctrl+\` returns to the last active pane
- `Ctrl+Space` cycles to the next pane
- `Prefix + t` toggles the bottom terminal pane
