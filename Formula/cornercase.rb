class Cornercase < Formula
  desc "A terminal multiplexer for projects, git worktrees and coding agents, driven by the mouse"
  homepage "https://github.com/usecornercase/cornercase-terminal"
  version "0.13.54"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.13.54/cornercase-aarch64-apple-darwin.tar.gz"
      sha256 "396f7975edd6cb4c8ea032cdaefb37c0ac49394704988adaa1843d36c77eef12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.13.54/cornercase-x86_64-apple-darwin.tar.gz"
      sha256 "a151de502d96549873303a56aefd192cc6faab1c5b1cc6128ddf09a7595eb134"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.13.54/cornercase-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ecfc19251bbe80c5852c363ffe5597a9f7a2bcdfc2d92b820996d6ddce44cc38"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usecornercase/cornercase-terminal/releases/download/v0.13.54/cornercase-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7fcb5f5fb5df637abe631c4b5ba16d2864a53ad817e6c35b59a9baaf74c0119c"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
