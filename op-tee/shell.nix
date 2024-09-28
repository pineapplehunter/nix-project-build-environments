let
  npins = import ./npins;
  pkgs = import npins.nixpkgs { };
in
(pkgs.buildFHSEnv {
  name = "optee-env";
  targetPkgs =
    tpkgs:
    builtins.attrValues {
      inherit (tpkgs)
        git
        git-repo
        dtc
        ccache
        ninja
        pkg-config
        flex
        bison
        bc
        pixman
        which
        file
        wget
        meson
        cmake
        curl
        perl
        cpio
        unzip
        rsync
        flock
        netcat
        xterm
        ;
      openssl = tpkgs.openssl.dev;
      glib = tpkgs.glib.dev;
      libz = tpkgs.libz.dev;
      python-env = tpkgs.python3.withPackages (
        ps:
        builtins.attrValues {
          inherit (ps)
            cryptography
            pyelftools
            ;
        }
      );
      host-cc = tpkgs.stdenv.cc;
    };
  profile = ''
    export NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
    export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
  '';
}).env
