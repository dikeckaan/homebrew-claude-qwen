class ClaudeQwen < Formula
  desc "Run Claude Code against a local GGUF model (Qwen3.8-27B) via llama.cpp"
  homepage "https://github.com/dikeckaan/claude-qwen"
  url "https://github.com/dikeckaan/claude-qwen/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5343e315d3f9bac0a8b2ff2992a677a11c892df55cda4dba93847b49c8b27c8a"
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
      Claude Code is required: https://code.claude.com  (brew install --cask claude-code)

      Download a model and start:
        claude-qwen download unsloth/Qwen3.8-27B-GGUF
        claude-qwen

      Models and logs live in ~/.claude-qwen (override with CLAUDE_QWEN_HOME).
      For MTP speed-up, allow raising the GPU memory limit: claude-qwen setup
    EOS
  end

  test do
    ENV["CLAUDE_QWEN_HOME"] = testpath
    assert_match version.to_s, shell_output("#{bin}/claude-qwen version")
    assert_match "No models found", shell_output("#{bin}/claude-qwen 2>&1", 1)
  end
end
