#!/bin/bash -xv
#
LANGUAGE=$1

L="$(echo $LANGUAGE | tr A-Z a-z)-$LANGUAGE"
echo $L
