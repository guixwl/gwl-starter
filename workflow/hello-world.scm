;;; Copyright © 2018 Roel Janssen <roel@gnu.org>
;;;
;;; This program is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (workflow hello-world)
  #:use-module (guix processes)
  #:use-module (guix workflows))

(define-public hello-world
  (process
   (name "hello-world")
   (version "1.0")
   (run-time (complexity
              (space (megabytes 4))
              (time 5)))
   (procedure
    '(format #t "Hello, world!~%"))
   (synopsis "Display a greeting.")
   (description "This process is part of the example workflow in
the gwl-starter repository.")))

(define-public goodbye-world
  (process (inherit hello-world)
    (name "goodbye-world")
    (procedure
     '(format #t "Goodbye, world!~%"))))

(define-public hello-workflow
  (workflow
   (name "hello-workflow")
   (version "1.0")
   (processes (list hello-world goodbye-world))
   (restrictions
    `((,goodbye-world ,hello-world)))))
