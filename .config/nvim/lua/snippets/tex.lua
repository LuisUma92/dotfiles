local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

return {
  s({
    trig = "vh"
  },{
    t({"\\vh{"}),
    i(1),
    t({"}"})
  }),
  s({
    trig = "vc"
  },{
    t({"\\vc{"}),
    i(1),
    t({"}"})
  }),
  s({
    trig = "ni"
  },{
    t({"","\\item "}),
    i(1)
  }),
  s({
    trig = "item"
  },{
    t({"\\begin{itemize}","  \\item"}),
    i(1),
    t({"","\\end{itemize}"}),
  }),
  s({
    trig = "gather"
  },{
    t({"\\begin{gather*}","  "}),
    i(1),
    t({"","\\end{gather*}"}),
  }),
  s({
    trig = "dts"
  },{
    t({"Datos:","\\[\\begin{array}{l}",""}),
    i(1),
    t({"","\\end{array}\\]"}),
    i(2)
  }),
  s({
    trig = "template"
  },{
t({"\\documentclass[12pt,",
"  notitlepage,",
"  % openany,",
"  twoside,",
"  % twocolumn,",
"  ]{article}",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==<Definición de comandos propios>==================",
"\\newcommand{\\AAfolder}{/home/luis/.config/mytex}",
"\\usepackage{\\AAfolder/sty/SetFormat}",
"\\usepackage{\\AAfolder/sty/ColorsLight}",
"\\usepackage{\\AAfolder/sty/SetSymbols}",
"% En el siguiente comando se indica cuál es el archivo que tiene las referencias",
"\\addbibresource{\\AAfolder/bib/Biblioteca.bib}",
"%==< luisHP @ home >================================",
"% \\newcommand{\\AMfolder}{/home/luis/Documents/01-U/00-00AA-Apuntes}",
"%==< 430FM @ EFis.UCR >================================",
"% \\newcommand{\\AMfolder}{/home/luis/Documents/apuntes}",
"% \\newboolean{MC}",
"% \\setbool{MC}{true}",
"% \\setbool{solutions}{true}",
"% \\graphicspath{{new/path}}",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==< Main info >================================",
"\\title{}",
"\\date{}",
"% Use with \\lecture",
"% \\usepackage{\\AAfolder/sty/HW-header}",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==<Inicia documento>================================",
"\\begin{document}",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"% \\maketitle",
"% \\tableofcontents",
"% \\listoffigures",
"% \\listoftables",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",""}),
	i(1),
t({"","%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==<Bibliografía>====================================",
"%		Para la bibliografía se usa el gestor de",
"%	referencias bibtex. Toda la información de las",
"%	referencias se pone en un archivo aparte con la",
"%	terminación .bib y se agrega aquí",
"%",
"% \\printbibliography",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==<Apéndice>========================================",
"%		Se puede crear apéndices que luego se pueden",
"%	referenciar con la etiqueta",
"% \\appendix",
"% \\section{Figuras \\label{app:fig}}",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==<Index>===========================================",
"% \\printindex",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
"%==<Fin del documento>===============================",
"\\end{document}",
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"})
  })
}
