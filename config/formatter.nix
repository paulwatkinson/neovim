{pkgs, ...}: {
  conform-nvim = {
    enable = true;
    setupOpts = {
      formatters_by_ft.clojure = ["cljfmt"];
      formatters_by_ft.edn = ["cljfmt"];
      formatters.cljfmt = {
        command = "${pkgs.cljfmt}/bin/cljfmt";
        args = ["fix" "-"];
        stdin = true;
      };
    };
  };
}
