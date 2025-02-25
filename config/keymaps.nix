[
  {
    key = "<leader>w";
    mode = "n";
    silent = true;
    action = "<cmd>w<CR>";
    desc = "Save buffer";
  }

  {
    key = "<leader>q";
    mode = "n";
    silent = true;
    action = "<cmd>q<CR>";
    desc = "Close buffer";
  }

  {
    key = "<leader>;";
    mode = "n";
    silent = true;
    action = "<cmd>Neotree source=filesystem reveal=true<CR>";
    desc = "Open Neotree (filesystem)";
  }

  {
    key = "<leader>:";
    mode = "n";
    silent = true;
    action = "<cmd>Neotree source=document_symbols reveal=true<CR>";
    desc = "Open Neotree (symbols)";
  }
]
