# Econometrics 1 — course website

M1 Econ, ENS de Lyon, 2026–2027. Static site for GitHub Pages, no build step.

```
index.html     Course: about, instructors, software and data, evaluation
slides.html    Lecture slides: schedule with HTML/PDF links, references
exercises.html Exercises
rfunctions.html Useful R functions (one <article> per function, linked from the list at the top)
style.css      site styling (shared by all pages)
slides/        one HTML + one PDF per session (NN-name.html, NN-name.pdf)
code/          R code used in class but not in the slides (NN-name.R + NN-name.html page)
.nojekyll      tells GitHub Pages to serve files as-is
```

Pages settings: Deploy from a branch → `main` → `/ (root)`.

## Add a session

1. Knit the `.Rmd` (keep `self_contained: true`) and copy the HTML to `slides/NN-name.html`.
2. Print it to `slides/NN-name.pdf` (e.g. `decktape remark NN-name.html NN-name.pdf`).
3. In `slides.html`, add the two links in that session's row of the schedule table.
4. Commit and push.

Slides are posted before each session (student version); the `_corrected` version is posted after the session.
Everything in this repository is publicly visible on the website, even though the repository is private.

## Add the R code of a session

1. Save the code as `code/NN-name.R`.
2. Copy `code/02-asymptotics-testing.html`, rename it `code/NN-name.html`, and replace the title, description, file name and the code inside `<code>` (escape `<` as `&lt;` and `&` as `&amp;`).
3. In `slides.html`, add `<a class="code" href="code/NN-name.html">Code</a>` after the PDF link of that session.
