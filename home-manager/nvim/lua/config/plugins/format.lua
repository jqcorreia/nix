local formatters_by_ft = {
  lua = { "stylua" }
}

return {
  "stevearc/conform.nvim",
  config = function()
    local format_exec_config = { lsp_fallback = true, quiet = true, async = true }
    require("conform").setup({
      formatters_by_ft = formatters_by_ft,
      format_after_save = format_exec_config,
    })

    vim.keymap.set("n", "<leader>ff", function()
      require("conform").format(format_exec_config)
    end, { desc = "[ff]ormat" })
  end,
}
