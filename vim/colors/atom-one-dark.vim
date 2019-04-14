" Vim atom-one-dark color file
"
" Author: Boxiang Sun <daetalusun@gmail.com>
" https://github.com/Daetalus/atom-one-dark
"
" Note: Based on the default one dark theme for Atom with some modifications
"

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="atom-one-dark"

" Set GUI and Terminal color values
if has("gui_running")
    let s:white          = "F8F8F2"
    let s:black          = "000000"
    let s:darkgrey       = "202020"
    let s:darkSlateGray  = "8FBFDC"
    let s:lightGoldenRod = "E5C17C"
    let s:turquoise      = "66D9EF"
    let s:greypuple      = "59626F"
    let s:grey53         = "95A2BB"
    let s:cadetBlue      = "61AEAF"
    let s:darkOliveGreen = "79B950"
    let s:lightSalmon    = "DAA74F"
    let s:darkgreen      = "90C378"
    let s:sandybrown     = "FD971F"
    let s:holydew        = "D2EBBE"
    let s:grey3          = "080808"
    let s:paleGreen      = "5FD75F"
    let s:indianRed      = "DF6F73"
    let s:darkGoldenRod  = "AF8700"
    let s:najaroWhite    = "ADAD87"
    let s:mistyRose      = "89707D"
    let s:deepPink       = "960050"
    let s:grey19         = "293739"
    let s:grey30         = "465457"
    let s:grey15         = "232526"
    let s:grey27         = "444444"
    let s:grey50         = "808080"
    let s:grey54         = "7E8E91"
    let s:grey62         = "9098A0"
    let s:grey66         = "BCA3A3"
    let s:grey82         = "D0D0D0"
    let s:grey70         = "A6B2C0"
    let s:grey85         = "CDD3DE"
    let s:grey46         = "777777"
    let s:orchid         = "B27ECD"
else
    let s:white          = "White"
    let s:black          = "16"
    let s:cadetBlue      = "75"
    let s:paleGreen      = "77"
    let s:turquoise      = "80"
    let s:grey53         = "102"
    let s:darkSlateGray  = "116"
    let s:darkGoldenRod  = "136"
    let s:najaroWhite    = "144"
    let s:orchid         = "140"
    let s:darkgreen      = "150"
    let s:darkOliveGreen = "107"
    let s:deepPink       = "162"
    let s:indianRed      = "167"
    let s:lightSalmon    = "173"
    let s:lightGoldenRod = "179"
    let s:mistyRose      = "181"
    let s:holydew        = "194"
    let s:sandybrown     = "215"
    let s:grey3          = "232"
    let s:darkgrey       = "234"
    let s:grey15         = "235"
    let s:grey19         = "236"
    let s:grey27         = "238"
    let s:grey30         = "239"
    let s:greypuple      = "241"
    let s:grey46         = "243"
    let s:grey50         = "244"
    let s:grey54         = "245"
    let s:grey62         = "247"
    let s:grey66         = "248"
    let s:grey70         = "249"
    let s:grey82         = "252"
    let s:grey85         = "253"
endif

" Highlighting function
fun <sid>hi(group, fg, bg, format)
    if has("gui_running")
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg
        endif
    else
        if a:fg != ""
            exec "hi " . a:group . " ctermfg=" . a:fg
        endif
        if a:bg != ""
            exec "hi " . a:group . " ctermbg=" . a:bg
        endif
    endif

    if a:format != ""
        exec "hi " . a:group . " gui=" . a:format . " cterm=" . a:format
    endif
endfun

call <sid>hi("Boolean", s:lightSalmon, "", "none")
call <sid>hi("Character", s:darkgreen, "", "none")
call <sid>hi("Number", s:lightSalmon, "", "none")
call <sid>hi("String", s:darkgreen, "", "none")
call <sid>hi("Conditional", s:indianRed, "", "bold")
call <sid>hi("Constant", s:lightSalmon, "", "bold")
call <sid>hi("Cursor", s:black, s:white, "none")
call <sid>hi("iCursor", s:black, s:white, "none")
call <sid>hi("Debug", s:grey66, "", "bold")
call <sid>hi("Define", s:orchid, "", "none")
call <sid>hi("Delimiter", s:grey70, "", "none")
call <sid>hi("DiffAdd", s:holydew, s:darkOliveGreen, "none")
call <sid>hi("DiffChange", s:mistyRose, s:grey30, "none")
call <sid>hi("DiffDelete", s:deepPink, s:grey30, "none")
call <sid>hi("DiffText", "", s:grey30, "italic,bold")
call <sid>hi("Directory", s:darkSlateGray, "", "bold")
call <sid>hi("Error", s:lightGoldenRod, s:grey30, "none")
call <sid>hi("ErrorMsg", "", s:grey15, "bold")
call <sid>hi("Exception", s:indianRed, "", "bold")
call <sid>hi("Float", s:lightSalmon, "", "none")"
call <sid>hi("FoldColumn", s:grey30, s:black, "none")
call <sid>hi("Folded", s:grey70, s:black, "none")
call <sid>hi("Function", s:cadetBlue, "", "none")
call <sid>hi("Indentifier", s:sandybrown, "", "none")
call <sid>hi("Ignore", s:grey50, s:darkgrey, "none")
call <sid>hi("IncSearch", s:grey30, s:darkOliveGreen, "none")
call <sid>hi("Keyword", s:orchid, "", "bold")
call <sid>hi("Label", s:darkgreen, "", "none")
call <sid>hi("Macro", s:najaroWhite, "", "italic")
call <sid>hi("SpecialKey", s:grey27, "", "italic")
call <sid>hi("MatchParen", s:white, s:grey30, "underline")
call <sid>hi("ModeMsg", s:darkgreen, "", "none")
call <sid>hi("MoreMsg", s:darkOliveGreen, "", "none")
call <sid>hi("Operator", s:darkSlateGray, "", "none")

" complete menu
call <sid>hi("Pmenu", s:turquoise, s:grey15 , "none")
call <sid>hi("PmenuSel", "", s:grey50, "")
call <sid>hi("PmenuSbar", "", s:grey3, "")
call <sid>hi("PmenuThumb", s:turquoise, "", "")
call <sid>hi("PreCondit", s:darkOliveGreen, "", "bold")
call <sid>hi("PreProc", s:darkSlateGray, "", "none")
call <sid>hi("Question", s:paleGreen, "", "none")
call <sid>hi("Repeat", s:indianRed, "", "bold")
call <sid>hi("Search", s:grey19, s:grey85, "underline")
call <sid>hi("SignColumn", s:grey46, s:grey19, "none")
call <sid>hi("SpecialChar", s:indianRed, "", "bold")
call <sid>hi("SpecialComment", s:grey54, "", "bold")
call <sid>hi("Special", s:darkOliveGreen, s:darkgrey, "italic")
if has("spell")
    if has("guirunning")
        hi SpellBad    guisp=#A03939 gui=undercurl
        hi SpellCap    guisp=#F391A9 gui=undercurl
        hi SpellLocal  guisp=#540063 gui=undercurl
        hi SpellRare   guisp=#2D7067 gui=undercurl
    else
        hi SpellBad    gui=undercurl
        hi SpellCap    gui=undercurl
        hi SpellLocal  gui=undercurl
        hi SpellRare   gui=undercurl
    endif
endif

call <sid>hi("Statement", s:orchid, "", "bold")
call <sid>hi("StatusLine", s:grey53, "", "italic")
call <sid>hi("StatusLineNC", s:grey50, s:grey3, "none")
call <sid>hi("StorageClass", s:orchid, "", "italic")
call <sid>hi("Structure", s:lightSalmon, "", "none")
call <sid>hi("Tag", s:indianRed, "", "italic")
call <sid>hi("Title", s:darkOliveGreen, "", "none")
call <sid>hi("Todo", s:white, s:darkgrey, "bold")
call <sid>hi("Type", s:lightGoldenRod, "", "bold")
call <sid>hi("Underlined", s:grey50, "", "underline")
call <sid>hi("VertSplit", s:grey50, s:grey3, "none")
call <sid>hi("VisualNOS", "", s:grey30, "none")
call <sid>hi("Visual", "", s:grey30, "none")
call <sid>hi("WarningMsg", s:white, s:grey27, "bold")
call <sid>hi("WildMenu", "", s:grey19, "underline")

call <sid>hi("TabLineFill", s:grey62, "", "")
call <sid>hi("TabLine", s:darkgrey, s:grey50, "none")
call <sid>hi("Normal", s:white, s:darkgrey, "none")
call <sid>hi("Comment", s:grey54, "", "none")
call <sid>hi("CursorLine", "", s:grey19, "underline")
call <sid>hi("CursorLineNr", s:grey82, "", "none")
call <sid>hi("CursorColumn", s:grey19, "", "none")
call <sid>hi("ColorColumn", "", s:greypuple, "")
call <sid>hi("LineNr", s:grey30, s:grey15, "none")
call <sid>hi("NonText", s:grey30, "", "")
call <sid>hi("SpecialKey", s:grey30, "", "")

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
" Remove functions
delf <sid>hi
