return {
  "tpope/vim-fugitive",
  config = function()
    local map = function(key, cmd, opts)
      opts = opts or {}
      opts.noremap = true
      opts.silent = true

      vim.keymap.set("n", key, cmd, opts)
    end

    map("<leader>go", ":vertical Git<CR>", { desc = "Fugitive: git open" })
    map("<leader>gs", ":Git status<CR>", { desc = "Fugitive: git status" })
    map("<leader>gp", ":Git push<CR>", { desc = "Fugitive: git push" })
  end,
}
