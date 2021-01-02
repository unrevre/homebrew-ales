class Limebar < Formula
  desc "featherweight status bar for macOS"
  homepage "https://github.com/unrevre/limebar"
  head "https://github.com/unrevre/limebar.git"

  def install
    system "make"
    bin.install "bin/limebar"

    (var/"log/limebar").mkpath
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
        <string>#{opt_bin}/limebar</string>
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
      <key>StandardOutPath</key>
      <string>#{var}/log/limebar/limebar.out.log</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/limebar/limebar.err.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    system "true"
  end
end
