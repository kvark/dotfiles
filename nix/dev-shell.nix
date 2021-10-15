with import <nixpkgs> {};
mkShell {
  buildInputs = [
    # rust
    gdb
    cargo
    rustc
    rustfmt
    clippy
    # xserver
    xorg.libX11
    xorg.libXi
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXext
    xorg.libxshmfence
    xorg.libXxf86vm
    libxkbcommon
    wayland
    wayland-protocols
    # libraries
    libdrm
    libelf
    alsaLib
    llvmPackages_11.llvm
    # tools
    cmake
    meson
    ninja
    pkgconfig
    python
    (python3.withPackages(ps: [
      ps.setuptools
      ps.Mako
    ]))
    bison
    flex
    zip
    # vulkan
    glslang
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    # apps
    mangohud
  ];
  
  LIB_PATH = lib.makeLibraryPath [
    vulkan-loader
    xorg.libX11
    xorg.libXi
    xorg.libXcursor
    xorg.libXrandr
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$LIB_PATH";
  '';
}
