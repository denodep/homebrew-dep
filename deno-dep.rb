class DenoDep < Formula
  desc "Dependency management for Deno"
  homepage "https://depjs.com/"
  url "https://github.com/denodep/dep/archive/v0.1.3.tar.gz"
  sha256 "ee76c45e0fbc41a54826b0965de6931b6afc99633cfe8f09394909c72c370c62"

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
