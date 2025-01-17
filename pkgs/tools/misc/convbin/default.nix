{ lib, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "convbin";
  version = "3.4";

  src = fetchFromGitHub {
    owner = "mateoconlechuga";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-JM9ixxOI3NnK3h54byFycTCJ/A+JTcNHKR71zxRed/s=";
  };

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];

  checkPhase = ''
    pushd test
    patchShebangs test.sh
    ./test.sh
    popd
  '';

  doCheck = true;

  installPhase = ''
    install -Dm755 bin/convbin $out/bin/convbin
  '';

  meta = with lib; {
    description = "Converts files to other formats";
    longDescription = ''
      This program is used to convert files to other formats,
      specifically for the TI84+CE and related calculators.
    '';
    homepage = "https://github.com/mateoconlechuga/convbin";
    license = licenses.bsd3;
    maintainers = with maintainers; [ luc65r ];
    platforms = platforms.all;
  };
}
