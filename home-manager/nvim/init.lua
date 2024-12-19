-- Author: José Quadrado
-- Version: 0.5
-- Inspiration:
-- - Kickstart
-- - Primagen nvim config from scratch videos

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.exrc = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.sw = 4

vim.o.hlsearch = false
vim.o.hidden = true
vim.o.incsearch = true
vim.o.scrolloff = 8

vim.o.splitright = true

vim.o.wrap = false
vim.o.mouse = "a"               -- enable mouse on all modes
vim.o.clipboard = "unnamedplus" -- yank into system clipboard

-- Fix for floating window purple color as stated here
-- https://github.com/nvim-telescope/telescope.nvim/issues/2145
-- TODO: I believe this is not needed anymore. Leaving it here for the time being
-- vim.api.nvim_set_hl(0, "NormalFloat", { fg = "LightGrey" })

-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  spec = {
    -- All nice and pretty separated by concerns
    { import = "config/plugins" },

    -- Own very own homebrew plugin, the colorpicker, maps to <leader>cp
    {
      dir = "/home/jqcorreia/.config/nvim/colorpicker",
      config = function()
        local cp = require("colorpicker")
        cp.setup()
        cp.set_colorscheme("gruvbox")

        -- vim.cmd("colorscheme gruvbox")
      end,
    }
  }
})

vim.api.nvim_create_autocmd("Colorscheme", {
  group = vim.api.nvim_create_augroup("Colorscheme", { clear = true }),
  callback = function(ev)
    -- Set transparent background
    vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none" })
  end,
})

-- Gruvbox FTW
vim.cmd.colorscheme("gruvbox")

-- save with ctrl-s
vim.keymap.set("n", "<c-s>", ":w<cr>", {})
vim.keymap.set("i", "<c-s>", "<c-c><cmd> :w <cr>", {})

-- terminal mode
vim.keymap.set("t", "<leader>w", "<c-w><c-w>", {})
vim.keymap.set("t", "<C-m>", "<c-\\><c-n>", {})
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd(":vnew")
  vim.cmd(":term")
end)

-- panel navigation
vim.keymap.set("n", "<leader>w", "<c-w><c-w>", { desc = "Cycle window focus" })
vim.keymap.set("n", "<M-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<M-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

-- text navigation and search
vim.keymap.set("", "<c-h>", "^")
vim.keymap.set("", "<c-l>", "g_")
vim.keymap.set("n", "<leader>s", "/")

-- insert mode navigation
vim.keymap.set("i", "<c-h>", "<Left>")
vim.keymap.set("i", "<c-l>", "<Right>")
vim.keymap.set("i", "<c-j>", "<Down>")
vim.keymap.set("i", "<c-k>", "<Up>")

-- quickfix
vim.keymap.set("n", "<M-j>", "<cmd> cnext <CR>", { desc = "Next item in quickfix" })
vim.keymap.set("n", "<M-k>", "<cmd> cprev <CR>", { desc = "Previous item in quickfix" })

-- misc
vim.keymap.set("n", "-", function()
  vim.cmd("Oil")
end)
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "<leader>cr", "<cmd>! cargo run <cr>")
vim.keymap.set("n", "<leader>q", "<cmd> :q <cr>")
vim.keymap.set("n", "<leader>aa", "gg0vG$")
vim.keymap.set("n", "<leader>run", "<cmd> so % <cr>")
vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.open_float()
end)
vim.keymap.set("n", "<leader>v", "<cmd> vnew <cr>", { desc = "Open [v]ertical [n]ew" })
vim.keymap.set("n", "<leader>ec", function()
  vim.cmd("e ~/.config/nvim/init.lua")
end, { desc = "[E]dit [C]onfig" })
