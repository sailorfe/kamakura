local colors = {
	base = "{{base}}",
	surface = "{{surface}}",
	overlay = "{{overlay}}",
	muted = "{{muted}}",
	faint = "{{faint}}",
	text = "{{text}}",
	light = "{{light}}",
	accent01 = "{{accent01}}",
	accent02 = "{{accent02}}",
	accent03 = "{{accent03}}",
	accent04 = "{{accent04}}",
	accent05 = "{{accent05}}",
	accent06 = "{{accent06}}",
	bright01 = "{{bright01}}",
	bright02 = "{{bright02}}",
	bright03 = "{{bright03}}",
	bright04 = "{{bright04}}",
	bright05 = "{{bright05}}",
	bright06 = "{{bright06}}",
	low = "{{low}}",
	med = "{{med}}",
	high = "{{high}}",
}

local highlights = {
	-- ui
	Normal = { bg = colors.base, fg = colors.text },
	NormalFloat = { bg = colors.surface, fg = colors.text },
	NormalNC = { bg = colors.base, fg = colors.faint },

	FloatBorder = { bg = colors.surface, fg = colors.muted },
	FloatTitle = { bg = colors.surface, fg = colors.accent06, bold = true },
	FloatFooter = { link = "FloatBorder" },

	ColorColumn = { bg = colors.surface },
	Conceal = { fg = colors.muted },
	CursorLine = { bg = colors.overlay },
	CursorColumn = { bg = colors.overlay },
	CursorLineNr = { fg = colors.text, bold = true },
	LineNr = { fg = colors.muted },
	LineNrAbove = { link = "LineNr" },
	LineNrBelow = { link = "LineNr" },

	SignColumn = { bg = colors.base },
	FoldColumn = { fg = colors.high, bg = colors.surface },
	Folded = { bg = colors.low, fg = colors.faint },

	StatusLine = { bg = colors.overlay, fg = colors.text },
	StatusLineNC = { bg = colors.surface, fg = colors.muted },
	WinBar = { bg = colors.med, fg = colors.faint },
	WinBarNC = { bg = colors.med, fg = colors.muted },
	WinSeparator = { fg = colors.surface }, -- 0.9+
	VertSplit = { fg = colors.surface }, -- for compatibility

	TabLine = { bg = colors.surface, fg = colors.muted },
	TabLineFill = { bg = colors.base },
	TabLineSel = { bg = colors.overlay, fg = colors.accent06, bold = true },

	Pmenu = { bg = colors.surface, fg = colors.text },
	PmenuSel = { bg = colors.overlay, fg = colors.accent06, bold = true },
	PmenuKind = { bg = colors.surface, fg = colors.accent05 },
	PmenuKindSel = { bg = colors.overlay, fg = colors.accent05, bold = true },
	PmenuExtra = { bg = colors.surface, fg = colors.muted },
	PmenuExtraSel = { bg = colors.overlay, fg = colors.faint },
	PmenuSbar = { bg = colors.overlay },
	PmenuThumb = { bg = colors.high },
	PmenuMatch = { fg = colors.accent06, bold = true }, -- 0.11 fuzzy match
	PmenuMatchSel = { fg = colors.accent06, bold = true, underline = true },

	MsgArea = { fg = colors.text },
	MsgSeparator = { fg = colors.overlay },
	ModeMsg = { fg = colors.text, bold = true },
	MoreMsg = { fg = colors.accent02 },
	Question = { fg = colors.accent04 },
	WarningMsg = { fg = colors.accent03 },
	ErrorMsg = { fg = colors.accent01, bold = true },

	Cursor = { bg = colors.text, fg = colors.base },
	lCursor = { link = "Cursor" },
	CursorIM = { link = "Cursor" },
	TermCursor = { bg = colors.accent06, fg = colors.base },
	TermCursorNC = { bg = colors.faint, fg = colors.base },

	Visual = { bg = colors.accent06, fg = colors.base },
	VisualNOS = { link = "Visual" },
	CurSearch = { bg = colors.accent03, fg = colors.base },
	IncSearch = { link = "CurSearch" },
	Search = { bg = colors.med, fg = colors.accent03 },
	Substitute = { bg = colors.accent04, fg = colors.base },

	MatchParen = { bg = colors.high, bold = true },

	NonText = { fg = colors.muted },
	Whitespace = { fg = colors.overlay },
	SpecialKey = { fg = colors.muted },
	EndOfBuffer = { fg = colors.muted },

	Directory = { fg = colors.accent04 },
	Title = { fg = colors.accent06, bold = true },
	WildMenu = { bg = colors.text, fg = colors.base },

	QuickFixLine = { bg = colors.overlay, bold = true },

	-- diffs
	DiffAdd = { bg = colors.accent02, fg = colors.base },
	DiffChange = { bg = colors.accent06, fg = colors.base },
	DiffDelete = { fg = colors.accent01, bold = true },
	DiffText = { bg = colors.accent04, fg = colors.base },

	-- spell
	SpellBad = { fg = colors.accent01, undercurl = true },
	SpellCap = { fg = colors.accent03, undercurl = true },
	SpellLocal = { fg = colors.accent02, undercurl = true },
	SpellRare = { fg = colors.accent04, undercurl = true },

	-- misc
	Underlined = { underline = true },
	Ignore = { fg = colors.muted },
	Error = { bg = colors.accent01, fg = colors.light },
	Todo = { fg = colors.accent03, bold = true },

	-- traditional syntax
	Comment = { fg = colors.faint, italic = true },

	Constant = { fg = colors.accent03 },
	String = { fg = colors.accent02 },
	Character = { link = "Constant" },
	Number = { link = "Constant" },
	Boolean = { link = "Constant" },
	Float = { link = "Constant" },

	Identifier = { fg = colors.accent05 },
	Function = { fg = colors.accent06 },

	Statement = { fg = colors.accent04, bold = true },
	Conditional = { link = "Statement" },
	Repeat = { link = "Statement" },
	Label = { link = "Statement" },
	Operator = { fg = colors.text },
	Keyword = { link = "Statement" }, -- maybe change
	Exception = { link = "Statement" },

	PreProc = { fg = colors.accent04 },
	Include = { link = "PreProc" },
	Define = { link = "PreProc" },
	Macro = { link = "PreProc" },
	PreCondit = { link = "PreProc" },

	Type = { fg = colors.accent02 },
	StorageClass = { link = "Type" },
	Structure = { link = "Type" },
	Typedef = { fg = colors.accent02, italic = true },

	Special = { fg = colors.accent05 },
	SpecialChar = { link = "Special" },
	Tag = { link = "Special" },
	Delimiter = { fg = colors.text },
	SpecialComment = { fg = colors.faint, bold = true },
	Debug = { link = "Special" },

	-- diagonistics
	DiagnosticError = { fg = colors.accent01 },
	DiagnosticWarn = { fg = colors.accent03 },
	DiagnosticInfo = { fg = colors.accent04 },
	DiagnosticHint = { fg = colors.accent06 },
	DiagnosticOk = { fg = colors.accent02 },

	DiagnosticVirtualTextError = { fg = colors.accent01, italic = true },
	DiagnosticVirtualTextWarn = { fg = colors.accent03, italic = true },
	DiagnosticVirtualTextInfo = { fg = colors.accent04, italic = true },
	DiagnosticVirtualTextHint = { fg = colors.accent06, italic = true },
	DiagnosticVirtualTextOk = { fg = colors.accent02, italic = true },

	DiagnosticUnderlineError = { fg = colors.accent01, undercurl = true },
	DiagnosticUnderlineWarn = { fg = colors.accent03, undercurl = true },
	DiagnosticUnderlineInfo = { fg = colors.accent04, undercurl = true },
	DiagnosticUnderlineHint = { fg = colors.accent06, undercurl = true },
	DiagnosticUnderlineOk = { fg = colors.accent02, undercurl = true },

	DiagnosticFloatingError = { link = "DiagnosticError" },
	DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
	DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
	DiagnosticFloatingHint = { link = "DiagnosticHint" },
	DiagnosticFloatingOk = { link = "DiagnosticOk" },

	DiagnosticSignError = { link = "DiagnosticError" },
	DiagnosticSignWarn = { link = "DiagnosticWarn" },
	DiagnosticSignInfo = { link = "DiagnosticInfo" },
	DiagnosticSignHint = { link = "DiagnosticHint" },
	DiagnosticSignOk = { link = "DiagnosticOk" },
	DiagnosticDeprecated = { strikethrough = true, fg = colors.muted },

	-- treesitter

	-- identifiers
	["@variable"] = { fg = colors.text, italic = true },
	["@variable.builtin"] = { fg = colors.accent06, bold = true, italic = true },
	["@variable.parameter"] = { link = "Type" }, -- (injected_functions)
	["@variable.member"] = { fg = colors.text }, -- struct fields, object keys

	["@constant"] = { link = "Constant" },
	["@constant.builtin"] = { fg = colors.accent02, bold = true, italic = true },
	["@constant.macro"] = { link = "Define" },

	["@module"] = { fg = colors.accent03 },
	["@module.builtin"] = { fg = colors.accent03, bold = true, italic = true },
	["@label"] = { fg = colors.accent04 },

	-- literals
	["@string"] = { link = "String" },
	["@string.escape"] = { fg = colors.accent06 },
	["@string.special"] = { fg = colors.accent06 },
	["@string.regexp"] = { fg = colors.accent03 },
	["@string.special.url"] = { fg = colors.accent04, underline = true },

	["@character"] = { link = "Character" },
	["@character.special"] = { link = "SpecialChar" },
	["@boolean"] = { link = "Boolean" },
	["@number"] = { link = "Number" },
	["@number.float"] = { link = "Float" },

	-- types
	["@type"] = { link = "Type" },
	["@type.builtin"] = { fg = colors.accent02, bold = true, italic = true },
	["@type.definition"] = { link = "Typedef" },

	-- functions
	["@function"] = { link = "Function" },
	["@function.builtin"] = { fg = colors.accent05, bold = true, italic = true },
	["@function.macro"] = { link = "Macro" },
	["@function.method"] = { link = "Function" },
	["@constructor"] = { fg = colors.accent06 },

	-- keywords
	["@keyword"] = { link = "Keyword" },
	["@keyword.function"] = { fg = colors.accent04, italic = true },
	["@keyword.operator"] = { fg = colors.accent04 },
	["@keyword.import"] = { link = "Include" },
	["@keyword.repeat"] = { link = "Repeat" },
	["@keyword.return"] = { fg = colors.accent01, italic = true },
	["@keyword.exception"] = { link = "Exception" },
	["@keyword.conditional"] = { link = "Conditional" },
	["@keyword.directive"] = { link = "PreProc" },

	-- punctuation
	["@punctuation.delimiter"] = { fg = colors.muted },
	["@punctuation.bracket"] = { fg = colors.text },
	["@punctuation.special"] = { fg = colors.accent06 },

	-- comments
	["@comment"] = { link = "Comment" },
	["@comment.documentation"] = { fg = colors.faint, italic = true },
	["@comment.error"] = { fg = colors.accent01, bold = true },
	["@comment.warning"] = { fg = colors.accent03, bold = true },
	["@comment.todo"] = { fg = colors.accent03, bold = true },
	["@comment.note"] = { fg = colors.accent04, bold = true },

	-- markup (markdown, rst, etc.)
	["@markup.raw"] = { fg = colors.accent02 },
	["@markup.raw.block"] = { fg = colors.accent02 },
	["@markup.link"] = { fg = colors.accent04, underline = true },
	["@markup.link.url"] = { fg = colors.accent04, underline = true, italic = true },
	["@markup.link.label"] = { fg = colors.accent06 },
	["@markup.list"] = { fg = colors.accent03 },
	["@markup.heading"] = { fg = colors.accent06, bold = true },
	["@markup.heading.1"] = { fg = colors.accent06, bold = true },
	["@markup.heading.2"] = { fg = colors.accent03, bold = true },
	["@markup.heading.3"] = { fg = colors.accent02, bold = true },
	["@markup.heading.4"] = { fg = colors.accent05, bold = true },
	["@markup.heading.5"] = { fg = colors.accent04, bold = true },
	["@markup.heading.6"] = { fg = colors.accent01, bold = true },
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true, fg = colors.muted },
	["@markup.quote"] = { fg = colors.faint, italic = true },

	-- misc TS
	["@operator"] = { link = "Operator" },
	["@attribute"] = { fg = colors.accent03 },
	["@attribute.builtin"] = { fg = colors.accent03, bold = true, italic = true },
	["@property"] = { fg = colors.accent06, italic = true }, -- would love to change this
	["@tag"] = { fg = colors.accent04 },
	["@tag.builtin"] = { fg = colors.accent04, bold = true, italic = true },
	["@tag.attribute"] = { fg = colors.accent03 },
	["@tag.delimiter"] = { fg = colors.muted },

	["@diff.plus"] = { fg = colors.accent02 },
	["@diff.minus"] = { fg = colors.accent01 },
	["@diff.delta"] = { fg = colors.accent04 },

	-- LSP semantic tokens (0.9+)
	["@lsp.type.class"] = { link = "Type" },
	["@lsp.type.decorator"] = { fg = colors.accent03 },
	["@lsp.type.enum"] = { link = "Type" },
	["@lsp.type.enumMember"] = { link = "Constant" },
	["@lsp.type.function"] = { link = "Function" },
	["@lsp.type.interface"] = { link = "Typedef" },
	["@lsp.type.macro"] = { link = "Macro" },
	["@lsp.type.method"] = { link = "Function" },
	["@lsp.type.namespace"] = { fg = colors.text, italic = true },
	["@lsp.type.parameter"] = { fg = colors.accent05, italic = true },
	["@lsp.type.property"] = { fg = colors.text },
	["@lsp.type.struct"] = { link = "Structure" },
	["@lsp.type.type"] = { link = "Type" },
	["@lsp.type.typeParameter"] = { link = "Typedef" },
	["@lsp.type.variable"] = { fg = colors.text },
	["@lsp.type.keyword"] = { link = "Keyword" },
	["@lsp.type.comment"] = { link = "Comment" },
	["@lsp.type.string"] = { link = "String" },
	["@lsp.type.number"] = { link = "Number" },
	["@lsp.type.operator"] = { link = "Operator" },

	["@lsp.mod.deprecated"] = { strikethrough = true, fg = colors.muted },
	["@lsp.mod.readonly"] = { italic = true },
	["@lsp.mod.defaultLibrary"] = { italic = true },

	-- markdown
	markdownH1 = { fg = colors.accent06, bold = true },
	markdownH2 = { fg = colors.accent03, bold = true },
	markdownH3 = { fg = colors.accent02, bold = true },
	markdownH4 = { fg = colors.accent05, bold = true },
	markdownH5 = { fg = colors.accent04, bold = true },
	markdownH6 = { fg = colors.accent01, bold = true },
	markdownH1Delimiter = { link = "markdownH1" },
	markdownH2Delimiter = { link = "markdownH2" },
	markdownH3Delimiter = { link = "markdownH3" },
	markdownH4Delimiter = { link = "markdownH4" },
	markdownH5Delimiter = { link = "markdownH5" },
	markdownH6Delimiter = { link = "markdownH6" },

	-- plugins
	GitSignsAdd = { link = "@diff.plus" },
	GitSignsChange = { link = "@diff.delta" },
	GitSignsDelete = { link = "@diff.minus" },

	RenderMarkdownH1Bg = { link = "@markup.heading.1" },
	RenderMarkdownH2Bg = { link = "@markup.heading.2" },
	RenderMarkdownH3Bg = { link = "@markup.heading.3" },
	RenderMarkdownH4Bg = { link = "@markup.heading.4" },
	RenderMarkdownH5Bg = { link = "@markup.heading.5" },
	RenderMarkdownH6Bg = { link = "@markup.heading.6" },

	MiniDiffSignAdd = { fg = colors.accent02, italic = true },
	MiniDiffSignChange = { fg = colors.accent04, italic = true },
	MiniDiffSignDelete = { fg = colors.accent01, italic = true },
	MiniStatuslineModeNormal = { bg = colors.high, fg = colors.text, bold = true },
	MiniStatuslineModeInsert = { bg = colors.text, fg = colors.base, bold = true },
	MiniStatuslineModeVisual = { bg = colors.accent06, fg = colors.base, bold = true },
	MiniStatuslineModeReplace = { bg = colors.accent01, fg = colors.base, bold = true },
	MiniStatuslineModeCommand = { bg = colors.accent04, fg = colors.base, bold = true },
	MiniStatuslineModeOther = { bg = colors.accent02, fg = colors.base, bold = true },
	MiniStatuslineDevinfo = { bg = colors.overlay, fg = colors.text },
	MiniStatuslineFilename = { bg = colors.surface, fg = colors.faint },
	MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
	MiniStatuslineInactive = { bg = colors.base, fg = colors.muted },
	MiniTablineCurrent = { link = "TabLineSel" },
	MiniTablineVisible = { fg = colors.accent03, bg = colors.surface },
	MiniTablineHidden = { link = "TabLine" },

	TroubleIndent = { bg = colors.surface, fg = colors.faint },
	TroublePos = { bg = colors.surface, fg = colors.faint },

	IblIndent = { fg = colors.med },
	IblScope = { link = "Function" },
	IblWhitespace = { link = "Whitespace" },
}

local U = {}

U.setup = function(opts)
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "accent04"

	for group, opts_tbl in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts_tbl)
	end
end

return U
