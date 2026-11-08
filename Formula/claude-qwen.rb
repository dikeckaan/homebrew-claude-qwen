class ClaudeQwen < Formula
  desc "Run Claude Code against a local GGUF model (Qwen3.8-27B) via llama.cpp"
  homepage "https://github.com/dikeckaan/claude-qwen"
  url "file:///private/tmp/claude-501/-Users-kaandikec/1dae1487-cd6d-4b24-ae85-bfc57063c407/scratchpad/claude-qwen-0.1.0.tar.gz"
  sha256 "04946fc255f9c255c97ad75af2a9a2a9c0d71bfe8d11b837c9b6aa863e96cf4f"
  license "MIT"

  depends_on arch: :arm64
  depends_on "llama.cpp"
  depends_on :macos

  def install
    bin.install "claude-qwen"
    (share/"claude-qwen").install "chat_template.jinja"
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
