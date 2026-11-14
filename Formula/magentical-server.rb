# typed: false
# frozen_string_literal: true

# Homebrew formula template for Magentical Server & mgtl CLI.
# On every v* release, .github/workflows/release.yml updates Formula/magentical-server.rb
# in JoeDorseyJr/homebrew-tap with the release version and SHA256 checksums.
class MagenticalServer < Formula
  desc "Daemon server and mgtl CLI for Magentical mobile AI coding control"
  homepage "https://github.com/JoeDorseyJr/magentical"
  version "0.0.0"

  on_macos do
    url "https://github.com/JoeDorseyJr/magentical/releases/download/v#{version}/magentical-server_#{version}_darwin_all.tar.gz"
    sha256 "REPLACE_WITH_DARWIN_ALL_SHA256"
  end

  on_linux do
    on_arm do
      url "https://github.com/JoeDorseyJr/magentical/releases/download/v#{version}/magentical-server_#{version}_linux_arm64.tar.gz"
      sha256 "REPLACE_WITH_LINUX_ARM64_SHA256"
    end

    on_intel do
      url "https://github.com/JoeDorseyJr/magentical/releases/download/v#{version}/magentical-server_#{version}_linux_amd64.tar.gz"
      sha256 "REPLACE_WITH_LINUX_AMD64_SHA256"
    end
  end

  def install
    bin.install "magentical-server"
    bin.install "mgtl"
  end

  service do
    run [opt_bin/"magentical-server"]
    keep_alive true
    process_type :interactive
    working_dir Dir.home
    log_path var/"log/magentical-server.log"
    error_log_path var/"log/magentical-server.err.log"
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  end

  def caveats
    <<~EOS
      To start Magentical Server as a background service:
        brew services start magentical-server

      Or run it in the foreground:
        magentical-server

      Then pair your phone:
        mgtl pair
    EOS
  end

  test do
    assert_match "mgtl version:", shell_output("#{bin}/mgtl version")
  end
end
