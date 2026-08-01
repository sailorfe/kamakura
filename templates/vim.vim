" kamakura.vim -- generated from kamakura-theme.el, do not edit by hand.
" Classic Vimscript (no vim9script)

set background=light
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'kamakura'

if exists('+termguicolors')
  set termguicolors
endif

" == ui ===========================

hi Normal       guifg={{text}} guibg={{base}} ctermfg={{text-cterm}} ctermbg={{base-cterm}}
hi NonText      guifg={{muted}} ctermfg={{muted-cterm}}
hi EndOfBuffer  guifg={{muted}} ctermfg={{muted-cterm}}
hi SpecialKey   guifg={{accent06}} ctermfg={{accent06-cterm}}
hi ColorColumn  guibg={{surface}} ctermbg={{surface-cterm}}
hi Cursor       guifg={{base}} guibg={{light}} ctermfg={{base-cterm}} ctermbg={{light-cterm}}
hi CursorLine   guibg={{overlay}} ctermbg={{overlay-cterm}} cterm=NONE gui=NONE
hi CursorColumn guibg={{overlay}} ctermbg={{overlay-cterm}}
hi CursorLineNr guifg={{light}} guibg={{overlay}} ctermfg={{light-cterm}} ctermbg={{overlay-cterm}}
hi LineNr       guifg={{muted}} ctermfg={{muted-cterm}}
hi MatchParen   guifg={{light}} guibg={{overlay}} gui=bold ctermfg={{light-cterm}} ctermbg={{overlay-cterm}} cterm=bold
hi SignColumn   guifg={{faint}} ctermbg={{faint-cterm}} guibg={{overlay}} ctermbg={{overlay-cterm}}
hi FoldColumn   guifg={{high}} guibg={{low}} ctermfg={{high-cterm}} ctermbg={{low-cterm}}
hi Folded       guifg={{faint}} ctermfg={{faint-cterm}} guibg={{overlay}} ctermbg={{overlay-cterm}}
hi Conceal      guifg={{muted}} ctermbg={{muted-cterm}} guibg={{surface}} ctermbg={{surface-cterm}}
hi Visual       guibg={{accent05}} guifg={{base}} ctermbg={{accent05-cterm}} ctermfg={{base-cterm}}
hi Search       guifg={{base}} guibg={{accent03}} ctermfg={{base-cterm}} ctermbg={{accent03-cterm}}
hi IncSearch    guifg={{base}} guibg={{accent04}} ctermfg={{base-cterm}} ctermbg={{accent04-cterm}}
hi QuickFixLine guibg={{overlay}} ctermbg={{overlay-cterm}}
hi WildMenu     guifg={{base}} guibg={{text}} ctermfg={{base-cterm}} ctermbg={{text-cterm}}
hi StatusLine       term=bold cterm=bold guifg={{light}} guibg={{surface}} ctermfg={{light-cterm}} ctermbg={{surface-cterm}}
hi StatusLineNC     term=bold cterm=bold guifg={{muted}} guibg={{base}} ctermfg={{muted-cterm}} ctermbg={{base-cterm}}
hi StatusLineTerm   term=bold cterm=bold ctermfg={{base-cterm}} guibg={{accent02}} ctermbg={{accent02-cterm}}
hi StatusLineTermNC term=bold cterm=bold ctermfg={{base-cterm}} guibg={{bright02}} ctermbg={{bright02-cterm}}
hi VertSplit        guifg={{surface}} guibg={{base}} ctermfg={{surface-cterm}} ctermbg={{base-cterm}}
hi TabLine          guifg={{muted}} guibg={{surface}} ctermfg={{muted-cterm}} ctermbg={{surface-cterm}}
hi TabLineSel       guifg={{light}} guibg={{overlay}} ctermfg={{light-cterm}} ctermbg={{overlay-cterm}}
hi ToolbarLine      guibg={{high}} ctermbg={{high-cterm}}
hi ToolbarButton    guibg={{faint}} ctermbg={{faint-cterm}}
hi Pmenu        guifg={{text}} guibg={{surface}} ctermfg={{text-cterm}} ctermbg={{surface-cterm}}
hi PmenuSel     guifg={{base}} guibg={{accent04}} ctermfg={{base-cterm}} ctermbg={{accent04-cterm}}
hi PmenuSbar    guibg={{overlay}} ctermbg={{overlay-cterm}}
hi PmenuThumb   guibg={{high}} ctermbg={{high-cterm}}
hi ErrorMsg     guifg={{accent01}} ctermfg={{accent01-cterm}} guibg={{base}} ctermfg={{base-cterm}}
hi WarningMsg   guifg={{accent03}} ctermfg={{accent03-cterm}}
hi ModeMsg      guifg={{accent04}} ctermfg={{accent04-cterm}}
hi MoreMsg      guifg={{accent06}} ctermfg={{accent06-cterm}}
hi Question     guifg={{accent04}} ctermfg={{accent04-cterm}}
hi Directory    guifg={{accent04}} ctermfg={{accent04-cterm}}

" == syntax =======================

hi Comment      guifg={{faint}} gui=italic ctermfg={{faint-cterm}} cterm=italic
hi Constant     guifg={{accent03}} ctermfg={{accent03-cterm}}
hi String       guifg={{accent02}} ctermfg={{accent02-cterm}}
hi Identifier   guifg={{accent06}} ctermfg={{accent06-cterm}}
hi Function     guifg={{accent04}} ctermfg={{accent04-cterm}}
hi Statement    guifg={{accent05}} gui=bold ctermfg={{accent05-cterm}} cterm=bold
hi PreProc      guifg={{accent05}} ctermfg={{accent05-cterm}}
hi Type         guifg={{accent03}} ctermfg={{accent03-cterm}}
hi Special      guifg={{accent04}} ctermfg={{accent04-cterm}}
hi Underlined   guifg={{accent04}} gui=underline ctermfg={{accent04-cterm}} cterm=underline
hi Title        guifg={{accent06}} gui=bold cterm=bold term=bold ctermfg={{accent06-cterm}}
hi Todo         guifg={{base}} guibg={{accent03}} ctermfg={{base-cterm}} ctermbg={{accent03-cterm}}
hi Error        guibg={{accent01}} ctermfg={{base-cterm}} ctermbg={{accent01-cterm}} cterm=bold

" == diff =========================

hi DiffAdd      guibg={{accent02}} ctermbg={{accent02-cterm}} guifg={{base}} ctermfg={{base-cterm}}
hi DiffChange   guibg={{accent03}} ctermbg={{accent03-cterm}} guifg={{base}} ctermfg={{base-cterm}}
hi DiffDelete   guibg={{accent01}} ctermbg={{accent01-cterm}} guifg={{base}} ctermfg={{base-cterm}}
hi DiffText     guibg={{accent04}} ctermbg={{accent04-cterm}} guifg={{base}} ctermfg={{base-cterm}}

" == spell ========================

hi SpellBad     guifg={{accent01}} ctermfg={{accent01-cterm}} gui=underline
hi SpellCap     guifg={{accent03}} ctermfg={{accent03-cterm}} gui=underline
hi SpellLocal   guifg={{accent02}} ctermfg={{accent02-cterm}} gui=underline
hi SpellRare    guifg={{accent04}} ctermfg={{accent04-cterm}} gui=underline

" == term =========================

let g:terminal_ansi_colors = [
      \ '{{low}}', '{{accent01}}', '{{accent02}}', '{{accent03}}',
      \ '{{accent04}}', '{{accent05}}', '{{accent06}}', '{{text}}',
      \ '{{med}}', '{{bright01}}', '{{bright02}}', '{{bright03}}',
      \ '{{bright04}}', '{{bright05}}', '{{bright06}}', '{{light}}'
      \ ]

let g:terminal_color_0  = '{{low}}'
let g:terminal_color_1  = '{{accent01}}'
let g:terminal_color_2  = '{{accent02}}'
let g:terminal_color_3  = '{{accent03}}'
let g:terminal_color_4  = '{{accent04}}'
let g:terminal_color_5  = '{{accent05}}'
let g:terminal_color_6  = '{{accent06}}'
let g:terminal_color_7  = '{{text}}'
let g:terminal_color_8  = '{{med}}'
let g:terminal_color_9  = '{{bright01}}'
let g:terminal_color_10 = '{{bright02}}'
let g:terminal_color_11 = '{{bright03}}'
let g:terminal_color_12 = '{{bright04}}'
let g:terminal_color_13 = '{{bright05}}'
let g:terminal_color_14 = '{{bright06}}'
let g:terminal_color_15 = '{{light}}'
