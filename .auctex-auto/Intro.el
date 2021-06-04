(TeX-add-style-hook
 "Intro"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "english") ("inputenc" "utf8") ("mathbbol" "bbgreekl")))
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "beamer"
    "beamer10"
    "amsmath"
    "amsfonts"
    "amssymb"
    "graphicx"
    "subfig"
    "babel"
    "inputenc"
    "multicol"
    "units"
    "stmaryrd"
    "gensymb"
    "bibentry"
    "accents"
    "tensor"
    "mathbbol"
    "bm"
    "ulem"
    "booktabs"
    "multirow"
    "threeparttable")
   (TeX-add-symbols
    '("smallbibentry" 1)
    "newblock")
   (LaTeX-add-labels
    "sec:1"
    "eq:1"
    "eq:2"
    "eq:3"
    "sec:P"
    "eq:4"
    "eq:5"
    "eq:6"
    "eq:7"
    "eq:8"
    "eq:9"
    "sec:desticka"
    "fig:label"))
 :latex)

