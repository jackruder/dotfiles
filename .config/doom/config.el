;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "MonoLisa Nerd Font Mono" :size 14 :weight 'regular)
      doom-big-font (font-spec :family "MonoLisa Nerd Font Mono" :size 22)

      ;; Optional: only if you want variable-pitch in some modes (Org prose, etc.)
      doom-variable-pitch-font (font-spec :family "MonoLisa Nerd Font" :size 14))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/sync/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;;; Use a POSIX shell for Emacs-internal subprocesses
(setq shell-file-name
      (or (executable-find "bash")
          (executable-find "sh")
          "/bin/sh"))

;;; Keep interactive shells using your preferred shell
(setq-default vterm-shell (or (executable-find "fish") "/bin/fish"))
(setq-default explicit-shell-file-name (or (executable-find "fish") "/bin/fish"))

;;; Evil 
(after! evil-surround
        (global-evil-surround-mode 1))
(after! evil-nerd-commenter
        (evilnc-default-hotkeys))
(after! evil-embrace
        (evil-embrace-enable-evil-surround-integration))
(after! evil-easymotion
        (evilem-default-keybindings "SPC"))
(after! evil-snipe
        (evil-snipe-mode 1)
        (evil-snipe-override-mode 1))




;;; ORG ------------------------------------------------------------

;; Base location (safe to set early)
(setq org-directory (expand-file-name "~/sync/org/"))

(add-hook 'org-mode-hook #'turn-on-org-cdlatex)
(after! org
        (setq org-agenda-files (list (expand-file-name "inbox.org" org-directory)
                                     (expand-file-name "agenda.org" org-directory)
                                     (expand-file-name "projects.org" org-directory)
                                     (expand-file-name "admin.org" org-directory))
              org-default-notes-file (expand-file-name "inbox.org" org-directory))
        ;; Open PDF links inside Emacs (so pdf-tools/doc-view handles them)
        (setf (cdr (assoc "\\.pdf\\'" org-file-apps)) 'emacs)

        ;; Configure babel
        (org-babel-do-load-languages
          'org-babel-load-languages
          '((emacs-lisp . t)
            (python . t)
            (shell . t)
            (latex . t)
            (R . t)
            (julia . t)
            (c . t)
            (rust . t)
            ))

        ;; Unfold sub/superscripts (e.g., _{} and ^{})
        (setq org-appear-autosubmarkers t)

        ;; Unfold LaTeX entities (e.g., \alpha, \beta)
        (setq org-appear-autoentities t)

        ;; (Optional) Allow org-appear to work inside LaTeX fragments
        (setq org-appear-inside-latex t)

        (map! :map org-cdlatex-mode-map
              ";" #'cdlatex-math-symbol)
        )

;; Configure babel
(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)
    (shell . t)
    (latex . t)
    (R . t)
    (julia . t)
    (c . t)
    (rust . t)
    ))

;; Use LuaLaTeX + dvisvgm (PDF -> SVG) for previews
(setq org-preview-latex-default-process 'lualatex-dvisvgm)

(add-to-list 'org-preview-latex-process-alist
             '(lualatex-dvisvgm
                :programs ("lualatex" "dvisvgm")
                :description "LuaLaTeX -> PDF -> SVG (dvisvgm)"
                :message "Install lualatex and dvisvgm (Ghostscript may be needed for PDF input)."
                :image-input-type "pdf"
                :image-output-type "svg"
                :image-size-adjust (1.0 . 1.0)
                :latex-compiler ("lualatex -interaction nonstopmode -halt-on-error -output-directory %o %f")
                :image-converter ("dvisvgm --pdf --page=1- --optimize --clipjoin --bbox=min -o %O %f")))

;; Unicode math support (STIX)
(setq org-format-latex-header
      (concat
        "\\documentclass{article}\n"
        "\\usepackage{amsmath,amssymb}\n"
        "\\usepackage{fontspec}\n"
        "\\usepackage{unicode-math}\n"
        "\\setmainfont{STIXTwoText}\n"
        "\\setmathfont{STIXTwoMath}\n"
        "\\pagestyle{empty}\n"))

(require 'ox-reveal)
)


;;; ORG-ROAM -------------------------------------------------------

(setq my/papers-dir (file-truename (expand-file-name "~/data/papers/")))

(defun my/org-roam-read-pdf-link ()
  "Prompt for a PDF under `my/papers-dir` and return a file: link."
  (concat "file:"
          (file-truename
            (read-file-name
              "PDF: " my/papers-dir nil t nil
              (lambda (f)
                (or (file-directory-p f)
                    (string-match-p "\\.pdf\\'" f)))))))

(defun my/org-roam-course-link ()
  "Pick an existing course node (tagged :course:) and return an id: link."
  (let* ((node (org-roam-node-read
                 nil
                 (lambda (n)
                   (member "course" (org-roam-node-tags n))))))
    (format "[[id:%s][%s]]"
            (org-roam-node-id node)
            (org-roam-node-title node))))

(after! org-roam
        (setq org-roam-directory (file-truename (expand-file-name "~/sync/org/roam/")))
        (org-roam-db-autosync-mode)

        (setq org-roam-capture-templates
              '(("p" "Paper (PDF)" plain
                 "%?"
                 :if-new (file+head "papers/${slug}.org"
                                    "#+title: ${title}\n#+filetags: :paper:\n\n:PROPERTIES:\n:ROAM_REFS: %^{DOI/URL (optional)}\n:PDF: %(my/org-roam-read-pdf-link)\n:ADDED: %U\n:END:\n\n* Summary\n\n* Detailed notes\n\n* Key quotes / figures\n\n* Reading group\n\n* Connections\n- Concepts:\n- Related papers:\n- Related projects:\n")
                 :unnarrowed t)

                ("g" "Paper (PDF, reading group)" plain
                 "%?"
                 :if-new (file+head "papers/${slug}.org"
                                    "#+title: ${title}\n#+filetags: :paper:reading_group:\n\n:PROPERTIES:\n:ROAM_REFS: %^{DOI/URL (optional)}\n:PDF: %(my/org-roam-read-pdf-link)\n:ADDED: %U\n:END:\n\n* Summary\n\n* Detailed notes\n\n* Key quotes / figures\n\n* Reading group\n** %<%Y-%m-%d> Discussion notes\n** Questions / follow-ups\n\n* Connections\n- Concepts:\n- Related papers:\n- Related projects:\n")
                 :unnarrowed t)

                ("C" "Course hub" plain
                 "%?"
                 :if-new (file+head "courses/${slug}.org"
                                    "#+title: Course: ${title}\n#+filetags: :course:\n\n* Outline\n* Key concepts\n* Links\n")
                 :unnarrowed t)

                ;; Per-topic “lecture” note (topic-first, searchable).
                ;; Create once, then keep adding under * Coverage log.
                ("L" "Lecture topic (per topic)" plain
                 "%?"
                 :if-new (file+head "lectures/%^{Course code}/${slug}.org"
                                    "#+title: ${title}\n#+filetags: :lecture:%^{Course tag (e.g. stat501)}:\n\n:PROPERTIES:\n:COURSE: %(my/org-roam-course-link)\n:CREATED: %U\n:END:\n\n* Summary\n\n* Coverage log\n** %<%Y-%m-%d> (%^{Context: lecture/reading group/self-study|lecture})\n\n* Main notes\n\n* Definitions / statements\n\n* Examples\n\n* Questions / confusions\n\n* Links\n- Concepts:\n- Papers:\n- Projects:\n")
                 :unnarrowed t)))
        )


(after! latex
        ;; use emacs pdf-tools for viewing compiled pdfs
        (setq +latex-viewers '(pdf-tools))
        ;; Force AUCTeX's viewer used by C-c C-v (TeX-view)
        (setq TeX-view-program-selection
              '((output-pdf "PDF Tools")
                (output-dvi "DVI Viewer")
                (output-html "HTML Viewer")))

        ;; Register the "PDF Tools" viewer for AUCTeX
        (setq TeX-view-program-list
              '(("PDF Tools" TeX-pdf-tools-sync-view)))

        (setq TeX-source-correlate-mode t)
        (setq TeX-source-correlate-start-server t)
        (add-hook 'TeX-after-compilation-finished-functions
                  #'TeX-revert-document-buffer)

        ;; use lualatex and latexmk
        (setq-default TeX-engine 'luatex)
        (setq-default TeX-command-default "LatexMk")

        ;; AUCTeX uses buffer-local values; enforce defaults per LaTeX buffer
        (add-hook! 'LaTeX-mode-hook
                   (setq-local TeX-command-default "LatexMk")
                   (setq-local TeX-engine 'luatex)

                   (setq-local TeX-output-dir "build")
                   (make-directory (expand-file-name TeX-output-dir default-directory) t)

                   (setq-local TeX-save-query nil)
                   (setq-local TeX-auto-save t)
                   (setq-local TeX-parse-self t))

        ;; Automatically recompile on save.
        (add-hook 'TeX-mode-hook
                  (lambda ()
                    ;; (TeX-command-master nil) runs LatexMk silently
                    (add-hook 'after-save-hook (lambda () (TeX-command-master nil)) nil t)))

        (after! pdf-tools
                ;; When you click in build/foo.pdf, look for sources relative to the TeX project root
                (setq pdf-sync-backward-display-action t)
                (add-hook! 'pdf-view-mode-hook
                           (setq-local pdf-sync-backward-correspondence
                                       (list (cons (expand-file-name "build/" default-directory)
                                                   (file-name-as-directory default-directory))))))
        ;; (setq TeX-electric-math (cons "\\(" "\\)"))
        (add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)


        )

(after! tex
        (map! :map LaTeX-mode-map
              :localleader
              :desc "Compile master" "m" #'TeX-command-master
              :desc "Compile buffer" "b" #'TeX-command-buffer
              :desc "View"           "v" #'TeX-view))


;; Keep your prefix style
(setq cdlatex-math-symbol-prefix ?\;)


(after! cdlatex
        (setq cdlatex-command-alist
              '(
                ("int" "∫_{?}^{}" nil nil nil)
                ("in"  "∈" nil nil nil)
                ("notin"  "∉" nil nil nil)
                ("<=" "≤" nil nil nil)
                ("leq" "≤" nil nil nil)
                (">=" "≥" nil nil nil)
                ("geq" "≥" nil nil nil)
                ("sum" "≥" nil nil nil)
                ("ip" "⟨{}, {}⟩" nil nil nil)
                ))
        (setq cdlatex-math-symbol-alist
              '(
                ( ?a  ("α"          ))
                ( ?A  ("∀"          "\\aleph"))
                ( ?b  ("β"           ))
                ( ?B  (""                 ))
                ( ?c  (""                 ""                "\\cos"))
                ( ?C  ( "" "ℂ"                                "\\arccos"))
                ( ?d  ("δ"            "∂"))
                ( ?D  ("Δ"            "∇"))
                ( ?e  ("ε"            "ϵ"           "\\exp"))
                ( ?E  ("∃"            "𝔼"                "\\ln"))
                ( ?f  ("φ"            "ϕ"))
                ( ?F  ("Φ"                 ))
                ( ?g  ("γ"            ""                "\\lg"))
                ( ?G  ("Γ"            ""                "10^{?}"))
                ( ?h  ("η"            "ℏ"))
                ( ?H  (""                 ))
                ( ?i  (""             "\\imath"))
                ( ?I  (""                 "\\Im"))
                ( ?j  (""                 "\\jmath"))
                ( ?J  (""                 ))
                ( ?k  ("κ"            ))
                ( ?K  (""                 ))
                ( ?l  ("λ"           "ℓ"           "\\log"))
                ( ?L  ("Λ"           ))
                ( ?m  ("μ"             ))
                ( ?M  (""                 ))
                ( ?n  ("ν"             "∇"                "\\ln"))
                ( ?N  (""      "ℕ"         "\\exp"))
                ( ?o  ("ω"            ))
                ( ?O  ("Ω"            "℧"))
                ( ?p  ("π"             "ϖ"))
                ( ?P  ("Π"             ))
                ( ?q  ("θ"            "ϑ"))
                ( ?Q  ("Θ"            "ℚ"))
                ( ?r  ("ρ"            "ϱ"))
                ( ?R  (""             "ℝ"                 "ℜ"))
                ( ?s  ("σ"            "ς"           "\\sin"))
                ( ?S  ("Σ"            "𝕊"                "\\arcsin"))
                ( ?t  ("τ"            ""                "\\tan"))
                ( ?T  (""   "𝕋"                              "\\arctan"))
                ( ?u  ("υ"            ))
                ( ?U  ("Υ"            ))
                ( ?v  ("∨"            ))
                ( ?V  (""            ))
                ( ?w  ("ξ"             ))
                ( ?W  ("Ξ"             ))
                ( ?x  ("χ"            ))
                ( ?X  (""                 ))
                ( ?y  ("ψ"            ))
                ( ?Y  ("Ψ"            ))
                ( ?z  ("ζ"           ))
                ( ?Z  ("" "ℤ"                 ))
                ( ?   (""                 ))
                ( ?0  ("∅"       ))
                ( ?1  (""                 ))
                ( ?2  (""                 ))
                ( ?3  (""                 ))
                ( ?4  (""                 ))
                ( ?5  (""                 ))
                ( ?6  (""                 ))
                ( ?7  (""                 ))
                ( ?8  ("∞"          ))
                ( ?9  (""                 ))
                ( ?!  ("¬"            ))
                ( ?@  (""                 ))
                ( ?#  (""                 ))
                ( ?$  (""                 ))
                ( ?%  (""                 ))
                ( ?^  ("↑"        ))
                ( ?&  ("∧"          ))
                ( ?\? (""                 ))
                ( ?~  ("∼"  " ≈"         "≃"))
                ( ?_  ("↓"      ))
                ( ?+  ("∪"            ))
                ( ?-  ("̸" "" ))
                ( ?*  ("⋅" "×"          ))
                ( ?/  ("̸"            ))
                ( ?|  ("↦"         "⟼"))
                ( ?\\ ("∖"       ))
                ( ?\" (""                 ))
                ( ?=  ("⇔" "⟺"))
                ( ?\( ("⟨"         ))
                ( ?\) ("⟩"         ))
                ( ?\[ ("⇐"      "⟸"))
                ( ?\] ("⇒"     "⟹"))
                ( ?{  ("⊂"         ))
                ( ?}  ("⊃"         ))
                ( ?<  ("←"      "⟵"     "\\min"))
                ( ?>  ("→"     "⟶"    "\\max"))
                ( ?`  (""                 ))
                ( ?'  ("′"          ))
                ( ?.  ("…"  "⋯" )) ;; ldots, cdots

                )
              )
        ) 


