class DenoDep < Formula
  desc "Dependency management for Deno"
  homepage "https://depjs.com/"
  url "https://github.com/denodep/dep/archive/v0.2.3.tar.gz"
  sha256 "df0b5d71b94cd708b846128099cda4e593c52c493cfe1c0ea4569e319577dd20"

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
