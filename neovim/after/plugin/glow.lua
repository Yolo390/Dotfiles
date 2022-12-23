local glow_status, glow = pcall(require, 'glow')
if not glow_status then
	return
end

glow.setup({
	border = 'rounded'
})
