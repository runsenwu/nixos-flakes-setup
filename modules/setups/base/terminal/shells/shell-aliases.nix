{ pkgs, lib, ... }:
{
  home.shellAliases = {
    # modern replacements
    la = "ls -a";
    ll = "ls -l";
    cat = "bat";
    find = "fd";
    grep = "rg";

    # git
    g = "git";
    ga = "git add";
    gc = "git commit";
    gca = "git commit --amend";
    gpsh = "git push";
    gpul = "git pull";
    gst = "git status";
    gco = "git checkout";
    gb = "git branch";
    gbb = "git branch -b";
    gd = "git diff";
    glg = "git log --graph --decorate --oneline --all";

    # nav + zoxide
    z = "z";
    zz = "z -r";
    ".." = "cd ..";
    "..." = "cd ../..";

    # yazi
    yz = "yazi";

    # archives
    untar = "tar -xvf";
    targz = "tar -czvf";

    # misc
    # path = "echo $env.PATH | tr ':' '\\n'";
    nrsf = "sudo nixos-rebuild switch --flake .#nixos";

    zd = "zeditor";
  };
}
