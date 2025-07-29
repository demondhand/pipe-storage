#!/bin/bash

set -e

echo "🚀 Installing Pipe CLI from https://github.com/PipeNetwork/pipe ..."

# Update system
sudo apt update

# Install dependencies
sudo apt install -y git curl build-essential

# Install Rust if not installed
if ! command -v cargo &> /dev/null; then
    echo "🛠 Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "✅ Rust already installed"
fi

# Clone Pipe repo
if [ -d "pipe" ]; then
    echo "📂 'pipe' folder already exists, pulling latest changes..."
    cd pipe
    git pull
else
    echo "📥 Cloning Pipe CLI repo..."
    git clone https://github.com/PipeNetwork/pipe.git
    cd pipe
fi

# Build Pipe CLI
echo "⚙️ Building Pipe CLI..."
cargo build --release

# Move binary to PATH
sudo cp target/release/pipe /usr/local/bin/

# Set referral code
echo "🎁 Setting referral code: DEMON-MJVH"
pipe set-referral DEMON-MJVH || echo "⚠️ Could not set referral — maybe you're not logged in yet."

# Done
echo "✅ Pipe CLI installed and referral DEMON-MJVH applied!"
pipe --version
