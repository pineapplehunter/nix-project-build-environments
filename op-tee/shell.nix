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
        tpkgs.glib
        tpkgs.gmp
        tpkgs.gnutls
        tpkgs.libmpc
        tpkgs.libxcrypt
        tpkgs.mpfr
        tpkgs.openssl
        tpkgs.pixman
        tpkgs.zlib
      ];
      runScript = "make";
      extraOutputsToInstall = [
        "lib"
        "dev"
      ];
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
