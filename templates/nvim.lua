local colors = {
	base = "{{base}}",
	surface = "{{surface}}",
	overlay = "{{overlay}}",
	muted = "{{muted}}",
	faint = "{{faint}}",
	text = "{{text}}",
	light = "{{light}}",
	miko = "{{miko}}",
	yorishige = "{{yorishige}}",
	mima = "{{mima}}",
	tokiyuki = "{{tokiyuki}}",
	ayako = "{{ayako}}",
	shizuku = "{{shizuku}}",
	taisha = "{{taisha}}",
	suwa = "{{suwa}}",
	sasaki = "{{sasaki}}",
	hojo = "{{hojo}}",
	mochizuki = "{{mochizuki}}",
	kami = "{{kami}}",
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
	FloatTitle = { bg = colors.surface, fg = colors.shizuku, bold = true },
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
	TabLineSel = { bg = colors.overlay, fg = colors.shizuku, bold = true },

	Pmenu = { bg = colors.surface, fg = colors.text },
	PmenuSel = { bg = colors.overlay, fg = colors.shizuku, bold = true },
	PmenuKind = { bg = colors.surface, fg = colors.ayako },
	PmenuKindSel = { bg = colors.overlay, fg = colors.ayako, bold = true },
	PmenuExtra = { bg = colors.surface, fg = colors.muted },
	PmenuExtraSel = { bg = colors.overlay, fg = colors.faint },
	PmenuSbar = { bg = colors.overlay },
	PmenuThumb = { bg = colors.high },
	PmenuMatch = { fg = colors.shizuku, bold = true }, -- 0.11 fuzzy match
	PmenuMatchSel = { fg = colors.shizuku, bold = true, underline = true },

	MsgArea = { fg = colors.text },
	MsgSeparator = { fg = colors.overlay },
	ModeMsg = { fg = colors.text, bold = true },
	MoreMsg = { fg = colors.yorishige },
	Question = { fg = colors.tokiyuki },
	WarningMsg = { fg = colors.mima },
	ErrorMsg = { fg = colors.miko, bold = true },

	Cursor = { bg = colors.text, fg = colors.base },
	lCursor = { link = "Cursor" },
	CursorIM = { link = "Cursor" },
	TermCursor = { bg = colors.shizuku, fg = colors.base },
	TermCursorNC = { bg = colors.faint, fg = colors.base },

	Visual = { bg = colors.shizuku, fg = colors.base },
	VisualNOS = { link = "Visual" },
	CurSearch = { bg = colors.mima, fg = colors.base },
	IncSearch = { link = "CurSearch" },
	Search = { bg = colors.med, fg = colors.mima },
	Substitute = { bg = colors.tokiyuki, fg = colors.base },

	MatchParen = { bg = colors.high, bold = true },

	NonText = { fg = colors.muted },
	Whitespace = { fg = colors.overlay },
	SpecialKey = { fg = colors.muted },
	EndOfBuffer = { fg = colors.muted },

	Directory = { fg = colors.tokiyuki },
	Title = { fg = colors.shizuku, bold = true },
	WildMenu = { bg = colors.text, fg = colors.base },

	QuickFixLine = { bg = colors.overlay, bold = true },

	-- diffs
	DiffAdd = { bg = colors.yorishige, fg = colors.base },
	DiffChange = { bg = colors.shizuku, fg = colors.base },
	DiffDelete = { fg = colors.miko, bold = true },
	DiffText = { bg = colors.tokiyuki, fg = colors.base },

	-- spell
	SpellBad = { fg = colors.miko, undercurl = true },
	SpellCap = { fg = colors.mima, undercurl = true },
	SpellLocal = { fg = colors.yorishige, undercurl = true },
	SpellRare = { fg = colors.tokiyuki, undercurl = true },

	-- misc
	Underlined = { underline = true },
	Ignore = { fg = colors.muted },
	Error = { bg = colors.miko, fg = colors.light },
	Todo = { fg = colors.mima, bold = true },

	-- traditional syntax
	Comment = { fg = colors.faint, italic = true },

	Constant = { fg = colors.mima },
	String = { fg = colors.yorishige },
	Character = { link = "Constant" },
	Number = { link = "Constant" },
	Boolean = { link = "Constant" },
	Float = { link = "Constant" },

	Identifier = { fg = colors.ayako },
	Function = { fg = colors.shizuku },

	Statement = { fg = colors.tokiyuki, bold = true },
	Conditional = { link = "Statement" },
	Repeat = { link = "Statement" },
	Label = { link = "Statement" },
	Operator = { fg = colors.text },
	Keyword = { link = "Statement" }, -- maybe change
	Exception = { link = "Statement" },

	PreProc = { fg = colors.tokiyuki },
	Include = { link = "PreProc" },
	Define = { link = "PreProc" },
	Macro = { link = "PreProc" },
	PreCondit = { link = "PreProc" },

	Type = { fg = colors.yorishige },
	StorageClass = { link = "Type" },
	Structure = { link = "Type" },
	Typedef = { fg = colors.yorishige, italic = true },

	Special = { fg = colors.ayako },
	SpecialChar = { link = "Special" },
	Tag = { link = "Special" },
	Delimiter = { fg = colors.text },
	SpecialComment = { fg = colors.faint, bold = true },
	Debug = { link = "Special" },

	-- diagonistics
	DiagnosticError = { fg = colors.miko },
	DiagnosticWarn = { fg = colors.mima },
	DiagnosticInfo = { fg = colors.tokiyuki },
	DiagnosticHint = { fg = colors.shizuku },
	DiagnosticOk = { fg = colors.yorishige },

	DiagnosticVirtualTextError = { fg = colors.miko, italic = true },
	DiagnosticVirtualTextWarn = { fg = colors.mima, italic = true },
	DiagnosticVirtualTextInfo = { fg = colors.tokiyuki, italic = true },
	DiagnosticVirtualTextHint = { fg = colors.shizuku, italic = true },
	DiagnosticVirtualTextOk = { fg = colors.yorishige, italic = true },

	DiagnosticUnderlineError = { fg = colors.miko, undercurl = true },
	DiagnosticUnderlineWarn = { fg = colors.mima, undercurl = true },
	DiagnosticUnderlineInfo = { fg = colors.tokiyuki, undercurl = true },
	DiagnosticUnderlineHint = { fg = colors.shizuku, undercurl = true },
	DiagnosticUnderlineOk = { fg = colors.yorishige, undercurl = true },

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
	["@variable.builtin"] = { fg = colors.shizuku, bold = true, italic = true },
	["@variable.parameter"] = { link = "Type" }, -- (injected_functions)
	["@variable.member"] = { fg = colors.text }, -- struct fields, object keys

	["@constant"] = { link = "Constant" },
	["@constant.builtin"] = { fg = colors.yorishige, bold = true, italic = true },
	["@constant.macro"] = { link = "Define" },

	["@module"] = { fg = colors.mima },
	["@module.builtin"] = { fg = colors.mima, bold = true, italic = true },
	["@label"] = { fg = colors.tokiyuki },

	-- literals
	["@string"] = { link = "String" },
	["@string.escape"] = { fg = colors.shizuku },
	["@string.special"] = { fg = colors.shizuku },
	["@string.regexp"] = { fg = colors.mima },
	["@string.special.url"] = { fg = colors.tokiyuki, underline = true },

	["@character"] = { link = "Character" },
	["@character.special"] = { link = "SpecialChar" },
	["@boolean"] = { link = "Boolean" },
	["@number"] = { link = "Number" },
	["@number.float"] = { link = "Float" },

	-- types
	["@type"] = { link = "Type" },
	["@type.builtin"] = { fg = colors.yorishige, bold = true, italic = true },
	["@type.definition"] = { link = "Typedef" },

	-- functions
	["@function"] = { link = "Function" },
	["@function.builtin"] = { fg = colors.ayako, bold = true, italic = true },
	["@function.macro"] = { link = "Macro" },
	["@function.method"] = { link = "Function" },
	["@constructor"] = { fg = colors.shizuku },

	-- keywords
	["@keyword"] = { link = "Keyword" },
	["@keyword.function"] = { fg = colors.tokiyuki, italic = true },
	["@keyword.operator"] = { fg = colors.tokiyuki },
	["@keyword.import"] = { link = "Include" },
	["@keyword.repeat"] = { link = "Repeat" },
	["@keyword.return"] = { fg = colors.miko, italic = true },
	["@keyword.exception"] = { link = "Exception" },
	["@keyword.conditional"] = { link = "Conditional" },
	["@keyword.directive"] = { link = "PreProc" },

	-- punctuation
	["@punctuation.delimiter"] = { fg = colors.muted },
	["@punctuation.bracket"] = { fg = colors.text },
	["@punctuation.special"] = { fg = colors.shizuku },

	-- comments
	["@comment"] = { link = "Comment" },
	["@comment.documentation"] = { fg = colors.faint, italic = true },
	["@comment.error"] = { fg = colors.miko, bold = true },
	["@comment.warning"] = { fg = colors.mima, bold = true },
	["@comment.todo"] = { fg = colors.mima, bold = true },
	["@comment.note"] = { fg = colors.tokiyuki, bold = true },

	-- markup (markdown, rst, etc.)
	["@markup.raw"] = { fg = colors.yorishige },
	["@markup.raw.block"] = { fg = colors.yorishige },
	["@markup.link"] = { fg = colors.tokiyuki, underline = true },
	["@markup.link.url"] = { fg = colors.tokiyuki, underline = true, italic = true },
	["@markup.link.label"] = { fg = colors.shizuku },
	["@markup.list"] = { fg = colors.mima },
	["@markup.heading"] = { fg = colors.shizuku, bold = true },
	["@markup.heading.1"] = { fg = colors.shizuku, bold = true },
	["@markup.heading.2"] = { fg = colors.mima, bold = true },
	["@markup.heading.3"] = { fg = colors.yorishige, bold = true },
	["@markup.heading.4"] = { fg = colors.ayako, bold = true },
	["@markup.heading.5"] = { fg = colors.tokiyuki, bold = true },
	["@markup.heading.6"] = { fg = colors.miko, bold = true },
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true, fg = colors.muted },
	["@markup.quote"] = { fg = colors.faint, italic = true },

	-- misc TS
	["@operator"] = { link = "Operator" },
	["@attribute"] = { fg = colors.mima },
	["@attribute.builtin"] = { fg = colors.mima, bold = true, italic = true },
	["@property"] = { fg = colors.shizuku, italic = true }, -- would love to change this
	["@tag"] = { fg = colors.tokiyuki },
	["@tag.builtin"] = { fg = colors.tokiyuki, bold = true, italic = true },
	["@tag.attribute"] = { fg = colors.mima },
	["@tag.delimiter"] = { fg = colors.muted },

	["@diff.plus"] = { fg = colors.yorishige },
	["@diff.minus"] = { fg = colors.miko },
	["@diff.delta"] = { fg = colors.tokiyuki },

	-- LSP semantic tokens (0.9+)
	["@lsp.type.class"] = { link = "Type" },
	["@lsp.type.decorator"] = { fg = colors.mima },
	["@lsp.type.enum"] = { link = "Type" },
	["@lsp.type.enumMember"] = { link = "Constant" },
	["@lsp.type.function"] = { link = "Function" },
	["@lsp.type.interface"] = { link = "Typedef" },
	["@lsp.type.macro"] = { link = "Macro" },
	["@lsp.type.method"] = { link = "Function" },
	["@lsp.type.namespace"] = { fg = colors.text, italic = true },
	["@lsp.type.parameter"] = { fg = colors.ayako, italic = true },
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
	markdownH1 = { fg = colors.shizuku, bold = true },
	markdownH2 = { fg = colors.mima, bold = true },
	markdownH3 = { fg = colors.yorishige, bold = true },
	markdownH4 = { fg = colors.ayako, bold = true },
	markdownH5 = { fg = colors.tokiyuki, bold = true },
	markdownH6 = { fg = colors.miko, bold = true },
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

	MiniDiffSignAdd = { fg = colors.yorishige, italic = true },
	MiniDiffSignChange = { fg = colors.tokiyuki, italic = true },
	MiniDiffSignDelete = { fg = colors.miko, italic = true },
	MiniStatuslineModeNormal = { bg = colors.high, fg = colors.text, bold = true },
	MiniStatuslineModeInsert = { bg = colors.text, fg = colors.base, bold = true },
	MiniStatuslineModeVisual = { bg = colors.shizuku, fg = colors.base, bold = true },
	MiniStatuslineModeReplace = { bg = colors.miko, fg = colors.base, bold = true },
	MiniStatuslineModeCommand = { bg = colors.tokiyuki, fg = colors.base, bold = true },
	MiniStatuslineModeOther = { bg = colors.yorishige, fg = colors.base, bold = true },
	MiniStatuslineDevinfo = { bg = colors.overlay, fg = colors.text },
	MiniStatuslineFilename = { bg = colors.surface, fg = colors.faint },
	MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
	MiniStatuslineInactive = { bg = colors.base, fg = colors.muted },
	MiniTablineCurrent = { link = "TabLineSel" },
	MiniTablineVisible = { fg = colors.mima, bg = colors.surface },
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
	vim.g.colors_name = "kamakura"

	for group, opts_tbl in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, opts_tbl)
	end
end

return U
