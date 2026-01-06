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
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    })

    vim.keymap.set("n", "<leader>ff", function()
      require("conform").format(format_exec_config)
    end, { desc = "[ff]ormat" })
  end,
}
