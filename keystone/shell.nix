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
        p.bash
        p.bc
        p.ccache
        p.file
        p.gcc12Stdenv.cc # use older version of gcc to build keystone. gcc 14 did not work.
        p.gnumake
        p.libxcrypt-legacy
        p.makeself
        p.ncurses
        p.openssh
        p.perl
        p.unzip
        p.wget
        p.which
      ];
      runScript = "make";
    })
  ];
}
