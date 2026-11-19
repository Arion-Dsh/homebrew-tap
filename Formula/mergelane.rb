class Mergelane < Formula
  desc "MCP collaboration tools for Gitea, Plane, GitHub, GitLab, and Jira"
  homepage "https://github.com/Arion-Dsh/mergelane"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.1/mergelane-aarch64-apple-darwin.tar.xz"
      sha256 "d754756afc4ece79ea4bbe13454261359e9cc1124541e279debc3f0e9d4be80b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.1/mergelane-x86_64-apple-darwin.tar.xz"
      sha256 "1fb3225e387deeadb186e1ba91f7411fed368ff3b8fd58a1e792ca93443a0c3a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.1/mergelane-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b9305840bc6b73a4d1ab0950314c66b44387c1d599585d92afdd7a75e8875a73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.1/mergelane-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c278af2d58530272b63c4b090a0135ed4aa7393e7becfa43759d57f9eceaccc"
    end
  end
  license "MIT"

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
      bin.install "mergelane"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mergelane"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mergelane"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mergelane"
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
