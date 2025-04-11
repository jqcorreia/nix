return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_filetypes = {
      ["*"] = true,
      ["markdown"] = false,
      ["text"] = false,
      ["gitcommit"] = false,
      ["gitrebase"] = false,
      ["svn"] = false,
      ["help"] = false,
      ["odin"] = false,
    }
    vim.keymap.set("n", "<leader>cc", function()
      if vim.b.copilot_enabled == nil then
        vim.b.copilot_enabled = true
      end
      vim.b.copilot_enabled = not vim.b.copilot_enabled
      print("Copilot " .. (vim.b.copilot_enabled and "enabled" or "disabled"))
    end, { desc = "Toggle Copilot" })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "solarized",
      -- group = ...,
      callback = function()
        vim.api.nvim_set_hl(0, "CopilotSuggestion", {
          fg = "#555555",
          ctermfg = 8,
          force = true,
        })
      end,
    })
  end,
}
