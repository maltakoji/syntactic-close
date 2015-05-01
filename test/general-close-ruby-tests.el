;;; general-close-ruby-tests.el --- Ruby tests

;; Copyright (C) 2015  Andreas Roehler

;; Author: Andreas Roehler <andreas.roehler@online.de>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(ert-deftest gen-close-ruby-class-test ()
  (gen-test-with-ruby-buffer "class MyClass
  private
  def a_method; true; end
  def another_method; false; end
"
    (general-close)
    (should (looking-back "end"))
    (should (eq 0 (current-indentation)))))

(ert-deftest gen-close-ruby-string-test ()
  (gen-test-with-ruby-buffer "def deliver(from: \"A\", to: nil, via: \"mail"
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest gen-close-ruby-paren-test ()
  (gen-test-with-ruby-buffer "def deliver(from: \"A\", to: nil, via: \"mail\""
    (general-close)
    ;; (sit-for 1 t) 
    (should (eq (char-before) ?\)))))

;; this fails, interpolation not recognised
;; (ert-deftest gen-close-ruby-test-3 ()
;;   (gen-test-with-ruby-buffer "def deliver(from: \"A\", to: nil, via: \"mail\")
;;   \"Sending from #{from} to #{to} via #{via"
;;     (general-close)
;;     (should (eq (char-before) ?}))
;;     (general-close)
;;     (should (eq (char-before) ?\"))))

(provide 'general-close-ruby-tests)
;;; general-close-ruby-tests.el ends here