#!/usr/bin/env bash
set -euo pipefail

# ── System dependencies ──────────────────────────────────────────────────────
sudo apt update
sudo apt install -y \
    build-essential \
    cmake \
    pkg-config \
    curl \
    git \
    unzip \
    ripgrep \
    fd-find \
    cargo

# fd is installed as fdfind on Ubuntu — create the expected symlink
if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
    sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
fi

# ── Neovim 0.11+ ─────────────────────────────────────────────────────────────
# Ubuntu 24.04 ships 0.9.5 which is too old for this config (uses vim.lsp.config,
# vim.lsp.enable, vim.diagnostic.jump — all require 0.11+)
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

# ── Node.js LTS (required by Mason for most LSPs) ────────────────────────────
# NodeSource deprecated setup_lts.sh; use versioned script or fall back to apt
if curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -; then
    sudo apt install -y nodejs
else
    sudo apt install -y nodejs npm
fi

# ── Go (required for gopls + goimports) ──────────────────────────────────────
sudo apt install -y golang-go

# ── Rust / tree-sitter CLI ────────────────────────────────────────────────────
cargo install tree-sitter-cli

# ── JetBrainsMono Nerd Font ───────────────────────────────────────────────────
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
mkdir -p "$FONT_DIR"
BASE="https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular"
for f in JetBrainsMonoNerdFont-Regular.ttf JetBrainsMonoNerdFont-Bold.ttf \
          JetBrainsMonoNerdFont-Italic.ttf JetBrainsMonoNerdFont-BoldItalic.ttf; do
    [ -f "$FONT_DIR/$f" ] || curl -fsSL "$BASE/$f" -o "$FONT_DIR/$f"
done
fc-cache -fv "$FONT_DIR"
echo "JetBrainsMono Nerd Font installed — set it in your terminal emulator."

# ── PATH ──────────────────────────────────────────────────────────────────────
grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.bashrc \
    || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
