;;; packages.el --- rest layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <wwguo@hiGDP>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst restructuredtext-packages
  '(
    auto-complete
    (auto-complete-rst :requires auto-complete)
    linum
    (rst :location built-in)
    (rst-directives :location local)
    (rst-lists :location local)
    flyspell
    smartparens
    yasnippet
    ))

(defun restructuredtext/post-init-auto-complete ()
  (add-hook 'rst-mode-hook 'auto-complete-mode))

(defun restructuredtext/init-auto-complete-rst ()
  (use-package auto-complete-rst
    :commands (auto-complete-rst-add-sources
               auto-complete-rst-init)
    :init (spacemacs/add-to-hook 'rst-mode-hook '(auto-complete-rst-init
                                                  auto-complete-rst-add-sources))))

(defun restructuredtext/init-post-linum ()
  ;; important auto-complete work-around to be applied to make both linum
  ;; and auto-complete to work together
  (when (configuration-layer/package-used-p 'auto-complete)
    (add-hook 'rst-mode-hook 'ac-linum-workaround t)))

(defun restructuredtext/init-rst-directives ()
  (use-package rst-directives))

(defun restructuredtext/init-rst-lists ()
  (use-package rst-lists))

(defun restructuredtext/init-rst-sphinx ()
  (use-package rst-sphinx))

(defun restructuredtext/init-rst ()
  (use-package rst
    :defer t
    :config (add-hook 'rst-adjust-hook 'rst-toc-update)
    :init
    (progn
      (spacemacs/declare-prefix-for-mode 'rst-mode "ma" "adjust sections")
      (spacemacs/declare-prefix-for-mode 'rst-mode "mr" "region")
      (spacemacs/declare-prefix-for-mode 'rst-mode "ml" "lists")
      (spacemacs/declare-prefix-for-mode 'rst-mode "mt" "toc")
      (spacemacs/declare-prefix-for-mode 'rst-mode "mc" "compile")
      (spacemacs/set-leader-keys-for-major-mode 'rst-mode
        "=" 'rst-adjust
        "h" 'rst-mark-section
        "k" 'rst-backward-section
        "j" 'rst-forward-section
        "aa" 'rst-adjust
        "ad" 'rst-display-hdr-hierarchy
        "as" 'rst-straighten-sections
        "rl" 'rst-line-block-region
        "r TAB" 'rst-shift-region
        "lb" 'rst-bullet-list-region
        "le" 'rst-enumerate-region
        "lc" 'rst-convert-bullets-to-enumeration
        "ls" 'rst-straighten-bullets-region
        "li" 'rst-insert-list
        "tt" 'rst-toc
        "ti" 'rst-toc-insert
        "tu" 'rst-toc-update
        "tj" 'rst-toc-follow-link
        "cc" 'rst-compile
        "ca" 'rst-compile-alt-toolset
        "cx" 'rst-compile-pseudo-region
        "cp" 'rst-compile-pdf-preview
        "cs" 'rst-compile-slides-preview))))

(defun restructuredtext/post-init-flyspell ()
  (spell-checking/add-flyspell-hook 'rst-mode-hook)
  ;; important auto-complete work-around to be applied to make both flyspell
  ;; and auto-complete to work together
  (when (configuration-layer/package-used-p 'auto-complete)
    (add-hook 'rst-mode-hook 'ac-flyspell-workaround t)))

(defun restructuredtext/post-init-yasnippet ()
  (add-hook 'rst-mode-hook 'spacemacs/load-yasnippet))

(defun restructuredtext/post-init-smartparens ()
  (add-hook 'rst-mode-hook 'smartparens-mode))

