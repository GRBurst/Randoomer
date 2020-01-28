{ }:

let

  projectName = "Randoomer";

  pkgs = import <nixpkgs> { };
  flutterPkgs = (import (builtins.fetchTarball "https://github.com/babariviere/nixpkgs/archive/flutter-init.tar.gz")  {});
  dartPkgs    = (import (builtins.fetchTarball "https://github.com/GRBurst/nixpkgs/archive/dart.tar.gz")              {});

in
  pkgs.stdenv.mkDerivation {
    name = "${projectName}";
    buildInputs = with pkgs; [
      flutterPkgs.flutter
      dartPkgs.dart
      android-studio
      fastlane
      git
    ];

    shellHook=''
      echo -e "\e[0;32mWelcome to ${projectName} Development\e[m"
      echo -e "It is advised to add \e[1;34mprograms.adb.enable = true;\e[m to your nix configuration"
      echo -e "Furthermore, add your user to the \e[1;34madbusers\e[m group."
      export PATH="~/projects/fdroidserver:$PATH"
    '';
  }

