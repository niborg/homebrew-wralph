# frozen_string_literal: true

class Wralph < Formula
  desc 'Workflow Ralph - Human-In-The-Loop AI Factory'
  homepage 'https://github.com/niborg/wralph'
  url "https://github.com/niborg/wralph/archive/refs/tags/v0.1.9.tar.gz"
  sha256 '6ae6b6c4f9f86137e40f079ebd8f47f5df432a1824196bab16f42a922d90b4e5'
  license 'MIT'

  depends_on 'ruby'
  depends_on 'gh'
  depends_on 'jq'
  depends_on 'max-sixty/worktrunk/wt'

  def install
    # 1. Install gem dependencies into a private folder (libexec)
    ENV["GEM_HOME"] = libexec

    # 2. Build your gem from the gemspec
    system "gem", "build", "#{name}.gemspec"

    # 3. Install it into the private folder
    system "gem", "install", "#{name}-*.gem"

    # 4. Install the executable into the public bin folder,
    #    but wrap it so it knows where its private gems (libexec) are.
    bin.install libexec/"bin/wralph"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    system "#{bin}/wralph", '--version'
  end
end
