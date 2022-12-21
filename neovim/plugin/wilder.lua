local wilder = require'wilder'

wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('pipeline', {
	wilder.branch(
		wilder.cmdline_pipeline({
			language = 'vim',
			fuzzy = 1,
			fuzzy_filter = wilder.vim_fuzzy_filter()
		})
	)
})

wilder.set_option('renderer', wilder.popupmenu_renderer(
	wilder.popupmenu_border_theme({
		highlighter = wilder.basic_highlighter(),
		min_width = '40%',
		max_height = '20%',
		reverse = 0,
		left = { ' ', wilder.popupmenu_devicons() },
		right = { ' ', wilder.popupmenu_scrollbar() }
	})
))
