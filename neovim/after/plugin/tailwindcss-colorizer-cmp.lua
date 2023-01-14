local tail_col_cmp_ok, tailwindcss_colorizer_cmp = pcall(require, "tailwindcss-colorizer-cmp")
if not tail_col_cmp_ok then
	return
end

tailwindcss_colorizer_cmp.setup({
	color_square_width = 2,
})
