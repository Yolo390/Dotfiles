local not_status, notify = pcall(require, "notify")
if not not_status then
	return
end

notify.setup({
	render = "default",
	timeout = 500,
	top_down = true,
	stages = "slide",
})

vim.notify = notify
