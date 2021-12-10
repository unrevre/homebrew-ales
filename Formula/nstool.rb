class Nstool < Formula
  desc "general purpose reading/extraction tool for Nintendo Switch file formats"
  homepage "https://github.com/jakcron/nstool"
  head "https://github.com/jakcron/nstool.git"

  def install
    system "make deps && make"
    bin.install "bin/nstool"
  end

  test do
    system "true"
  end
end
