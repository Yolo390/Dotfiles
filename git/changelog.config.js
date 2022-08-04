// For git-cz
module.exports = {
	disableEmoji: false,
	format: '{emoji}{type}{scope}: {subject}',
	list: ['test', 'feat', 'fix', 'docs', 'refactor', 'style', 'ci'],
	maxMessageLength: 64,
	minMessageLength: 3,
	questions: ['type', 'scope', 'subject', 'body', 'issues', 'lerna'],
	scopes: [],
	enableWritingScopes: true, // Feature not yet push...
	types: {
		ci: {
			description: 'Continuous Integration related changes',
			emoji: '⬜️',
			value: 'ci'
		},
		docs: {
			description: 'Documentation only changes',
			emoji: '🟧',
			value: 'docs'
		},
		feat: {
			description: 'A new feature',
			emoji: '🟦',
			value: 'feat'
		},
		fix: {
			description: 'A bug fix',
			emoji: '🟥',
			value: 'fix'
		},
		refactor: {
			description: 'A code change that neither fixes a bug or adds a feature',
			emoji: '🟪',
			value: 'refactor'
		},
		style: {
			description: 'Markup, white-space, formatting, missing semi-colons...',
			emoji: '🟨',
			value: 'style'
		},
		test: {
			description: 'Adding tests',
			emoji: '🟩',
			value: 'test'
		},
		messages: {
			type: 'Select the type of change that you\'re committing:',
			customScope: 'Select the scope this component affects:',
			subject: 'Write a short, imperative mood description of the change:\n',
			body: 'Provide a longer description of the change:\n ',
			footer: 'Issues this commit closes, e.g #123:',
			confirmCommit: 'The packages that this commit has affected\n'
		}
	}
};
