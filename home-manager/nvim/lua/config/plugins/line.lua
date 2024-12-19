local line = "lualine"
if line == "lualine" then
  -- Lua line configuration
  return {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "gruvbox",
          component_separators = { "", "" },
          section_separators = { "", "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  }
elseif line == "mini" then
  return {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })
    end
  }
end
