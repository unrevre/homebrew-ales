class GuileAT188 < Formula
  desc "GNU Ubiquitous Intelligent Language for Extensions"
  homepage "https://www.gnu.org/software/guile/"
  url "https://ftp.gnu.org/gnu/guile/guile-1.8.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/gnu/guile/guile-1.8.8.tar.gz"
  sha256 "c3471fed2e72e5b04ad133bbaaf16369e8360283679bcf19800bc1b381024050"

  keg_only :versioned_formula

  depends_on "bdw-gc"
  depends_on "gmp"
  depends_on "libffi"
  depends_on "libtool"
  depends_on "libunistring"
  depends_on "pkg-config"
  depends_on "readline"

  def install
    args = [
      "--prefix=#{prefix}",
      "--with-libgmp-prefix=#{Formula["gmp"].opt_prefix}",
      "--with-libreadline-prefix=#{Formula["readline"].prefix}",
      "--without-threads",
    ]

    system "./configure", *args

    system "make", "install"

    Pathname.glob("#{lib}/*.dylib") do |dylib|
      lib.install_symlink dylib.basename => "#{dylib.basename(".dylib")}.so"
    end
  end

  test do
    (testpath/"test.scm").write <<~EOS
      (display "hello, world")(newline)
    EOS

    ENV["GUILE_AUTO_COMPILE"] = "0"

    assert_match /^hello, world$/, shell_output("#{bin}/guile test.scm")
  end
end
