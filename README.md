# UM6SS Quarto thesis template

A self-contained Quarto starter for a doctoral or master's thesis at the
Université Mohammed VI des Sciences et de la Santé (UM6SS), plus a matching
beamer slide deck for the defense. Both outputs share the same red UM6SS
color palette, the same logo, and, for any figure or table, the exact same
R code, so the manuscript and the slides can never drift apart.

## Requirements

- [Quarto](https://quarto.org) >= 1.4
- A LaTeX distribution with `lualatex` (e.g. TinyTeX via `quarto install tinytex`)
- R, with the `knitr` package installed (used to run the code chunks in the
  chapters and slides)

## Quick start

Render the thesis (produces `UM6SS-Thesis-Template.pdf` at the repo root,
per `output-dir: .` in `_quarto.yml`):

```bash
quarto render
```

Render the defense slides (produces `slides.pdf`):

```bash
quarto render slides.qmd
```

Render the "how to build slides with Quarto" teaching deck (produces
`quarto-slides-course.pdf`):

```bash
quarto render quarto-slides-course.qmd
```

All of these commands can be run at any time; add `--to quarto-thesis-pdf`
or `--to beamer` explicitly if you ever add other output formats.

`quarto render` on its own only builds the book project (`index.qmd` +
`Chapters/` + `Appendices/`); it does not touch the standalone `.qmd`
files (`slides.qmd`, `quarto-slides-course.qmd`, `student-starter.qmd`,
`session-guide.qmd`) since they aren't listed in `book.chapters`. To
render everything in one go:

```bash
./render-all.sh
```

## Repository layout

```
.
├── _quarto.yml                     # Book project + thesis metadata (author, supervisor, degree, ...)
├── index.qmd                       # Opening chapter / how-to-use-this-template page
├── Chapters/
│   ├── Chapter1.qmd                 # Introduction placeholder
│   └── Chapter2.qmd                 # Methodology placeholder + example figure/table
├── Appendices/
│   └── AppendixA.qmd                 # Supporting material placeholder
├── references.qmd                  # Bibliography page (unnumbered)
├── example.bib / index-blx.bib     # Bibliography sources
├── Frontmatter/                    # .tex includes: declaration, acknowledgements,
│                                    #   abbreviations, symbols, dedication, constants
├── images/
│   └── logo.png                     # UM6SS logo, used on the thesis title page and slides
├── R/
│   └── shared-results.R            # Single source of truth for the example figure/table
├── slides.qmd                      # Beamer defense deck (sources R/shared-results.R)
├── quarto-slides-course.qmd        # Standalone "build slides with Quarto" teaching deck
├── student-starter.qmd             # Blank beamer deck for students to fill in during the session
├── session-guide.qmd               # Printable teacher's guide: timed agenda + rendering reference
├── slides-in-header.tex            # Beamer color theme matching the thesis PDF (shared by both decks)
├── render-all.sh                   # Renders the book + every standalone .qmd in one command
└── _extensions/quarto-thesis/      # The `quarto-thesis-pdf` LaTeX format
    ├── MastersDoctoralThesis.cls
    └── partials/                    # title.tex, before-body.tex, in-header.tex, definitions.tex
```

## What to personalize

- **`_quarto.yml`**: author name/url, supervisor, degree name, university,
  department, faculty, research group, quotation, and the abstract.
- **`images/logo.png`**: the official UM6SS logo, used on both the thesis
  title page (`thesis.logo` in `_quarto.yml`) and the slide deck's title
  slide (`slides-in-header.tex`). Swap it for a school/campus-specific mark
  if your program uses one, and adjust `thesis.logo-height` /
  the `\includegraphics[height=...]` value in `slides-in-header.tex` to
  match its aspect ratio.
- **`Frontmatter/*.tex`**: declaration, acknowledgements, abbreviations,
  symbols, and dedication pages.
- **`Chapters/*.qmd`** and **`Appendices/*.qmd`**: replace the placeholder
  text with real content. Add new chapter files and list them under
  `book.chapters` / `book.appendices` in `_quarto.yml`.
- **`example.bib`**: currently seeded with four real methodology references
  (CONSORT, STROBE, a biostatistics regression textbook, and a multiple
  imputation paper) cited from `Chapters/Chapter1.qmd` and `Chapter2.qmd` as
  worked examples of the `[@key]` citation syntax. Replace them with your
  own bibliography, and update the `bibliography:` key in `_quarto.yml` if
  you rename the file.
- **`slides.qmd`**: replace the placeholder outline (context, objectives,
  methods, results, discussion) with your actual defense narrative.
- **`quarto-slides-course.qmd`**: a separate, self-contained teaching deck
  ("Building Slides with Quarto"), not tied to the thesis defense content.
  One concept per slide, organized into nine sections: getting started,
  text and structure, images and figures, code and its output, tables,
  layout and emphasis, citations and cross-references, rendering and
  publishing, and using this repository for your own defense. Covers
  static images, figures from code, `fig-width`/`fig-height` vs.
  `out-width`, `echo: true`, chunk options
  (`eval`/`warning`/`message`/`include`), Markdown and code-generated
  tables, incremental reveals, two-column layouts, callout blocks, speaker
  notes, citations, cross-references, rendering the same source to other
  formats, and a concrete walkthrough of adapting `slides.qmd` and
  `R/shared-results.R` to a student's own thesis. Use it as-is for a
  workshop, or trim sections to fit a shorter session.

## Keeping thesis and slides in sync

`R/shared-results.R` defines `example_plot()` and `example_table()`. Both
`Chapters/Chapter2.qmd` and `slides.qmd` `source()` this file and call the
same functions, so any change to the analysis automatically shows up
identically in the manuscript and the deck. To add a new shared result:

1. Add a new function to `R/shared-results.R` (or add plotting/table logic
   to the existing ones).
2. Call it from a labeled code chunk in the relevant chapter
   (`#| label: fig-...` / `#| label: tbl-...` for cross-references).
3. Call the same function from a chunk in `slides.qmd`.

This pattern scales to real analyses too: point the shared script at your
actual data pipeline instead of the placeholder simulated data in
`example_data()`.

## Branding notes

- The red UM6SS accent (`#DA2025`) and dark red (`#A41D21`) are defined once
  in `_extensions/quarto-thesis/partials/in-header.tex` for the thesis PDF
  and mirrored in `slides-in-header.tex` for the beamer deck, so both
  outputs use identical colors.
- The thesis cover page and front matter (title, declaration, quotation,
  abstract, acknowledgements, table of contents/figures/tables,
  abbreviations, symbols, dedication) are assembled in
  `_extensions/quarto-thesis/partials/before-body.tex`.
- The beamer deck uses the plain default beamer theme with UM6SS colors
  applied via `\setbeamercolor` in `slides-in-header.tex`, rather than a
  third-party beamer theme, to avoid extra LaTeX package dependencies.
  Both `slides.qmd` and `quarto-slides-course.qmd` include the same
  `slides-in-header.tex`, so the defense deck and the teaching deck look
  identical.

## Build artifacts

`quarto render` writes `UM6SS-Thesis-Template.pdf`, `slides.pdf`,
`quarto-slides-course.pdf`, per-chapter HTML/PDF previews, `*_files/` asset
directories, and a copy of `MastersDoctoralThesis.cls` at the repo root
(Quarto stages the LaTeX class next to the output because
`output-dir: .`). These are all regenerable and are excluded via
`.gitignore`; do not hand-edit or commit them.

## Printing

If you need a printable, bound copy, check the `classoption` in
`_extensions/quarto-thesis/_extension.yml` and switch between `oneside` and
`twoside` to match your program's binding requirements.
