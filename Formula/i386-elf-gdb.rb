class I386ElfGdb < Formula
  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-10.1.tar.xz"
  sha256 "f82f1eceeec14a3afa2de8d9b0d3c91d5a3820e23e0a01bbb70ef9f0276b62c0"
  head "https://sourceware.org/git/binutils-gdb.git"

  depends_on "python@3.9"
  depends_on "xz"

  def install
    target = "i386-elf"

    args = %W[
      --target=#{target}
      --prefix=#{prefix}
      --disable-binutils
      --disable-debug
      --disable-dependency-tracking
      --with-lzma
      --with-python=#{Formula["python@3.9"].opt_bin}/python3
    ]

    mkdir "build" do
      system "../configure", *args

      system "make"
      system "make", "install-gdb"
    end
  end

  test do
    system "#{bin}/i386-elf-gdb", "#{bin}/i386-elf-gdb", "-configuration"
  end
end
