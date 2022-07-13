class KubectlBuildkit < Formula
  desc "BuildKit CLI for kubectl"
  homepage "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl"
  url "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl/archive/refs/tags/v0.1.6.tar.gz"
  license "Apache-2.0"
  head "https://github.com/kubernetes/kubernetes.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    system "make", "build", "VERSION=" + version
    
    if OS.mac?
      bin.install Dir["bin/darwin/kubectl-build*"]
    elsif OS.linux?
      bin.install Dir["bin/linux/kubectl-build*"]
    else
      odie "Only Mac and Linux supported"
    end
  end

  test do
    run_output = shell_output("#{bin}/kubectl-buildkit 2>&1")
    assert_match "BuildKit is a toolkit for converting source code", run_output
  end
end
