return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "benfowler/telescope-luasnip.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = function()
    local builtin_ok, builtin = pcall(require, "telescope.builtin")
    if not builtin_ok then
      return
    end

    local themes_ok, themes = pcall(require, "telescope.themes")
    if not themes_ok then
      return
    end

    function CurrentDir()
      builtin.find_files({
        prompt_title = "🌞 " .. vim.fn.substitute(vim.fn.getcwd(), "/home/floslv", "~", ""),
        cwd = vim.fn.substitute(vim.fn.getcwd(), "/home/floslv", "~", ""),
        hidden = true,
      })
    end

    function Flo()
      builtin.find_files({
        cwd = "~/Flo",
        prompt_title = "🏠 ~/Flo",
        prompt_position = "top",
        hidden = true,
      })
    end

    function Dev()
      builtin.find_files({
        cwd = "~/Flo/Dev",
        prompt_title = "💻 Dev",
        hidden = true,
      })
    end

    function Dotfiles()
      if
        pcall(function()
          builtin.git_files(themes.get_dropdown({
            cwd = "~/Flo/Dotfiles",
            prompt_title = " Dotfiles",
            hidden = true,
            previewer = false,
          }))
        end)
      then
      else
        builtin.find_files(themes.get_dropdown({
          prompt_title = " Dotfiles",
          cwd = "~/Flo/Dotfiles",
          hidden = true,
          previewer = false,
        }))
      end
    end

    function Help()
      builtin.help_tags(themes.get_dropdown({
        prompt_title = "❓ Help",
        previewer = false,
      }))
    end

    function Keymaps()
      builtin.keymaps(themes.get_ivy({
        prompt_title = "👀 Key maps",
      }))
    end

    function FuzzilySearch()
      builtin.current_buffer_fuzzy_find(themes.get_dropdown({
        previewer = false,
        prompt_title = "[/] Fuzzily search in current buffer",
      }))
    end

    local wk = require("which-key")
    wk.register({
      f = {
        name = " ",
      },
    }, { prefix = "<leader>" })

    return {
      { "<leader>ff", ":lua CurrentDir()<CR>", desc = "Find files in current directory." },
      {
        "<leader>fg",
        ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Find live grep.",
      },
      { "<leader>fw", builtin.grep_string, desc = "Find word under cursor." },
      { "<leader>fb", ":Telescope buffers<CR>", desc = "Find buffers." },
      { "<leader>fh", ":lua Help()<CR>", desc = "Find in Help directory." },
      { "<leader>fk", ":lua Keymaps()<CR>", desc = "Find keymaps." },
      { "<leader>/", ":lua FuzzilySearch()<CR>", desc = "Fuzzily search in current buffer." },
      { "<leader>f~", ":lua Flo()<CR>", desc = "Find in Flo directory." },
      { "<leader>fv", ":lua Dev()<CR>", desc = "Find in Dev directory." },
      { "<leader>fd", ":lua Dotfiles()<CR>", desc = "Find in Dotfiles directory." },
    }
  end,
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local telescope_config = require("telescope.config")

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        layout_config = {
          prompt_position = "top",
          height = 0.50,
          width = 0.80,
          preview_cutoff = 0,
          horizontal = { preview_width = 0.50 },
          vertical = { width = 0.55, height = 0.9, preview_cutoff = 0 },
        },
        sorting_strategy = "ascending",
        prompt_prefix = "   ",
        hidden = true,
        mappings = {
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.delete_buffer,
          },
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
        vimgrep_arguments = vimgrep_arguments,
        path_display = { "truncate" },
      },
    })

    -- UI
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#CCCCCC" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#CCCCCC" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#CCCCCC" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#CCCCCC" })

    -- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#24283b" })
    -- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#24283b" })
    -- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#24283b" })

    -- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#011423" })
    -- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#011423" })
    -- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#011423" })

    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#ffffff" })
  end,
}
