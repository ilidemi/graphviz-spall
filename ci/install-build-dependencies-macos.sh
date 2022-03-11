#!/usr/bin/env bash

set -e
set -o pipefail
set -u
set -x

brew update
brew install autogen || brew upgrade autogen
brew install automake || brew upgrade automake
brew install cmake || brew upgrade cmake
brew install bison || brew upgrade bison

# quoting Homebrew:
#
#   bison is keg-only, which means it was not symlinked into /usr/local,
#   because macOS already provides this software and installing another version
#   in parallel can cause all kinds of trouble.
#
#   If you need to have bison first in your PATH, run:
#     echo 'export PATH="/usr/local/opt/bison/bin:$PATH"' >> ~/.zshrc
#
#   For compilers to find bison you may need to set:
#     export LDFLAGS="-L/usr/local/opt/bison/lib"
export PATH="/usr/local/opt/bison/bin:$PATH"

brew install pango || brew upgrade pango
brew install qt5 || brew upgrade qt5

# quoting Homebrew:
#
#   qt@5 is keg-only, which means it was not symlinked into /usr/local,
#   because this is an alternate version of another formula.
#
#   If you need to have qt@5 first in your PATH, run:
#     echo 'export PATH="/usr/local/opt/qt@5/bin:$PATH"' >> ~/.zshrc
#
#   For compilers to find qt@5 you may need to set:
#     export LDFLAGS="-L/usr/local/opt/qt@5/lib"
#     export CPPFLAGS="-I/usr/local/opt/qt@5/include"
#
#   For pkg-config to find qt@5 you may need to set:
#     export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"
export PATH="/usr/local/opt/qt@5/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt@5/lib"
export CPPFLAGS="-I/usr/local/opt/qt@5/include"
export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"

brew install libxaw || brew upgrade libxaw
