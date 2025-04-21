let
  npins = import ./npins;
  pkgs = import npins.nixpkgs { };
in
pkgs.mkShellNoCC {
  env.NIX_HARDENING_ENABLE = "";

  packages = [
    (pkgs.buildFHSEnv {
      pname = "make";
      version = "optee-wrapper";
      targetPkgs = tpkgs: [
        # tools
        tpkgs.file
        tpkgs.gcc
        tpkgs.gnumake
        tpkgs.pkg-config
        tpkgs.which

        # libs
        tpkgs.glib.dev
        tpkgs.gmp.dev
        tpkgs.libmpc
        tpkgs.libxcrypt
        tpkgs.mpfr.dev
        tpkgs.openssl
        tpkgs.openssl.dev
        tpkgs.pixman
        tpkgs.zlib.dev
      ];
      runScript = "make";
    })

    pkgs.bc
    pkgs.bison
    pkgs.ccache
    pkgs.cmake
    pkgs.cpio
    pkgs.curl
    pkgs.dtc
    pkgs.flex
    pkgs.flock
    pkgs.git
    pkgs.git-repo
    pkgs.meson
    pkgs.ncurses
    pkgs.netcat
    pkgs.ninja
    pkgs.perl
    pkgs.rsync
    pkgs.unzip
    pkgs.wget

    (pkgs.python3.withPackages (ps: [
      ps.cryptography
      ps.pyelftools
    ]))

    # terminal
    pkgs.xterm
  ];
}
