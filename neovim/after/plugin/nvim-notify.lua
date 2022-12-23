local not_status, notify = pcall(require, 'notify')
if not not_status then
	return
end

vim.notify = notify
