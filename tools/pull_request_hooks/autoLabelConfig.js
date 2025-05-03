
// File Labels
//
// Add a label based on if a file is modified in the diff
//
// You can optionally set add_only to make the label one-way -
// if the edit to the file is removed in a later commit,
// the label will not be removed
export const file_labels = {
	'GitHub': {
		filepaths: ['.github'],
	},
	'SQL': {
		filepaths: ['SQL'],
	},
	'Mapping': {
		filepaths: ['_maps'],
	},
	'Tools': {
		filepaths: ['tools'],
	},
	'Config Update': {
		filepaths: ['config', 'code/controllers/configuration/entries'],
	},
	'Sprites': {
		filepaths: ['icons'],
	},
	'Sound': {
		filepaths: ['sound'],
	},
	'UI': {
		filepaths: ['tgui'],
	}
}

// Title Labels
//
// Add a label based on keywords in the title
export const title_labels = {
	'Logging' : {
		keywords: ['log', 'logging'],
	},
	'Removal' : {
		keywords: ['remove', 'delete'],
	},
	'Refactor' : {
		keywords: ['refactor'],
	},
	'Unit Tests' : {
		keywords: ['unit test'],
	},
	'April Fools' : {
		keywords: ['[april fools]'],
		add_only: true,
	},
	'Do Not Merge' : {
		keywords: ['[dnm]', '[do not merge]'],
		add_only: true,
	},
	'Test Merge Only' : {
		keywords: ['[tm only]', '[test merge only]'],
		add_only: true,
	},
	'Port': {
		keywords: ['port'],
		add_only: true,
	},
}

// Changelog Labels
//
// Adds labels based on keywords in the changelog
// TODO use the existing changelog parser
export const changelog_labels = {
	'Fix': {
		default_text: 'fixed a few things',
		keywords: ['fix', 'fixes', 'bugfix'],
	},
	'QoL': {
		default_text: 'made something easier to use',
		keywords: ['qol'],
	},
	'Sound': {
		default_text: 'added/modified/removed audio or sound effects',
		keywords: ['sound'],
	},
	'Feature': {
		default_text: 'Added new mechanics or gameplay changes',
		alt_default_text: 'Added more things',
		keywords: ['add', 'adds', 'rscadd'],
	},
	'Removal': {
		default_text: 'Removed old things',
		keywords: ['del', 'dels', 'rscdel'],
	},
	'Sprites': {
		default_text: 'added/modified/removed some icons or images',
		keywords: ['image'],
	},
	'Grammar and Formatting': {
		default_text: 'fixed a few typos',
		keywords: ['typo', 'spellcheck'],
	},
	'Mapping': {
		default_text: 'added/modified/removed map content',
		keywords: ['map', 'mapping'],
	},
	'Balance': {
		default_text: 'rebalanced something',
		keywords: ['balance'],
	},
	'Code Improvement': {
		default_text: 'changed some code',
		keywords: ['code_imp', 'code'],
	},
	'Refactor': {
		default_text: 'refactored some code',
		keywords: ['refactor'],
	},
	'Config Update': {
		default_text: 'changed some config setting',
		keywords: ['config'],
	},
	'Administration': {
		default_text: 'messed with admin stuff',
		keywords: ['admin'],
	},
	'Server': {
		default_text: 'something server ops should know',
		keywords: ['server'],
	},
}
