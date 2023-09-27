local auto_status, nvim_autopairs = pcall(require, 'nvim-autopairs')
if not auto_status then
	return
end

nvim_autopairs.setup {}
