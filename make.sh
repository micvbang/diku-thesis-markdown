# Preprocessing
cat [0123456789]*.md | \
sed 's/\\alpha/$\\alpha$/g' |
sed 's/\\Sigma/$\\Sigma$/g' |
sed 's/ \\\\/ \\newline/g' \
> output.md

# Compilation
pandoc \
  --filter pandoc-crossref \
  --filter pandoc-citeproc \
  --number-sections \
  --highlight-style pygments \
  --toc \
  --toc-depth=2 \
  --template config/template.tex \
  -o "report.pdf" \
  output.md \
  config/metadata.yml

# Clean-up
rm output.md

