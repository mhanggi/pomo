{
  description = "pomo.sh";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  outputs = { self, nixpkgs }: {
    
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      runCommandLocal "pomo.sh" {
        script = ./pomo.sh;
        nativeBuildInputs = [ makeWrapper ];
      } ''
        makeWrapper $script $out/bin/pomo.sh \
          --prefix PATH : ${lib.makeBinPath [ bash inotify-tools libnotify ]}
      '';
  };
}
