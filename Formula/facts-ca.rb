class FactsCa < Formula
  desc "Go port of the Puppet CA: a Puppet CA v1 server and agent CLI"
  homepage "https://github.com/ncode/facts-ca"
  url "https://github.com/ncode/facts-ca/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "81beaa64d832f6861b90d5aec44556420250ab18753bffb7264a2f6b81c9eff7"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/ncode/facts-ca/internal/version.Version=v#{version}"
    system "go", "build", "-trimpath", "-ldflags", ldflags,
      "-o", bin/"facts-ca-cli", "./cmd/facts-ca-cli"
    system "go", "build", "-trimpath", "-ldflags", ldflags,
      "-o", bin/"facts-ca-server", "./cmd/facts-ca-server"
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/facts-ca-cli --version").chomp
    assert_equal "v#{version}", shell_output("#{bin}/facts-ca-server --version").chomp
  end
end
