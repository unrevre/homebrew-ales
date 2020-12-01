class Libpurple < Formula
  desc "IM library from Pidgin"
  homepage "https://pidgin.im/"
  head "https://bitbucket.org/pidgin/main"
  url "https://downloads.sourceforge.net/project/pidgin/Pidgin/2.13.0/pidgin-2.13.0.tar.bz2"
  sha256 "2747150c6f711146bddd333c496870bfd55058bab22ffb7e4eb784018ec46d8f"

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gnutls"
  depends_on "libgcrypt"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-avahi
      --disable-consoleui
      --disable-dbus
      --disable-dependency-tracking
      --disable-devhelp
      --disable-doxygen
      --disable-farstream
      --disable-gestures
      --disable-gstreamer
      --disable-gstreamer-interfaces
      --disable-gstreamer-video
      --disable-gtkspell
      --disable-gtkui
      --disable-idn
      --disable-meanwhile
      --disable-nls
      --disable-nm
      --disable-perl
      --disable-pixmaps-install
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
    system "true"
  end
  test do
    (testpath/"test.cpp").write <<~EOS
      #include <purple.h>

      #include <stdio.h>

      static void network_disconnected(void)
      {
        printf("network disconnected\\n");
      }

      static PurpleConnectionUiOps null_conn_uiops =
      {
        NULL,                 /* connect_progress         */
        NULL,                 /* connected                */
        NULL,                 /* disconnected             */
        NULL,                 /* notice                   */
        NULL,                 /* report_disconnect        */
        NULL,                 /* network_connected        */
        network_disconnected, /* network_disconnected     */
        NULL,                 /* report_disconnect_reason */
      };

      static void
      null_ui_init(void)
      {
        purple_connections_set_ui_ops(&null_conn_uiops);
      }

      static PurpleCoreUiOps null_core_uiops =
      {
        .ui_init = null_ui_init,
      };

      int main(int argc, char **argv)
      {
        purple_core_set_ui_ops(&null_core_uiops);

        return 0;
      }
    EOS
    glib = Formula["glib"]
    system ENV.cxx, "-I#{include}/libpurple",
                    "-I#{glib.opt_include}/glib-2.0",
                    "-I#{glib.opt_lib}/glib-2.0/include",
                    "-L#{lib}", "-L#{glib.opt_lib}",
                    "-lpurple", "-lglib-2.0",
                    testpath/"test.cpp", "-o", "test"
    system "./test"
  end
end
