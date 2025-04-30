[
  {
    key = "<leader>w";
    mode = "n";
    silent = true;
    action = "<cmd>w<CR>";
    desc = "Save buffer";
  }

  {
    key = "<leader>W";
    mode = "n";
    silent = true;
    action = "<cmd>wa<CR>";
    desc = "Save all buffers";
  }

  {
    key = "<leader>q";
    mode = "n";
    silent = true;
    action = "<cmd>q<CR>";
    desc = "Close buffer";
  }

  {
    key = "<leader>Q";
    mode = "n";
    silent = true;
    action = "<cmd>qa<CR>";
    desc = "Close all buffers";
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

  {
    key = "<leader>fG";
    mode = "n";
    silent = true;
    action = "<cmd>lua require('telescope.builtin').live_grep({additional_args = {'--hidden'}})<CR>";
    desc = "Live grep (inc. hidden) [Telescope]";
  }
]
