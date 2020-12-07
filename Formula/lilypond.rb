class Lilypond < Formula
  desc "Music engraving system"
  homepage "https://lilypond.org"
  url "https://lilypond.org/download/sources/v2.21/lilypond-2.21.81.tar.gz"
  sha256 "eb7af474754a696b83379ffcf95ffdf3599320d160ba517dca404883380ab512"

  head do
    url "https://git.savannah.gnu.org/git/lilypond.git"
    mirror "https://github.com/lilypond/lilypond.git"
  end

  depends_on "autoconf" => :build
  depends_on "bison" => :build
  depends_on "fontforge" => :build
  depends_on "t1utils" => :build
  depends_on "texinfo" => :build
  depends_on "extractpdfmark"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "ghostscript"
  depends_on "glib"
  depends_on "guile@1.8.8"
  depends_on "pango"

  uses_from_macos "flex" => :build
  uses_from_macos "perl" => :build

  def install
    mkdir "build" do
      ENV.append_path "PATH", "/Library/TeX/texbin"

      system "../configure", "--prefix=#{prefix}",
                             "--with-texgyre-dir=/Library/Fonts",
                             "--disable-debugging",
                             "--disable-documentation",
                             "--enable-gs-api"

      system "make", "all"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.ly").write <<~EOS
      \\relative { c' d e f g a b c }
    EOS

    ENV.prepend_path "LTDL_LIBRARY_PATH", Formula["guile@1.8.8"].lib

    system bin/"lilypond", "--loglevel=INFO", "test.ly"
    assert_predicate testpath/"test.pdf", :exist?
  end
end
