-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local key = vim.keymap.set

local full_options = { noremap = true, silent = true }
local noremap = { noremap = true }

-- TABS
key("n", "tt", ":tabnew<CR>", full_options)
key("n", "H", "gT", noremap)
key("n", "L", "gt", noremap)

-- MOVING TEXT
key("v", "J", ":move '>+1<CR>gv=gv", full_options)
key("v", "K", ":move '<-2<CR>gv=gv", full_options)
key("n", "<C-j>", ":move .+1<CR>==", full_options)
key("n", "<C-k>", ":move .-2<CR>==", full_options)

-- -- PLUGINS -- --

-- LSP
local ts_builtin_status, ts_builtin = pcall(require, "telescope.builtin")
if not ts_builtin_status then
  return
end

local nmap = function(keys, func, desc)
  -- add description
  if desc then
    desc = "LSP: " .. desc
  end

  vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<leader>df", ts_builtin.diagnostics, "[D]iagnostics [F]inder")

local wk = require("which-key")
wk.register({
  a = {
    name = "LSP", -- optional group name
    d = { vim.lsp.buf.definition, "Goto [D]efinition" },
    r = { ts_builtin.lsp_references, "Goto [R]eferences" },
    i = { vim.lsp.buf.implementation, "Goto [I]mplementation" },
    D = { vim.lsp.buf.declaration, "Goto [D]eclaration" },
    t = { vim.lsp.buf.type_definition, "Goto [T]ype definition" },
  },
}, { prefix = "<leader>" })
