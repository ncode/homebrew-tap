class Facts < Formula
  desc "Discover and report facts about the current system"
  homepage "https://github.com/ncode/facts"
  url "https://github.com/ncode/facts/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "124cac9c43ce5210c57650db4565ba73b64b151a66b39923a71c617024b69e79"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath",
      "-ldflags", "-s -w -X github.com/ncode/facts/internal/engine.Version=v#{version}",
      "-o", bin/"facts", "./cmd/facts"
    man8.install "man/man8/facts.8"
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/facts --version").chomp
    assert_match "facterversion", shell_output("#{bin}/facts --json facterversion")
  end
end
