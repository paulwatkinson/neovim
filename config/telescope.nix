{pkgs, ...}: {
  enable = true;

  setupOpts.defaults.vimgrep_arguments = [
    "${pkgs.ripgrep}/bin/rg"
    "--color=never"
    "--no-heading"
    "--with-filename"
    "--line-number"
    "--column"
    "--smart-case"
    "--no-ignore"
  ];
}
