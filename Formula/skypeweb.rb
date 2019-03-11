class Skypeweb < Formula
  desc "Skype Plugin for Pidgin, libpurple and more"
  homepage "https://github.com/EionRobb/skype4pidgin/tree/master/skypeweb#skypeweb-plugin-for-pidgin"
  head "https://github.com/EionRobb/skype4pidgin.git"
  url "https://github.com/EionRobb/skype4pidgin/archive/1.5.tar.gz"
  sha256 "bb5fc550bff8f66f90a9ffacfc6bc2ed50fee86f4f500942aebc315d073f6e9d"

  depends_on "pkg-config" => :build

  depends_on "libpurple"
  depends_on "json-glib"

  def install
    chdir "skypeweb" do
      system "sed -i '' 's|`$(PKG_CONFIG) --variable=plugindir purple`|/lib/purple-2|' Makefile"
      system "sed -i '' 's|`$(PKG_CONFIG) --variable=datadir purple`|/share|g' Makefile"

      system "make"
      system "make", "install", "DESTDIR=#{prefix}"
    end
  end

  def caveats; <<~EOS
    To enable bitlbee to detect libskypeweb.so, run:
      ln -s $(brew ls skypeweb | grep libskypeweb.so) $(pkg-config --variable=plugindir purple)/libskypeweb.so
  EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test skype4pidgin`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
