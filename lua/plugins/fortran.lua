return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({})
    end,
  },

  -- Mason LSP config to ensure fortls is installed
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "fortls" },
      })
    end,
  },

  -- LSP configuration for Fortran
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.fortls.setup({
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr }),
      })
    end,
  },

  -- Linting support
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      local gfortran_diagnostic_args = { "-Wall", "-Wextra", "-fmax-errors=5" }

      local pattern = "^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$"
      local groups = { "file", "lnum", "col", "severity", "message" }
      local severity_map = {
        ["Error"] = vim.diagnostic.severity.ERROR,
        ["Warning"] = vim.diagnostic.severity.WARN,
      }
      local defaults = { ["source"] = "gfortran" }
      local required_args = { "-fsyntax-only", "-fdiagnostics-plain-output" }
      local args = vim.list_extend(required_args, gfortran_diagnostic_args)

      lint.linters.gfortran = {
        cmd = "gfortran",
        stdin = false,
        append_fname = true,
        stream = "stderr",
        args = args,
        ignore_exitcode = true,
        parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
      }

      lint.linters_by_ft = {
        fortran = { "gfortran" },
      }
    end,
  },

  -- Debugging support with nvim-dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap").adapters.fort = {
        type = "executable",
        command = "gdb", -- or the path to your Fortran debugger
        args = {},
      }

      require("dap").configurations.fortran = {
        {
          name = "Debug Fortran",
          type = "fort",
          request = "launch",
          program = "${workspaceFolder}/path/to/your/executable", -- Path to your compiled Fortran program
          args = {},
          stopAtEntry = false,
        },
      }

      -- Key mappings for debugging
      vim.api.nvim_set_keymap(
        "n",
        "<leader>db",
        '<cmd>lua require"dap".toggle_breakpoint()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>dc",
        '<cmd>lua require"dap".continue()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>di",
        '<cmd>lua require"dap".step_into()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>do",
        '<cmd>lua require"dap".step_out()<CR>',
        { noremap = true, silent = true }
      )
    end,
  },

  -- Telescope setup for go to definition
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["gd"] = "<cmd>Telescope lsp_definitions<CR>", -- Map gd to go to definition
            },
          },
        },
      })
    end,
  },
}
--
-- return {
--   -- Mason for managing LSP servers
--   {
--     "williamboman/mason.nvim",
--     config = function()
--       require("mason").setup({})
--     end,
--   },
--
--   -- Mason LSP config to ensure fortls is installed
--   {
--     "williamboman/mason-lspconfig.nvim",
--     config = function()
--       require("mason-lspconfig").setup({
--         ensure_installed = { "fortls" },
--       })
--     end,
--   },
--
--   -- LSP configuration for Fortran
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       local lspconfig = require("lspconfig")
--       lspconfig.fortls.setup({})
--     end,
--   },
--
--   -- Linting support
--   {
--     "mfussenegger/nvim-lint",
--     config = function()
--       local lint = require("lint")
--       local gfortran_diagnostic_args = { "-Wall", "-Wextra", "-fmax-errors=5" }
--
--       local pattern = "^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$"
--       local groups = { "file", "lnum", "col", "severity", "message" }
--       local severity_map = {
--         ["Error"] = vim.diagnostic.severity.ERROR,
--         ["Warning"] = vim.diagnostic.severity.WARN,
--       }
--       local defaults = { ["source"] = "gfortran" }
--       local required_args = { "-fsyntax-only", "-fdiagnostics-plain-output" }
--       local args = vim.list_extend(required_args, gfortran_diagnostic_args)
--
--       lint.linters.gfortran = {
--         cmd = "gfortran",
--         stdin = false,
--         append_fname = true,
--         stream = "stderr",
--         args = args,
--         ignore_exitcode = true,
--         parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults),
--       }
--
--       lint.linters_by_ft = {
--         fortran = { "gfortran" },
--       }
--     end,
--   },
-- }
