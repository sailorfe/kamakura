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
hi SpecialKey   guifg={{shizuku}} ctermfg={{shizuku-cterm}}
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
hi Visual       guibg={{ayako}} guifg={{base}} ctermbg={{ayako-cterm}} ctermfg={{base-cterm}}
hi Search       guifg={{base}} guibg={{mima}} ctermfg={{base-cterm}} ctermbg={{mima-cterm}}
hi IncSearch    guifg={{base}} guibg={{tokiyuki}} ctermfg={{base-cterm}} ctermbg={{tokiyuki-cterm}}
hi QuickFixLine guibg={{overlay}} ctermbg={{overlay-cterm}}
hi WildMenu     guifg={{base}} guibg={{text}} ctermfg={{base-cterm}} ctermbg={{text-cterm}}
hi StatusLine       term=bold cterm=bold guifg={{light}} guibg={{surface}} ctermfg={{light-cterm}} ctermbg={{surface-cterm}}
hi StatusLineNC     term=bold cterm=bold guifg={{muted}} guibg={{base}} ctermfg={{muted-cterm}} ctermbg={{base-cterm}}
hi StatusLineTerm   term=bold cterm=bold ctermfg={{base-cterm}} guibg={{yorishige}} ctermbg={{yorishige-cterm}}
hi StatusLineTermNC term=bold cterm=bold ctermfg={{base-cterm}} guibg={{suwa}} ctermbg={{suwa-cterm}}
hi VertSplit        guifg={{surface}} guibg={{base}} ctermfg={{surface-cterm}} ctermbg={{base-cterm}}
hi TabLine          guifg={{muted}} guibg={{surface}} ctermfg={{muted-cterm}} ctermbg={{surface-cterm}}
hi TabLineSel       guifg={{light}} guibg={{overlay}} ctermfg={{light-cterm}} ctermbg={{overlay-cterm}}
hi ToolbarLine      guibg={{high}} ctermbg={{high-cterm}}
hi ToolbarButton    guibg={{faint}} ctermbg={{faint-cterm}}
hi Pmenu        guifg={{text}} guibg={{surface}} ctermfg={{text-cterm}} ctermbg={{surface-cterm}}
hi PmenuSel     guifg={{base}} guibg={{tokiyuki}} ctermfg={{base-cterm}} ctermbg={{tokiyuki-cterm}}
hi PmenuSbar    guibg={{overlay}} ctermbg={{overlay-cterm}}
hi PmenuThumb   guibg={{high}} ctermbg={{high-cterm}}
hi ErrorMsg     guifg={{miko}} ctermfg={{miko-cterm}} guibg={{base}} ctermfg={{base-cterm}}
hi WarningMsg   guifg={{mima}} ctermfg={{mima-cterm}}
hi ModeMsg      guifg={{tokiyuki}} ctermfg={{tokiyuki-cterm}}
hi MoreMsg      guifg={{shizuku}} ctermfg={{shizuku-cterm}}
hi Question     guifg={{tokiyuki}} ctermfg={{tokiyuki-cterm}}
hi Directory    guifg={{tokiyuki}} ctermfg={{tokiyuki-cterm}}

" == syntax =======================

hi Comment      guifg={{faint}} gui=italic ctermfg={{faint-cterm}} cterm=italic
hi Constant     guifg={{mima}} ctermfg={{mima-cterm}}
hi String       guifg={{yorishige}} ctermfg={{yorishige-cterm}}
hi Identifier   guifg={{shizuku}} ctermfg={{shizuku-cterm}}
hi Function     guifg={{tokiyuki}} ctermfg={{tokiyuki-cterm}}
hi Statement    guifg={{ayako}} gui=bold ctermfg={{ayako-cterm}} cterm=bold
hi PreProc      guifg={{ayako}} ctermfg={{ayako-cterm}}
hi Type         guifg={{mima}} ctermfg={{mima-cterm}}
hi Special      guifg={{tokiyuki}} ctermfg={{tokiyuki-cterm}}
hi Underlined   guifg={{tokiyuki}} gui=underline ctermfg={{tokiyuki-cterm}} cterm=underline
hi Title        guifg={{shizuku}} gui=bold cterm=bold term=bold ctermfg={{shizuku-cterm}}
hi Todo         guifg={{base}} guibg={{mima}} ctermfg={{base-cterm}} ctermbg={{mima-cterm}}
hi Error        guibg={{miko}} ctermfg={{base-cterm}} ctermbg={{miko-cterm}} cterm=bold

" == diff =========================

hi DiffAdd      guibg={{yorishige}} ctermbg={{yorishige-cterm}} guifg={{base}} ctermfg={{base-cterm}}
hi DiffChange   guibg={{mima}} ctermbg={{mima-cterm}} guifg={{base}} ctermfg={{base-cterm}}
hi DiffDelete   guibg={{miko}} ctermbg={{miko-cterm}} guifg={{base}} ctermfg={{base-cterm}}
hi DiffText     guibg={{tokiyuki}} ctermbg={{tokiyuki-cterm}} guifg={{base}} ctermfg={{base-cterm}}

" == spell ========================

hi SpellBad     guifg={{miko}} ctermfg={{miko-cterm}} gui=underline
hi SpellCap     guifg={{mima}} ctermfg={{mima-cterm}} gui=underline
hi SpellLocal   guifg={{yorishige}} ctermfg={{yorishige-cterm}} gui=underline
hi SpellRare    guifg={{tokiyuki}} ctermfg={{tokiyuki-cterm}} gui=underline

" == term =========================

let g:terminal_ansi_colors = [
      \ '{{low}}', '{{miko}}', '{{yorishige}}', '{{mima}}',
      \ '{{tokiyuki}}', '{{ayako}}', '{{shizuku}}', '{{text}}',
      \ '{{med}}', '{{taisha}}', '{{suwa}}', '{{sasaki}}',
      \ '{{hojo}}', '{{mochizuki}}', '{{kami}}', '{{light}}'
      \ ]

let g:terminal_color_0  = '{{low}}'
let g:terminal_color_1  = '{{miko}}'
let g:terminal_color_2  = '{{yorishige}}'
let g:terminal_color_3  = '{{mima}}'
let g:terminal_color_4  = '{{tokiyuki}}'
let g:terminal_color_5  = '{{ayako}}'
let g:terminal_color_6  = '{{shizuku}}'
let g:terminal_color_7  = '{{text}}'
let g:terminal_color_8  = '{{med}}'
let g:terminal_color_9  = '{{taisha}}'
let g:terminal_color_10 = '{{suwa}}'
let g:terminal_color_11 = '{{sasaki}}'
let g:terminal_color_12 = '{{hojo}}'
let g:terminal_color_13 = '{{mochizuki}}'
let g:terminal_color_14 = '{{kami}}'
let g:terminal_color_15 = '{{light}}'
