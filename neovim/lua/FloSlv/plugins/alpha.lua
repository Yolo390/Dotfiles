return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    local logo = [[

  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

                    [@flo-slv]                      
    ]]

    local builtin_ok, builtin = pcall(require, "telescope.builtin")
    if not builtin_ok then
      return
    end

    local themes_ok, themes = pcall(require, "telescope.themes")
    if not themes_ok then
      return
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

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button(
        "f",
        " " .. " Find file",
        "<CMD>Telescope find_files<CR>"
      ),
      dashboard.button(
        "r",
        " " .. " Recent files",
        "<CMD>Telescope oldfiles<CR>"
      ),
      dashboard.button("d", " " .. " Dotfiles", "<CMD>lua Dotfiles()<CR>"),
      dashboard.button("l", "󰒲 " .. " Lazy", "<CMD>Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", "<CMD>qa<CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8

    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
