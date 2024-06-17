{
  # Read all files in a directory
  filesIn = dir:
    (map (fname: dir + "/${fname}")
      (builtins.attrNames (builtins.readDir dir)));
}
