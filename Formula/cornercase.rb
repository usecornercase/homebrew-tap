class Cornercase < Formula
  desc "A terminal multiplexer for projects, git worktrees and coding agents, driven by the mouse"
  homepage "https://github.com/usecornercase/cornercase-terminal"
  version "0.12.235"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.235/cornercase-aarch64-apple-darwin.tar.gz"
      sha256 "4add9fa9029457c6a5541d20669ba14545997be3a64c4486d920c03794d3d630"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.235/cornercase-x86_64-apple-darwin.tar.gz"
      sha256 "7c2758da4d83464417a8bd29dbbf25afb41dbabf9a6865763340e4fd6c6c0554"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.235/cornercase-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "edca51ac15a26a0d90b2102bcc80ce43bd4a9db9ff3845619fe8c093db4c67dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.235/cornercase-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "745a33b65e4360451eefef5a33ca3c767d1a8b00d2897dbcba868448a37dfb13"
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
