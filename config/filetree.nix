_: {
  neo-tree = {
    enable = true;

    setupOpts = {
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];

      enable_cursor_hijack = true;

      filesystem.group_empty_dirs = true;
    };
  };
}
