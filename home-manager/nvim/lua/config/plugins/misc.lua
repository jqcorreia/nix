return {
  -- Oil is a edit-filesystem-as-a-buffer type of deal.
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-v>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        use_default_keymaps = false,
      })
      vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory in Oil" })
    end,
  },

  -- Git support
  "tpope/vim-fugitive",
  -- Smart commenting
  {
    "tpope/vim-commentary",
    config = function()
      -- Add fix for terraform comment string
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
        callback = function(ev)
          vim.bo[ev.buf].commentstring = "# %s"
        end,
        pattern = { "terraform", "hcl" },
      })
    end,
  },

  -- Smart adding of surround quotes, parenteses, brackets, etc
  "tpope/vim-surround",
  -- Silly training game
  "ThePrimeagen/vim-be-good",
  -- Maximize and restore window. Maps to <F3>
  "szw/vim-maximizer",
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ filetypes = {} })
    end,
  },
  -- "MeanderingProgrammer/render-markdown.nvim",
}
