#!/bin/sh
# forcibly remove packages that are not strictly required

pacman -R -dd \
mingw-w64-x86_64-SDL \
mingw-w64-x86_64-SDL2 \
mingw-w64-x86_64-adwaita-icon-theme  \
mingw-w64-x86_64-assimp \
mingw-w64-x86_64-atk \
mingw-w64-x86_64-boost \
mingw-w64-x86_64-celt \
mingw-w64-x86_64-cppunit \
mingw-w64-x86_64-dbus \
mingw-w64-x86_64-ffmpeg \
mingw-w64-x86_64-freeglut \
mingw-w64-x86_64-fribidi \
mingw-w64-x86_64-gdk-pixbuf2 \
mingw-w64-x86_64-gsm \
mingw-w64-x86_64-gtk2 \
mingw-w64-x86_64-gtkglext \
mingw-w64-x86_64-hicolor-icon-theme \
mingw-w64-x86_64-icu-debug-libs \
mingw-w64-x86_64-l-smash \
mingw-w64-x86_64-lame \
mingw-w64-x86_64-libass \
mingw-w64-x86_64-libbluray \
mingw-w64-x86_64-libcaca \
mingw-w64-x86_64-libcroco \
mingw-w64-x86_64-libmariadbclient \
mingw-w64-x86_64-libmodplug \
mingw-w64-x86_64-libogg \
mingw-w64-x86_64-librsvg \
mingw-w64-x86_64-libtheora \
mingw-w64-x86_64-libvorbis \
mingw-w64-x86_64-libvpx \
mingw-w64-x86_64-openal \
mingw-w64-x86_64-opencore-amr \
mingw-w64-x86_64-opus \
mingw-w64-x86_64-orc \
mingw-w64-x86_64-pango \
mingw-w64-x86_64-poco \
mingw-w64-x86_64-schroedinger \
mingw-w64-x86_64-shared-mime-info \
mingw-w64-x86_64-spdylay \
mingw-w64-x86_64-speex \
mingw-w64-x86_64-speexdsp \
mingw-w64-x86_64-wavpack \
mingw-w64-x86_64-wxWidgets \
mingw-w64-x86_64-x264-git \
mingw-w64-x86_64-x265 \
mingw-w64-x86_64-xvidcore \
mingw-w64-x86_64-zziplib
