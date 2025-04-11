return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "stevearc/resession.nvim",
    event = "VimEnter",
    config = function()
      local resession = require("resession")

      resession.setup({
        autosave = {
          enabled = false,
        },
      })


      -- only load if we're opening nvim without arguments
      if vim.fn.argc() == 0 then
        vim.schedule(function()
          resession.load("last")
        end)
      end

      -- save the current session with the name "last" so it opens when you start nvim again
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          resession.save("last")
        end
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>sr", function()
        resession.save(vim.fn.input("Session name: "))
      end, { desc = "Save Session" })

      vim.keymap.set("n", "<leader>sl", function()
        resession.load(vim.fn.input("Session name: "))
      end, { desc = "Load Session" })

      vim.keymap.set("n", "<leader>sf", function()
        resession.load()
      end, { desc = "Load Session (from list)" })
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
