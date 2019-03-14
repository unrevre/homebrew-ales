class I386ElfGdb < Formula
  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftp.gnu.org/gnu/gdb/gdb-8.2.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gdb/gdb-8.2.1.tar.xz"
  sha256 "0a6a432907a03c5c8eaad3c3cffd50c00a40c3a5e3c4039440624bae703f2202"
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
