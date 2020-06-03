class DenoDep < Formula
  desc "Dependency management for Deno"
  homepage "https://depjs.com/"
  url "https://github.com/denodep/dep/archive/v0.1.4.tar.gz"
  sha256 "c19c0830a2ab3b5812a7949c3320496069639fc6d1b4eddf5b5fe45285e0b744"

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
