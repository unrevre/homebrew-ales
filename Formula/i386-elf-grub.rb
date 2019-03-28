class I386ElfGrub < Formula
  desc "GNU Multiboot boot loader, targeting i386-elf"
  homepage "https://www.gnu.org/software/grub/index.html"
  url "https://ftp.gnu.org/gnu/grub/grub-2.02.tar.gz"
  mirror "https://ftpmirror.gnu.org/gnu/grub/grub-2.02.tar.gz"
  sha256 "660ee136fbcee08858516ed4de2ad87068bfe1b6b8b37896ce3529ff054a726d"

  depends_on "unrevre/ales/i386-elf-binutils" => :build
  depends_on "unrevre/ales/i386-elf-gcc" => :build

  def install
    target = "i386-elf"

    args = %W[
      --target=#{target}
      --prefix=#{prefix}
      --program-prefix=i386-elf-
      --disable-nls
      --disable-werror

      TARGET_CC=i386-elf-gcc
      TARGET_OBJCOPY=i386-elf-objcopy
      TARGET_STRIP=i386-elf-strip
      TARGET_NM=i386-elf-nm
      TARGET_RANLIB=i386-elf-ranlib
    ]

    mkdir "build" do
      system "../configure", *args

      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/i386-elf-grub-mkstandalone",  "--version"
  end
end
