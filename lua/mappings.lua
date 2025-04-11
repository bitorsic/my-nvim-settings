require "nvchad.mappings"

-- add yours here
local lsp_active = true

local function toggle_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if lsp_active then
    for _, client in pairs(clients) do
      client.stop()
    end
    lsp_active = false
    vim.notify("🔴 LSP stopped", vim.log.levels.INFO)
  else
    vim.cmd("edit") -- Reloads the current buffer, triggering LSP attachment
    lsp_active = true
    vim.notify("🟢 LSP restarted", vim.log.levels.INFO)
  end
end

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>lt", toggle_lsp, { desc = "Toggle LSP" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
