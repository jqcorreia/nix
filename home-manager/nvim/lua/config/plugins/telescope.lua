return {
  "nvim-telescope/telescope.nvim",
  -- config = function()
  --     require("telescope").setup({
  --         defaults = require("telescope.themes").get_default({ layout_config = { height = 0.75 } }),
  --     })
  -- end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
    },
  },
  config = function()
    -- telescope bindings
    vim.keymap.set("n", "<leader>pb", require("telescope.builtin").buffers)
    vim.keymap.set("n", "<leader>ps", require("telescope.builtin").live_grep)
    vim.keymap.set("n", "<leader>hs", require("telescope.builtin").search_history)
    vim.keymap.set("n", "<leader>hc", require("telescope.builtin").command_history)
    vim.keymap.set("n", "<c-p>", function()
      require("telescope.builtin").find_files({ hidden = true, file_ignore_patterns = { ".git/", "**/.terraform" } })
    end)
    vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols,
      { desc = "[D]ocument [S]ymbols" })
    vim.keymap.set("n", "<leader>km", require("telescope.builtin").keymaps)
    vim.keymap.set("n", "<leader>hh", require("telescope.builtin").help_tags)
    vim.keymap.set("n", "<leader>ep", function()
      require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("data") .. "/lazy" })
    end)
  end
}
