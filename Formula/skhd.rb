class Skhd < Formula
  desc "Simple hotkey-daemon for macOS."
  homepage "https://github.com/koekeishiya/skhd"
  url "https://github.com/koekeishiya/skhd/archive/v0.3.5.zip"
  sha256 "64e40b4f65e9db1c4a4ce333b4978bbd84fb72df62e5d17dd2b6a41bf008ee10"
  head "https://github.com/koekeishiya/skhd.git"

  def install
    system "make", "install"

    bin.install "#{buildpath}/bin/skhd"

    (pkgshare/"examples").install "#{buildpath}/examples/skhdrc"
  end

  def caveats; <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc
    EOS
  end

  service do
    name macos: "#{plist_name}"
  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/skhd</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
        <key>PATH</key>
        <string>#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
      </dict>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>ProcessType</key>
      <string>Interactive</string>
      <key>Nice</key>
      <integer>-20</integer>
    </dict>
    </plist>
    EOS
  end

  test do
    assert_match "skhd version #{version}", shell_output("#{bin}/skhd --version")
  end
end
