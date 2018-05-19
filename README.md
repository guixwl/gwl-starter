# gwl-starter

This repository contains a 
[GNU Autotools](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html)-based
project that is set up to build a workflow written in the 
[Guix Workflow Language](https://www.guixwl.org).

## Step-by-step guide

### 1. Clone/fork/copy/download this repository.

The following command will clone the repository.

```
git clone https://github.com/guixwl/gwl-starter.git
```

The following commands will download the tarball for this repository,
and unpack it.

```
wget https://github.com/roelj/guile-sparql/archive/master.tar.gz
tar axvf master.tar.gz
```

### 2. Create a Scheme module in the `workflow/` directory.

The [GNU Guile manual](https://www.gnu.org/software/guile/manual/html_node/index.html)
explains how to 
[create a Scheme module](https://www.gnu.org/software/guile/manual/html_node/Creating-Guile-Modules.html#Creating-Guile-Modules).
The `hello-world.scm` module can be used as a reference point.  When you've
created a new module, you can remove `hello-world.scm` to get rid of the demo
workflow.

### 3. Register your Scheme module in `Makefile.am`

In `Makefile.am`, there's a line that starts with `SOURCES`. This line
should contain all module files that are part of your project.

If you have extra files that need to be distributed, add them to the
`EXTRA_DIST` variable.

### 6. Build a tarball to distribute your workflow

Run the following command from the repository's root directory:
```
make dist
```

This will produce a tarball that contains the source code, and a build script.


### Bonus step: Add your workflow to GNU Guix

The final step is to add the workflow package to GNU Guix so that users
can easily install it using:
```
guix package -i <your-package-name>
```

To do so, we need to write a Guix package definition.  This is explained in [Defining packages](https://www.gnu.org/software/guix/manual/html_node/Defining-Packages.html#Defining-Packages)
and [Packaging guidelines](https://www.gnu.org/software/guix/manual/html_node/Packaging-Guidelines.html#Packaging-Guidelines) 
of the Guix manual.  The following example is the package recipe for
the `gwl-starter` repository.

```
(define-public gwl-starter
  (package
   (name "gwl-starter")
   (version "0.1.1")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/guixwl/gwl-starter/releases/download/"
                  version "/gwl-starter-" version ".tar.gz"))
            (sha256
             ;; Get the hash by running: guix download <tarball-location>.
             (base32 "054caajscr592a5ax5bzlvfvpl3fr8w008k732m0fj7yn0bj6zra"))))
   (build-system gnu-build-system)
   (arguments `(#:tests? #f)) ; There are no tests.
   (native-inputs
    `(("autoconf" ,autoconf)
      ("automake" ,automake)
      ("pkg-config" ,pkg-config)))
   (inputs
    `(("guile" ,guile-2.2)
      ("guix" ,guix)
      ("gwl" ,gwl)))
   (home-page "https://github.com/guixwl/gwl-starter")
   (synopsis "Workflow to demonstrate the working of GWL.")
   (description "This package contains the demo workflow written in the Guix
workflow language.")
   (license license:gpl3+)))
```

The [Contributing](https://www.gnu.org/software/guix/manual/html_node/Submitting-Patches.html#Submitting-Patches)
section in the Guix manual explains how to submit a patch to Guix.
