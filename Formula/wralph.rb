# frozen_string_literal: true

class Wralph < Formula
  desc 'Workflow Ralph - Human-In-The-Loop AI Factory'
  homepage 'https://github.com/niborg/wralph'
  url "https://github.com/niborg/wralph/archive/refs/tags/v0.1.10.tar.gz"
  sha256 '8f29162e936bef5d0314e673f57325f9d0b48bef404d35d634dad65c69dfac91'
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
