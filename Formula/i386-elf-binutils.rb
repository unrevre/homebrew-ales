class I386ElfBinutils < Formula
  desc "GNU binary tools for native development, targeting i386-elf"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.35.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.35.1.tar.gz"
  sha256 "a8dfaae8cbbbc260fc1737a326adca97b5d4f3c95a82f0af1f7455ed1da5e77b"

  def install
    target = "i386-elf"

    args = %W[
      --target=#{target}
      --prefix=#{prefix}
      --with-sysroot
      --disable-multilib
      --disable-nls
      --disable-werror
    ]

    mkdir "build" do
      system "../configure", *args

      system "make"
      system "make", "install"
    end
  end

  test do
    assert_match "f()", shell_output("#{bin}/i386-elf-c++filt _Z1fv")
  end
end
