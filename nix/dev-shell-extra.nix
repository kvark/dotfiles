{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell rec {
  buildInputs = with pkgs; [
    llvmPackages_latest.llvm
    llvmPackages_latest.bintools
    llvmPackages_latest.lld
    zlib.out
    rustup
    wasm-bindgen-cli
    xorriso
    cmake
    grub2
    glfw3
    qemu
    python3
    xorg.libX11
    xorg.libXrandr
  ];
  RUSTC_VERSION = "stable";
  # https://github.com/rust-lang/rust-bindgen#environment-variables
  # https://discourse.nixos.org/t/how-to-correctly-populate-a-clang-and-llvm-development-environment-using-nix-shell/3864
  LIBCLANG_PATH= pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
  HISTFILE=toString ./.history;
  shellHook = ''
    export PATH=$PATH:~/.cargo/bin
    export PATH=$PATH:~/.rustup/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
    '';
  # Add libvmi precompiled library to rustc search path
  RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
    pkgs.libvmi
  ]);
  # Add libvmi, glibc, clang, glib headers to bindgen search path
  BINDGEN_EXTRA_CLANG_ARGS = 
  # Includes with normal include path
  (builtins.map (a: ''-I"${a}/include"'') [
    pkgs.libvmi
    pkgs.glibc.dev 
  ])
  # Includes with special directory paths
  ++ [
    ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
    ''-I"${pkgs.glib.dev}/include/glib-2.0"''
    ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
  ];

}
