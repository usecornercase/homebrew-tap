class Cornercase < Formula
  desc "A terminal multiplexer for projects, git worktrees and coding agents, driven by the mouse"
  homepage "https://github.com/usecornercase/cornercase-terminal"
  version "0.12.285"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.285/cornercase-aarch64-apple-darwin.tar.gz"
      sha256 "a780724ab7b0892a3fb09160a31eeef6862021f7afd5333196403b65fc4a764e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.285/cornercase-x86_64-apple-darwin.tar.gz"
      sha256 "1b9765dc3d4e6a6e21c687bdf61751029c0ecb7279afd7eacb4ac26b4a5efa63"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.285/cornercase-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f70ad030837a683c96b5fdb6956161df8311ee2b963ce9d8a36b2bd46463c44b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.12.285/cornercase-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a0736227c4a88c889018f82047102a8fbd43e063a0ae43df8d853eac24330b3"
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
