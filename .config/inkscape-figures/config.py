#def latex_template(name,title):
#    return '\n'.join((r"\begin{center}",
#                      r"    \includesvg[",
#                      r"        %height = \textheigth,",
#                      r"        %width = \textwidth,",
#                      r"        pretex = \relscale{1.5}",
#                      rf"    ]{{{name}}}",
#                      rf"    \caption{{{title}}}",
#                      rf"    \label{{fig:{name}}}",
#                      r"\end{center}"))

def latex_template(name, title):
    return '\n'.join((r"\begin{figure}[ht]",
                      r"    \centering",
                      rf"    \incfig{{{name}}}",
                      rf"    \caption{{{title}}}",
                      rf"    \label{{fig:{name}}}",
                      r"\end{figure}"))

# def latex_template(name, title):
#     return '\n'.join((r"\begin{center}",
#                       rf"    \incfig{{{name}}}",
#                       r"\end{center}"))
