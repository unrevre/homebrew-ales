class Hed < Formula
  desc "fast hexadecimal editor"
  homepage "https://pasky.or.cz/dev/hed/"
  head "https://repo.or.cz/hed.git"

  patch do
    url "https://raw.githubusercontent.com/unrevre/homebrew-ales/ab575ba51ea111f6faf055fb5402fd86fe18d010/patches/hed-macos-build.patch"
    sha256 "d768d8616f88a7decbf06bbff9ead27fafb014c96ca98c9fdf5cedd296402168"
  end

  def install
    ENV.deparallelize

    system "make"
    bin.install "src/hed"
  end

  test do
    system "true"
  end
end
