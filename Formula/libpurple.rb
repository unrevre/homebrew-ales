class Libpurple < Formula
  desc "IM library from Pidgin"
  homepage "https://pidgin.im/"
  head "https://bitbucket.org/pidgin/main"
  url "https://downloads.sourceforge.net/project/pidgin/Pidgin/2.13.0/pidgin-2.13.0.tar.bz2"
  sha256 "2747150c6f711146bddd333c496870bfd55058bab22ffb7e4eb784018ec46d8f"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "glib"
  depends_on "gnutls"
  depends_on "libgcrypt"
  depends_on "libidn"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-avahi
      --disable-consoleui
      --disable-dbus
      --disable-debug
      --disable-dependency-tracking
      --disable-doxygen
      --disable-farstream
      --disable-gestures
      --disable-gevolution
      --disable-gstreamer
      --disable-gstreamer-interfaces
      --disable-gtkspell
      --disable-gtkui
      --disable-libgadu
      --disable-meanwhile
      --disable-nls
      --disable-perl
      --disable-schemas-install
      --disable-screensaver
      --disable-sm
      --disable-startup-notification
      --disable-tcl
      --disable-tk
      --disable-vv
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/finch", "--version"
  end
end
