local bqf_ok, bqf = pcall(require, "bqf")
if not bqf_ok then
	return
end

bqf.setup({
	auto_enable = true,
	preview = {
		auto_preview = true,
	},
	auto_resize_height = true,
})
