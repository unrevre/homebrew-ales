class I386ElfBinutils < Formula
  desc "GNU binary tools for native development, targeting i386-elf"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.gz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.32.tar.gz"
  sha256 "9b0d97b3d30df184d302bced12f976aa1e5fbf4b0be696cdebc6cca30411a46e"

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
