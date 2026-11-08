class ClaudeQwen < Formula
  desc "Run Claude Code against a local GGUF model (Qwen3.8-27B) via llama.cpp"
  homepage "https://github.com/dikeckaan/claude-qwen"
  url "https://github.com/dikeckaan/claude-qwen/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "cfa524a8f7aabb5bb9d3215f59f22c0fa606a0806bd549b63d3d7098da421ddd"
  license "MIT"

  depends_on arch: :arm64
  depends_on "llama.cpp"
  depends_on :macos

  def install
    bin.install "claude-qwen"
    pkgshare.install "chat_template.jinja"
  end

  def caveats
    <<~EOS
      Claude Code gerekli: https://code.claude.com  (brew install --cask claude-code)

      Model indir ve başlat:
        claude-qwen download unsloth/Qwen3.8-27B-GGUF
        claude-qwen

      Modeller ve loglar ~/.claude-qwen altında tutulur (CLAUDE_QWEN_HOME ile değişir).
      MTP hızlandırması için GPU bellek izni: claude-qwen setup
    EOS
  end

  test do
    ENV["CLAUDE_QWEN_HOME"] = testpath
    assert_match version.to_s, shell_output("#{bin}/claude-qwen version")
    assert_match "Hiç model yok", shell_output("#{bin}/claude-qwen 2>&1", 1)
  end
end
