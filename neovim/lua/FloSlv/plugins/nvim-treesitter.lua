return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Last release is way too old and doesn't work on Windows.
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    cmd = { "TSUpdateSync" },
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "css",
          "dockerfile",
          "gitignore",
          "graphql",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "php",
          "prisma",
          "python",
          "query",
          "rasi",
          "regex",
          "sql",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        -- Auto install above language parsers.
        -- auto_install = true,
        -- Enable autotagging (w/ nvim-ts-autotag plugin).
        autotag = { enable = true },
        -- Enable nvim-ts-context-commentstring plugin for commenting tsx and jsx.
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}
