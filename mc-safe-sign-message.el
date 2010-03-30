;;; mc-safe-sign-message.el -- Code to encrypt message but make sure they aren't
;; also signed.

;;; $Id: mc-safe-sign-message.el,v 1.2 2000/12/08 07:10:49 burton Exp $

;; Copyright (C) 1997-2000 Free Software Foundation, Inc.

;; Author: Kevin A. Burton (burton@openprivacy.org)
;; Maintainer:  A. Burton (burton@openprivacy.org)
;; Location: http://relativity.yi.org
;; Keywords: mailcrypt message sign encryption
;; Version: 1.0

;; This file is [not yet] part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; I became tired of mc-sign signing mails that I had already encrypted.  This
;; is just some lisp magic to *only* sign if I haven't encrypted.  This also
;; caused some problems with mailers that required passphrases to be entered
;; twice, once on verifying the signature and again when decrypting.
;;
;; This should be added to the mailcrypt distribution IMO.

;;; Install:

;; Do a require in your .emacs (require 'mc-safe-sign-message)
;; 
;; Add (mc-safe-sign-message) to your mail hook (different for rmail, gnus, etc). 

;;; History:
;; 

(require 'mailcrypt)

;;; Code:
(defvar mc-message-encrypted nil "True if this message has been encrypted.")
(make-variable-buffer-local 'mc-message-encrypted)

(defun mc-safe-sign-message()
  "Sign this message *only* if it hasn't been encrypted"
  (interactive)

  (if (not mc-message-encrypted)
      (mc-sign 1)))

(defun mc-message-encrypted()
  "Set this message as encrypted"
  (interactive)
  (setq mc-message-encrypted t))

(add-hook 'mc-post-encryption-hook 'mc-message-encrypted)

(provide 'mc-safe-sign-message)

;;; mc-safe-sign-message.el ends here
