let
  npins = import ./npins;
  pkgs = import npins.nixpkgs { };
in
# use no cc so the path does not interfere with fhs env
pkgs.mkShellNoCC {
  packages = [
    # use a custom make wrapper instead of gnumake to build keystone
    (pkgs.buildFHSEnv {
      pname = "make";
      version = "keystone";
      targetPkgs = p: [
        p.file
        p.gnumake
        p.libxcrypt-legacy
      ];
      runScript = "make";
    })

    pkgs.bc
    pkgs.ccache
    pkgs.gcc13 # use older version of gcc to build keystone. gcc 14 did not work.
    pkgs.makeself
    pkgs.ncurses
    pkgs.openssh
    pkgs.perl
    pkgs.unzip
    pkgs.wget
    pkgs.which
  ];
  env.NIX_HARDENING_ENABLE = "";
}
