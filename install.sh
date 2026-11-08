
sudo dnf install -y clang-devel llvm-devel
sudo dnf install -y cargo
cargo install tree-sitter-cli

echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
