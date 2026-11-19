class Mergelane < Formula
  desc "MCP collaboration tools for Gitea, Plane, GitHub, GitLab, and Jira"
  homepage "https://github.com/Arion-Dsh/mergelane"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.2/mergelane-aarch64-apple-darwin.tar.xz"
      sha256 "45c6f3de81c57c091b88788694dbe53ab06531f4f6bad995e111cad78f7bed20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.2/mergelane-x86_64-apple-darwin.tar.xz"
      sha256 "e5af2441536953b3d95beec78d23dcd93d9ca85b409a7c1ada05b4fd0fcf9d39"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.2/mergelane-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fb431c4310f313a2c39a7222f1346d1c29abfecbaf19ae74892f80de184d9a8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.2/mergelane-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2eb6c602d015a1eac08b6ca35c173cec97b80cb004fe2845e53032fbbfe761b9"
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
