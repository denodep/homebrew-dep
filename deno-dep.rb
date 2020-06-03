class DenoDep < Formula
  desc "Dependency management for Deno"
  homepage "https://depjs.com/"
  url "https://github.com/denodep/dep/archive/v0.1.2.tar.gz"
  sha256 "f287f7a88eb5f75b53a437c78bce4454c7adfea29edf28efafcfe24e5708f20c"

  bottle :unneeded

  depends_on "deno"

  conflicts_with "dep", :because => "both install a `dep` executable"

  def install
    libexec.install Dir["*"]
    (bin/"dep").write <<~EOS
      #!/bin/bash
      "deno" "run" "-A" "--unstable" "#{libexec}/bin/dep.ts" "$@"
    EOS
  end

  test do
    (testpath/"pkg.json").write('{"name": "test", "version": "0.0.1"}')
    system bin/"dep", "add", "exec"
  end
end
