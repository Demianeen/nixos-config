{ lib, stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "SbarLua";
  version = "2024-02-27";
  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = pname;
    rev = "29395b1928835efa1b376d438216fbf39e0d0f83";
    sha256 = "sha256-C2tg1mypz/CdUmRJ4vloPckYfZrwHxc4v8hsEow4RZs";
  };

  buildInputs = with pkgs; [ lua5_4 gcc readline ];
  installPhase = ''
    mkdir -p $out/bin
    cp ./bin/sketchybar.so $out/bin/
  '';

  meta = with lib; {
    description = "SketchyBar Lua Plugin";
    homepage = "https://github.com/FelixKratz/SbarLua";
    platforms = platforms.darwin;
  };
}
