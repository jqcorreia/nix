-- colorpicker
-- Author: José Quadrado
-- Really simple colorpicker inspired by telescope but nothing like it
-- TODO:
-- Fuzzy search
-- Remove line numbers
-- Preview?
local function colorpicker_open()
  local buf = vim.api.nvim_create_buf(false, true)
  local colorschemes = vim.split(vim.fn.globpath(vim.o.runtimepath, "colors/*"), "\n")

  vim.api.nvim_buf_set_text(
    buf,
    0,
    0,
    0,
    0,
    vim.tbl_map(function(x)
      local tokens = vim.split(x, "/")
      local last_token = tokens[#tokens]
      return vim.split(last_token, ".", { plain = true })[1]
    end, colorschemes)
  )
  local win = vim.api.nvim_open_win(
    buf,
    true,
    { relative = "editor", width = 40, height = 20, row = 100, col = 100, bufpos = { 100, 100 } }
  )
  vim.keymap.set("n", "<Enter>", function()
    local selected = vim.api.nvim_get_current_line()
    print(selected)
    vim.api.nvim_win_close(0, true)
    vim.cmd.colorscheme(selected)
  end, { buffer = buf })

  vim.keymap.set("n", "<C-p>", function()
    local cursor = vim.api.nvim_win_get_cursor(win)
    local new_row = math.max(1, cursor[1] - 1)
    local new_cursor = { new_row, 1 }
    vim.api.nvim_win_set_cursor(win, new_cursor)

    print(vim.inspect(cursor))
  end, { buffer = buf })

  vim.keymap.set("n", "<C-n>", function()
    local cursor = vim.api.nvim_win_get_cursor(win)
    local new_row = math.min(vim.api.nvim_buf_line_count(buf), cursor[1] + 1)
    local new_cursor = { new_row, 1 }
    print(vim.inspect(new_cursor))
    vim.api.nvim_win_set_cursor(win, new_cursor)
  end, { buffer = buf })
end

local function setup()
  vim.api.nvim_create_user_command("Colorpicker", colorpicker_open, {})
  vim.keymap.set("n", "<leader>cp", colorpicker_open)
end

local function set_colorscheme(color)
  vim.cmd.colorscheme(color)
end

return { setup = setup, set_colorscheme = set_colorscheme }
