{
  description = ''Nim wrapper for libssh2 library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-haxscramper-hlibssh2-0_1_3.flake = false;
  inputs.src-github-haxscramper-hlibssh2-0_1_3.ref   = "refs/tags/0.1.3";
  inputs.src-github-haxscramper-hlibssh2-0_1_3.owner = "haxscramper";
  inputs.src-github-haxscramper-hlibssh2-0_1_3.repo  = "hlibssh2";
  inputs.src-github-haxscramper-hlibssh2-0_1_3.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-haxscramper-hlibssh2-0_1_3"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-haxscramper-hlibssh2-0_1_3";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}