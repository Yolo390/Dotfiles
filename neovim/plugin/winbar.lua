-- Workaround to avoid error 'not enough room' with wilder.
require'winbar'.setup({
    enabled = true,

    exclude_filetype = { '' }
})
