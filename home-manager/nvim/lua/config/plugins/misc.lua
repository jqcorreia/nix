return {
  -- Oil is a edit-filesystem-as-a-buffer type of deal.
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
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
