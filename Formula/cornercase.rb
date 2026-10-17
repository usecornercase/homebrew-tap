class Cornercase < Formula
  desc "A terminal multiplexer for projects, git worktrees and coding agents, driven by the mouse"
  homepage "https://github.com/usecornercase/cornercase-terminal"
  version "0.12.124"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.124/cornercase-aarch64-apple-darwin.tar.gz"
      sha256 "4dc4abb707c0308a37bebb417025f9c82a57d9771bbfc5d7b2cd6f0c77d7bf89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.124/cornercase-x86_64-apple-darwin.tar.gz"
      sha256 "eb617d32b3eda11eab34c6507be1ed09723046c66867960fefd4b93e98c73ef5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.124/cornercase-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc52cd39d20dd3ca8a6608662a11d250f71e66ee8bd934543716c256ab145612"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.124/cornercase-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "669580dee625be0958e965235819938c1f337f1341d8eeec208412bab5e170b4"
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
