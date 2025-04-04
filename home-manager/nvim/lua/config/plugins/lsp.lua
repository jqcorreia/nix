local is_nix

if os.getenv("NIX_PATH") == nil then
  is_nix = false
else
  is_nix = true
end

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--fallback-style=webkit"
    }
  },
  gopls = {},
  jsonls = { init_options = { provideFormatter = true } },
  rust_analyzer = {},
  ruff = {},
  pyright = {},
  terraformls = {},
  ols = {},
  ts_ls = {},
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {
        workspace = { checkthirdparty = false },
        telemetry = { enable = false },
        -- note: toggle below to ignore lua_ls's noisy `missing-fields` warnings
        diagnostics = {
          disable = { "missing-fields" },
          globals = { "vim" },
        }
      }
    }
  }
}

if is_nix then
  servers.nil_ls = {
    settings = {
      ["nil"] = {
        formatting = { command = { "nixfmt" } }
      }
    }
  }
end

local on_attach = function(args)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "lsp: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
  end
  local vmap = function(keys, func, desc)
    if desc then
      desc = "lsp: " .. desc
    end

    vim.keymap.set("v", keys, func, { buffer = args.buf, desc = desc })
  end

  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client == nil then
    -- Bail if client not found
    return
  end

  if client.supports_method('textDocument/rename') then
    -- Create a keymap for vim.lsp.buf.rename()
    nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
  end
  if client.supports_method('textDocument/implementation') then
    -- Create a keymap for vim.lsp.buf.implementation
  end
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = args.buf,
      desc = "Format on save",
      callback = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      end
    })
  end


  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
  vmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
end

local dependencies

if not is_nix then
  dependencies = {
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    "j-hui/fidget.nvim",

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/lazydev.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }
else
  dependencies = {
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    "j-hui/fidget.nvim",
    -- Additional lua configuration, makes nvim stuff amazing!
    { "folke/lazydev.nvim", ft = "lua" },
  }
end

return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = dependencies,
  config = function()
    if not is_nix then
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- 	mason_lspconfig.setup_handlers({
      -- 	function(server_name)
      -- 		require("lspconfig")[server_name].setup({
      -- 			capabilities = capabilities,
      -- 			on_attach = on_attach,
      -- 			settings = servers[server_name],
      -- 			filetypes = (servers[server_name] or {}).filetypes,
      -- 			cmd = (servers[server_name] or {}).cmd,
      -- 		})
      -- 	end,
      -- })
    end

    vim.api.nvim_create_autocmd("LspAttach", { desc = "LSP actions", callback = on_attach })
    for server, config in pairs(servers) do
      require("lspconfig")[server].setup(config)
    end
  end
}
