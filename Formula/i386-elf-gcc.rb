class I386ElfGcc < Formula
  desc "GNU compiler collection, targeting i386-elf, for C"
  homepage "https://gcc.gnu.org/"
  url "https://ftp.gnu.org/gnu/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcc/gcc-9.2.0/gcc-9.2.0.tar.xz"
  sha256 "ea6ef08f121239da5695f76c9b33637a118dcf63e24164422231917fa61fb206"
  head "https://gcc.gnu.org/git/gcc.git"

  depends_on "isl"
  depends_on "gmp"
  depends_on "unrevre/ales/i386-elf-binutils"
  depends_on "libmpc"
  depends_on "mpfr"

  def install
    target = "i386-elf"
    languages = %w[c]

    args = %W[
      --target=#{target}
      --prefix=#{prefix}
      --enable-languages=#{languages.join(",")}
      --with-as=#{Formula["i386-elf-binutils"].bin}/i386-elf-as
      --with-ld=#{Formula["i386-elf-binutils"].bin}/i386-elf-ld
      --without-headers
      --disable-multilib
      --disable-nls
    ]

    mkdir "build" do
      system "../configure", *args

      system "make", "all-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-gcc"
      system "make", "install-target-libgcc"
    end
  end

  test do
    (testpath/"test-c.c").write <<~EOS
      int main(void)
      {
        int i=0;
        while(i<10) i++;
        return i;
      }
    EOS
    system "#{bin}/i386-elf-gcc", "-c", "-o", "test-c.o", "test-c.c"
    assert_match "file format elf32-i386", shell_output("#{Formula["i386-elf-binutils"].bin}/i386-elf-objdump -a test-c.o")
  end
end
