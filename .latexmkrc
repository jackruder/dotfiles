# Use LuaLaTeX as the PDF engine
$pdf_mode = 4;  # 4 = lualatex, 5 = xelatex
$lualatex = 'lualatex -shell-escape -synctex=1 -file-line-error -interaction=nonstopmode %O %S';

# Make the dotfiles template directory (msu-colors.sty, beamerthememsu.sty, ...)
# discoverable from any project compiled with latexmk.
$ENV{'TEXINPUTS'} = "$ENV{'HOME'}/.config/doom/templates/latex//:" . ($ENV{'TEXINPUTS'} // '');

# Put aux and output files under build/
$aux_dir = 'build';
$out_dir = 'build';

# Use Biber for bibliography
$use_biber = 1;
$biber = 'biber %O %B';

# Note: -shell-escape is enabled above. Required by `minted` (pygments)
# and the `svg` package (inkscape). Only run latexmk on .tex sources you
# trust.

# Optional: be more quiet; comment out for full logs
# $silence_logfile_warnings = 1;
# $silent = 1;

