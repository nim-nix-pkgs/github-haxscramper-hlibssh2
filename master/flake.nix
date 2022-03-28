{
  description = ''Nim wrapper for libssh2 library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-github-haxscramper-hlibssh2-master.flake = false;
  inputs.src-github-haxscramper-hlibssh2-master.ref   = "refs/heads/master";
  inputs.src-github-haxscramper-hlibssh2-master.owner = "haxscramper";
  inputs.src-github-haxscramper-hlibssh2-master.repo  = "hlibssh2";
  inputs.src-github-haxscramper-hlibssh2-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-github-haxscramper-hlibssh2-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-github-haxscramper-hlibssh2-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}