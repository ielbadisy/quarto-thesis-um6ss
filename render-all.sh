#!/usr/bin/env bash
# Render every document in this repository: the thesis book project and
# each standalone .qmd file (slides, teaching decks, guides). `quarto
# render` on its own only builds the book project (index.qmd + Chapters +
# Appendices) since the standalone files aren't in book.chapters.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

echo "==> Thesis book (UM6SS-Thesis-Template.pdf)"
quarto render

for f in slides.qmd quarto-slides-course.qmd student-starter.qmd session-guide.qmd; do
  echo "==> $f"
  quarto render "$f"
done

echo "==> Done."
