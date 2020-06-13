class DenoDep < Formula
  desc "Dependency management for Deno"
  homepage "https://depjs.com/"
  url "https://github.com/denodep/dep/archive/v0.2.0.tar.gz"
  sha256 "538e51c1abd03fffacee499cd3cc12b6be4dba7a790288537541da7f8d4575c5"

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
