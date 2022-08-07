require'nvim-lsp-installer'.setup {
	ui = {
		border = 'rounded',
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
}

require'lspconfig'.tsserver.setup {}
require'lspconfig'.graphql.setup {}
require'lspconfig'.cssls.setup {}
require'lspconfig'.html.setup {}
require'lspconfig'.jsonls.setup {}
require'lspconfig'.rust_analyzer.setup {}
require'lspconfig'.taplo.setup {}
require'lspconfig'.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' }
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true)
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false }
		}
	}
}


-- UI
local lsp = vim.lsp

lsp.handlers['textDocument/hover'] = lsp.with(vim.lsp.handlers.hover, {
	border = 'rounded'
})
lsp.handlers['textDocument/signatureHelp'] = lsp.with(vim.lsp.handlers.hover, {
	border = 'rounded'
})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focusable = false,
		source = 'always',
		header = '',
		prefix = ''
	}
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- Override default vim.diagnostic.open_float() function
-- to change border and background color to adapt colors from Diagnostic event.
vim.diagnostic.open_float = (function(orig)
	return function(bufnr, opts)
		local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
		local options = opts or {}

		-- A more robust solution would check the "scope" value in `opts` to
		-- determine where to get diagnostics from, but if you're only using
		-- this for your own purposes you can make it as simple as you like
	local diagnostics = vim.diagnostic.get(options.bufnr or 0, { lnum = lnum })
		local max_severity = vim.diagnostic.severity.HINT

		for _, d in ipairs(diagnostics) do
			-- Equality is "less than" based on how the severities are encoded
			if d.severity < max_severity then
				max_severity = d.severity
			end
		end

		local border_color = ({
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.ERROR] = "DiagnosticError"
		})[max_severity]

		options.border = {
			{ '╭', border_color },
			{ '─', border_color },
			{ '╮', border_color },
			{ '│', border_color },
			{ '╯', border_color },
			{ '─', border_color },
			{ '╰', border_color },
			{ '│', border_color }
		}

		-- Change background color
		vim.cmd [[ highlight DiagnosticBGColor guibg=#24283b]]
		vim.api.nvim_win_set_option(0, 'winhl', 'Normal:DiagnosticBGColor')

		-- Return new params
		orig(bufnr, options)
	end
end)(vim.diagnostic.open_float)
