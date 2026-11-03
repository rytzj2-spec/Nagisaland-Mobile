#!/bin/sh
# Reproduce: static musl 7zz (Alone2, with RAR) for aarch64 + armv7 via zig 0.16.0
set -e
pip install ziglang --break-system-packages
W=/tmp/7zbuild; mkdir -p $W/bin $W/out
[ -d $W/src ] || git clone --depth 1 --branch 26.03 https://github.com/ip7z/7zip $W/src
for t in aarch64-linux-musl arm-linux-musleabihf; do
  printf '#!/bin/sh\nexec python3 -m ziglang cc -target %s "$@"\n'  $t > $W/bin/$t-cc
  printf '#!/bin/sh\nexec python3 -m ziglang c++ -target %s "$@"\n' $t > $W/bin/$t-c++
done
chmod +x $W/bin/*
# armv7-only guard (no-op unless -DZ7_NO_ARM32_HW_CRYPTO is passed)
cd $W/src
grep -q Z7_NO_ARM32_HW_CRYPTO C/AesOpt.c || sed -i 's/^\(           Z7_CLANG_VERSION > 170001)\)$/\1 \&\& !defined(Z7_NO_ARM32_HW_CRYPTO)/' \
  C/Aes.c C/AesOpt.c C/Sha1.c C/Sha1Opt.c C/Sha256.c C/Sha256Opt.c CPP/7zip/Crypto/MyAes.cpp
cd $W/src/CPP/7zip/Bundles/Alone2
make -f makefile.gcc -j3 O=b/arm64 CC=$W/bin/aarch64-linux-musl-cc CXX=$W/bin/aarch64-linux-musl-c++ \
  CFLAGS_WARN_WALL=-Wall LDFLAGS_STATIC_3=-static LFLAGS_STRIP=-s
cp b/arm64/7zz $W/out/7zz-arm64-musl
make -f makefile.gcc -j3 O=b/armv7 CC=$W/bin/arm-linux-musleabihf-cc CXX=$W/bin/arm-linux-musleabihf-c++ \
  CFLAGS_WARN_WALL=-Wall CFLAGS_BASE2=-DZ7_NO_ARM32_HW_CRYPTO CXXFLAGS_BASE2=-DZ7_NO_ARM32_HW_CRYPTO \
  LDFLAGS_STATIC_3=-static LFLAGS_STRIP=-s
cp b/armv7/7zz $W/out/7zz-armv7-musl
