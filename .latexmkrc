# Use LuaLaTeX as the PDF engine
$pdf_mode = 4;  # 4 = lualatex, 5 = xelatex
$lualatex = 'lualatex -synctex=1 -file-line-error -interaction=nonstopmode %O %S';

# Put aux and output files under build/
$aux_dir = 'build';
$out_dir = 'build';

# Use Biber for bibliography
$use_biber = 1;
$biber = 'biber %O %B';

# Optional: shell-escape 
# $lualatex = 'lualatex -shell-escape -synctex=1 -file-line-error -interaction=nonstopmode %O %S';

# Optional: be more quiet; comment out for full logs
# $silence_logfile_warnings = 1;
# $silent = 1;

