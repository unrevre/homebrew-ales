class I386ElfGdb < Formula
  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftp.gnu.org/gnu/gdb/gdb-8.3.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-8.3.tar.xz"
  sha256 "802f7ee309dcc547d65a68d61ebd6526762d26c3051f52caebe2189ac1ffd72e"
  head "https://sourceware.org/git/binutils-gdb.git"

  depends_on "pkg-config" => :build

  def install
    target = "i386-elf"

    args = %W[
      --target=#{target}
      --prefix=#{prefix}
      --disable-binutils
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
