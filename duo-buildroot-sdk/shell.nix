let
  npins = import ./npins;
  pkgs = import npins.nixpkgs { };
in
pkgs.mkShellNoCC {
  # disable hardening on the nix side and let op-tee figure the options out
  env.NIX_HARDENING_ENABLE = "";

  # build with
  # ```sh
  # $ build ...
  # ```
  packages = [
    (pkgs.buildFHSEnv {
      pname = "build";
      version = "optee-wrapper";
      targetPkgs = tpkgs: [
        # tools
        tpkgs.ccache
        tpkgs.file
        tpkgs.gcc13 # 14 does not build
        tpkgs.gnumake
        tpkgs.pkg-config

        # libs
        tpkgs.bzip2.dev
        tpkgs.libxcrypt
        tpkgs.openssl
        tpkgs.openssl.dev
        tpkgs.xz.dev
        tpkgs.zlib
      ];
      runScript = "./build.sh";
    })

    pkgs.autoconf
    pkgs.automake
    pkgs.bc
    pkgs.bison
    pkgs.cmake
    pkgs.dtc
    pkgs.expect
    pkgs.flex
    pkgs.genext2fs
    pkgs.ninja
    pkgs.python3
    pkgs.wget
  ];
}
