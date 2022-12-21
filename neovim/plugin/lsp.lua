-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.

	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		-- add description
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	-- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	-- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	-- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	-- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	-- nmap('<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers. They will automatically be installed.
local servers = {
	cssls = {},
	graphql = {},
	html = {},
	jsonls = {},
	prismals = {},
	rust_analyzer = {},
	sumneko_lua = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = {
				-- Get the language server to recognize the `vim` global.
				globals = { 'vim' }
			},
			workspace = {
				checkThirdParty = false,
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true)
			},
			telemetry = { enable = false }
		}
	},
	taplo = {},
	tsserver = {},
	vimls = {}
}

-- Setup neovim lua configuration.
require'neodev'.setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.default_capabilities(capabilities)

-- Setup mason so it can manage external tooling.
require'mason'.setup({
	ui = {
		border = 'rounded',
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

-- Ensure the servers above are installed.
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers)
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require'lspconfig'[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name]
		}
	end
}

-- Turn on lsp status information.
require'fidget'.setup{}

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
