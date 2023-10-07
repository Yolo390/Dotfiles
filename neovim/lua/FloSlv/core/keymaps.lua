-- ###########
-- # KEYMAPS #
-- ###########

local utils = require("FloSlv.core.utils")

local full_options = { noremap = true, silent = true }
local noremap = { noremap = true }

-- SAVE AND RE SOURCE CURRENT FILE.
utils.map(
  "n",
  "<leader>s",
  ":w | source %<CR>",
  "Save and re source current file.",
  full_options
)

-- WINDOWS
utils.map(
  "n",
  "<leader>v",
  ":vsplit<CR>",
  "Windows: split vertically.",
  full_options
)
utils.map(
  "n",
  "<leader>x",
  ":split<CR>",
  "Windows: split horizontally.",
  full_options
)

-- TABS.
utils.map("n", "tt", ":tabnew<CR>", "Tab: new", full_options)
utils.map("n", "H", "gT", "Tab: got to previous.", noremap)
utils.map("n", "L", "gt", "Tab: got to next.", noremap)

-- MOVING TEXT.
utils.map(
  "v",
  "J",
  ":move '>+1<CR>gv=gv",
  "Moving txt: one line down.",
  full_options
)
utils.map(
  "v",
  "K",
  ":move '<-2<CR>gv=gv",
  "Moving txt: one line up.",
  full_options
)
utils.map(
  "n",
  "<C-j>",
  ":move .+1<CR>==",
  "Moving text: block down. ",
  full_options
)
utils.map(
  "n",
  "<C-k>",
  ":move .-2<CR>==",
  "Moving text: block up.",
  full_options
)

-- REPLACE WORD UNDER CURSOR ACROSS ENTIRE BUFFER.
utils.map(
  "n",
  "<C-w>",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  "Replace word under cursor across entire buffer.",
  full_options
)

-- COPY FROM CURSOR TO END OF LINE.
utils.map("n", "Y", "y$", "Copy from cursor to end of line", noremap)

-- KEEPING IN CENTERED
utils.map("n", "n", "nzzzv", "Keeping in centered: n", full_options)
utils.map("n", "N", "Nzzzv", "Keeping in centered: N", full_options)
utils.map("n", "G", "Gzz", "Keeping in centered: G", full_options)

-- UNDO BREAK POINTS
utils.map("i", ",", ",<C-g>u", "Undo break points: ','", {})
utils.map("i", ";", ";<C-g>u", "Undo break points: ';'", {})
utils.map("i", ".", ".<C-g>u", "Undo break points: '.'", {})
utils.map("i", "!", "!<C-g>u", "Undo break points: '!'", {})
utils.map("i", "?", "?<C-g>u", "Undo break points: '?'", {})

-- VISUAL MODE INDENTATION
utils.map("v", "<", "<gv", "Indentation: '<", full_options)
utils.map("v", ">", ">gv", "Indentation: '>", full_options)

-- RESIZE WINDOWS WITH ARROWS
utils.map("n", "<C-Up>", ":resize +2<CR>", "Resize windows: up", full_options)
utils.map(
  "n",
  "<C-Down>",
  ":resize -2<CR>",
  "Resize windows: down",
  full_options
)
utils.map(
  "n",
  "<C-Left>",
  ":vertical resize -2<CR>",
  "Resize windows: left",
  full_options
)
utils.map(
  "n",
  "<C-Right>",
  ":vertical resize +2<CR>",
  "Resize windows: right",
  full_options
)
