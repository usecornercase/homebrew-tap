class Cornercase < Formula
  desc "A terminal multiplexer for projects, git worktrees and coding agents, driven by the mouse"
  homepage "https://github.com/usecornercase/cornercase-terminal"
  version "0.12.48"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.48/cornercase-aarch64-apple-darwin.tar.gz"
      sha256 "ef02cf076b4f31ff8219b7b9ab042350dfbf8942f1ee03c6761bddb641fbff73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.48/cornercase-x86_64-apple-darwin.tar.gz"
      sha256 "7c5a5c9426b668033937791a4e952a74571aeb4c449e3647a7c8d78d0d3207bb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.48/cornercase-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "001b711579393cb6b9e24eb8b1853e148f862a1e15186cce1158246214b8fe4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.48/cornercase-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5842e38780af41a1164dca332c85c57feda10b7d25d48e6a9220ca89c73b29f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cornercase"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cornercase"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cornercase"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cornercase"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
