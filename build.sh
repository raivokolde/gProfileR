#!/bin/bash

BUILDDIR="_build"
ROXYGENIZE="\
	library(roxygen);\
	roxygenize(package.dir = \"$BUILDDIR\", roxygen.dir = \"gProfileR\", unlink.target=T, use.Rd2=T)\
"

rm -rf $BUILDDIR
mkdir $BUILDDIR
cp -a R DESCRIPTION NAMESPACE $BUILDDIR

R CMD BATCH <(echo $ROXYGENIZE) || {
	echo "roxygenize() failed! Check the .Rlog." >&2
	exit
}

R CMD check gProfileR && R CMD build gProfileR 
