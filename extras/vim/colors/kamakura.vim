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

hi Normal       guifg=#5d4c3b guibg=#f9f3e0 ctermfg=239 ctermbg=230
hi NonText      guifg=#8d7d66 ctermfg=101
hi EndOfBuffer  guifg=#8d7d66 ctermfg=101
hi SpecialKey   guifg=#297f88 ctermfg=30
hi ColorColumn  guibg=#f8efd2 ctermbg=230
hi Cursor       guifg=#f9f3e0 guibg=#413324 ctermfg=230 ctermbg=236
hi CursorLine   guibg=#f9e6c2 ctermbg=223 cterm=NONE gui=NONE
hi CursorColumn guibg=#f9e6c2 ctermbg=223
hi CursorLineNr guifg=#413324 guibg=#f9e6c2 ctermfg=236 ctermbg=223
hi LineNr       guifg=#8d7d66 ctermfg=101
hi MatchParen   guifg=#413324 guibg=#f9e6c2 gui=bold ctermfg=236 ctermbg=223 cterm=bold
hi SignColumn   guifg=#a59b8c ctermbg=247 guibg=#f9e6c2 ctermbg=223
hi FoldColumn   guifg=#d7c697 guibg=#ede9dd ctermfg=186 ctermbg=254
hi Folded       guifg=#a59b8c ctermfg=247 guibg=#f9e6c2 ctermbg=223
hi Conceal      guifg=#8d7d66 ctermbg=101 guibg=#f8efd2 ctermbg=230
hi Visual       guibg=#dd6d76 guifg=#f9f3e0 ctermbg=168 ctermfg=230
hi Search       guifg=#f9f3e0 guibg=#cd9e1d ctermfg=230 ctermbg=178
hi IncSearch    guifg=#f9f3e0 guibg=#937abc ctermfg=230 ctermbg=103
hi QuickFixLine guibg=#f9e6c2 ctermbg=223
hi WildMenu     guifg=#f9f3e0 guibg=#5d4c3b ctermfg=230 ctermbg=239
hi StatusLine       term=bold cterm=bold guifg=#413324 guibg=#f8efd2 ctermfg=236 ctermbg=230
hi StatusLineNC     term=bold cterm=bold guifg=#8d7d66 guibg=#f9f3e0 ctermfg=101 ctermbg=230
hi StatusLineTerm   term=bold cterm=bold ctermfg=230 guibg=#37892d ctermbg=64
hi StatusLineTermNC term=bold cterm=bold ctermfg=230 guibg=#5fad56 ctermbg=71
hi VertSplit        guifg=#f8efd2 guibg=#f9f3e0 ctermfg=230 ctermbg=230
hi TabLine          guifg=#8d7d66 guibg=#f8efd2 ctermfg=101 ctermbg=230
hi TabLineSel       guifg=#413324 guibg=#f9e6c2 ctermfg=236 ctermbg=223
hi ToolbarLine      guibg=#d7c697 ctermbg=186
hi ToolbarButton    guibg=#a59b8c ctermbg=247
hi Pmenu        guifg=#5d4c3b guibg=#f8efd2 ctermfg=239 ctermbg=230
hi PmenuSel     guifg=#f9f3e0 guibg=#937abc ctermfg=230 ctermbg=103
hi PmenuSbar    guibg=#f9e6c2 ctermbg=223
hi PmenuThumb   guibg=#d7c697 ctermbg=186
hi ErrorMsg     guifg=#aa172a ctermfg=124 guibg=#f9f3e0 ctermfg=230
hi WarningMsg   guifg=#cd9e1d ctermfg=178
hi ModeMsg      guifg=#937abc ctermfg=103
hi MoreMsg      guifg=#297f88 ctermfg=30
hi Question     guifg=#937abc ctermfg=103
hi Directory    guifg=#937abc ctermfg=103

" == syntax =======================

hi Comment      guifg=#a59b8c gui=italic ctermfg=247 cterm=italic
hi Constant     guifg=#cd9e1d ctermfg=178
hi String       guifg=#37892d ctermfg=64
hi Identifier   guifg=#297f88 ctermfg=30
hi Function     guifg=#937abc ctermfg=103
hi Statement    guifg=#dd6d76 gui=bold ctermfg=168 cterm=bold
hi PreProc      guifg=#dd6d76 ctermfg=168
hi Type         guifg=#cd9e1d ctermfg=178
hi Special      guifg=#937abc ctermfg=103
hi Underlined   guifg=#937abc gui=underline ctermfg=103 cterm=underline
hi Title        guifg=#297f88 gui=bold cterm=bold term=bold ctermfg=30
hi Todo         guifg=#f9f3e0 guibg=#cd9e1d ctermfg=230 ctermbg=178
hi Error        guibg=#aa172a ctermfg=230 ctermbg=124 cterm=bold

" == diff =========================

hi DiffAdd      guibg=#37892d ctermbg=64 guifg=#f9f3e0 ctermfg=230
hi DiffChange   guibg=#cd9e1d ctermbg=178 guifg=#f9f3e0 ctermfg=230
hi DiffDelete   guibg=#aa172a ctermbg=124 guifg=#f9f3e0 ctermfg=230
hi DiffText     guibg=#937abc ctermbg=103 guifg=#f9f3e0 ctermfg=230

" == spell ========================

hi SpellBad     guifg=#aa172a ctermfg=124 gui=underline
hi SpellCap     guifg=#cd9e1d ctermfg=178 gui=underline
hi SpellLocal   guifg=#37892d ctermfg=64 gui=underline
hi SpellRare    guifg=#937abc ctermfg=103 gui=underline

" == term =========================

let g:terminal_ansi_colors = [
      \ '#ede9dd', '#aa172a', '#37892d', '#cd9e1d',
      \ '#937abc', '#dd6d76', '#297f88', '#5d4c3b',
      \ '#dcd4c5', '#ca4455', '#5fad56', '#e2b63a',
      \ '#af9ccd', '#e7979d', '#55a1a9', '#413324'
      \ ]

let g:terminal_color_0  = '#ede9dd'
let g:terminal_color_1  = '#aa172a'
let g:terminal_color_2  = '#37892d'
let g:terminal_color_3  = '#cd9e1d'
let g:terminal_color_4  = '#937abc'
let g:terminal_color_5  = '#dd6d76'
let g:terminal_color_6  = '#297f88'
let g:terminal_color_7  = '#5d4c3b'
let g:terminal_color_8  = '#dcd4c5'
let g:terminal_color_9  = '#ca4455'
let g:terminal_color_10 = '#5fad56'
let g:terminal_color_11 = '#e2b63a'
let g:terminal_color_12 = '#af9ccd'
let g:terminal_color_13 = '#e7979d'
let g:terminal_color_14 = '#55a1a9'
let g:terminal_color_15 = '#413324'
