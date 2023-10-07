-- ###########
-- # KEYMAPS #
-- ###########

local keymap = vim.keymap.set

local full_options = { noremap = true, silent = true }
local noremap = { noremap = true }

local nmap = function(key, command, option, desc)
  if option == "full_options" then
    keymap("n", key, command, { desc = desc, noremap = true, silent = true })
  else
    keymap("n", key, command, { desc = desc, noremap = true })
  end
end

-- SAVE AND RE SOURCE CURRENT FILE.
nmap(
  "<leader>s",
  ":w | source %<CR>",
  "full_options",
  "Save and re source current file."
)

-- WINDOWS
nmap("<leader>v", ":vsplit<CR>", "full_options", "Windows: split vertically.")
nmap("<leader>x", ":split<CR>", "full_options", "Windows: split horizontally.")

-- TABS.
keymap("n", "tt", ":tabnew<CR>", full_options)
keymap("n", "H", "gT", noremap)
keymap("n", "L", "gt", noremap)

-- MOVING TEXT.
keymap("v", "J", ":move '>+1<CR>gv=gv", full_options)
keymap("v", "K", ":move '<-2<CR>gv=gv", full_options)
keymap("n", "<C-j>", ":move .+1<CR>==", full_options)
keymap("n", "<C-k>", ":move .-2<CR>==", full_options)

-- REPLACE WORD UNDER CURSOR ACROSS ENTIRE BUFFER.
keymap(
  "n",
  "<C-w>",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  full_options
)

-- COPY FROM CURSOR TO END OF LINE.
keymap("n", "Y", "y$", noremap)

-- KEEPING IN CENTERED
keymap("n", "n", "nzzzv", full_options)
keymap("n", "N", "Nzzzv", full_options)
keymap("n", "G", "Gzz", full_options)

-- UNDO BREAK POINTS
keymap("i", ",", ",<C-g>u", {})
keymap("i", ";", ";<C-g>u", {})
keymap("i", ".", ".<C-g>u", {})
keymap("i", "!", "!<C-g>u", {})
keymap("i", "?", "?<C-g>u", {})

-- VISUAL MODE INDENTATION
keymap("v", "<", "<gv", full_options)
keymap("v", ">", ">gv", full_options)

-- RESIZE WITH ARROWS
keymap("n", "<C-Up>", ":resize +2<CR>", full_options)
keymap("n", "<C-Down>", ":resize -2<CR>", full_options)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", full_options)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", full_options)
