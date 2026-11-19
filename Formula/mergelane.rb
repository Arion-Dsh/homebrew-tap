class Mergelane < Formula
  desc "MCP collaboration tools for Gitea, Plane, GitHub, GitLab, and Jira"
  homepage "https://github.com/Arion-Dsh/mergelane"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.0/mergelane-aarch64-apple-darwin.tar.xz"
      sha256 "343014a9f55c4932febef75f0592ebd55ff86a7002f5e178688bb293896f34bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.0/mergelane-x86_64-apple-darwin.tar.xz"
      sha256 "45eae47b67e9dd6e91279491ad83545fe7fb8c0a861bba3c712e2733b6d662eb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.0/mergelane-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5101ebaf08beb599d406f11b647966e80e5b73a99505599d601e847170d5a0f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Arion-Dsh/mergelane/releases/download/v0.1.0/mergelane-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "111d7689e5f19b7f6f957dbc752344b6703a58ce09303c8c67794a265b42f6ec"
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
