local rust_status, rust_tools = pcall(require, 'rust-tools')
if not rust_status then
	return
end

rust_tools.setup({})
