class GbdkN < Formula
    desc "Libraries for modern Game Boy development using C and the SDCC compiler."
    homepage "https://github.com/michaelgosling/gbdk-n"
    url "https://github.com/michaelgosling/gbdk-n/archive/c8cb024e92019e6d3523c4b804233e10353435da.tar.gz"
    version "2.96-gander"
    sha256 "7eb1f760dbc4780cc9cddf21eb0e838c84b7a3a384bb4adba6ab405d2b506c52"
  
    depends_on "sdcc"
  
    def install
      system "make"
  
      binaries = %w[bin/gbdk-n-assemble.sh bin/gbdk-n-compile.sh bin/gbdk-n-link.sh]
      inreplace binaries, /GBDK_DIR=".+"$/, "GBDK_DIR=\"#{pkgshare}\""
  
      bin.install binaries
      bin.install "bin/gbdk-n-make-rom.sh"
      pkgshare.install "include", "lib"
    end
  
    test do
      (testpath/"game.c").write <<-EOS.undent
        #include <gb/gb.h>
        #include <gb/drawing.h>
        void main() {
          gprintf("Hello Game Boy!");
        }
      EOS
  
      system "sdcc -mgbz80 --no-std-crt0 -I \"#{pkgshare}/include\" -I \"#{pkgshare}/include/asm\" -L \"#{pkgshare}/lib\" -l gb.lib game.c"
    end
  end