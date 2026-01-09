return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- DAP UI setup
    dapui.setup()

    -- Auto open/close dap-ui
    dap.listeners.after.event_initialized["dapui"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui"] = function()
      dapui.close()
    end
    dap.listeners.before.disconnect["dapui"] = function()
      dapui.close()
    end
    -----------------------------------------------------------
    -- Odin configuration
    -----------------------------------------------------------
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    }

    dap.configurations.odin = {
      {
        name = "Build & Debug Odin",
        type = "cppdbg",
        request = "launch",
        program = function()
          -- build output binary path
          return vim.fn.getcwd() .. "/build/debug"
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        MIMode = "gdb",
        setupCommands = {
          {
            description = "Enable pretty printing",
            text = "-enable-pretty-printing",
            ignoreFailures = true,
          },
        },
        preLaunchTask = function()
          -- build command
          local cmd = {
            "odin",
            "build",
            ".",
            "-debug",
            "-o:none",
            "-out:build/debug",
          }

          vim.fn.mkdir("build", "p")
          local result = vim.fn.system(cmd)

          if vim.v.shell_error ~= 0 then
            error("Odin build failed:\n" .. result)
          end
        end,
      },
    }
    -----------------------------------------------------------
    -- Keymaps
    -----------------------------------------------------------
    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end)
    vim.keymap.set("n", "<leader>dr", dap.repl.open)
    vim.keymap.set("n", "<leader>dq", dap.terminate)
    -- Example configuration for Python
    -- dap.adapters.python = {
    --   type = "executable",
    --   command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
    --   args = { "-m", "debugpy.adapter" },
    -- }
    -- dap.configurations.python = {
    --   {
    --     type = "python",
    --     request = "launch",
    --     name = "Launch file",
    --     program = "${file}",
    --     pythonPath = function()
    --       return os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python"
    --     end,
    --   },
    -- }

    -- You can add more configurations for other languages here
  end,
}
