local nwd_status, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if not nwd_status then
	return
end

nvim_web_devicons.setup { default = true }
