#!/bin/bash -xv
#
# retrieve a sound file from Google TTS
# and write it to a cache in order to be re-used
#
# usage:
#

AUDIO_NAME=$1
shift
LANGUAGE=$1
shift
TEXT="$@"

case $LANGUAGE in
    de)
        COUNTRY="DE"
        ;;
    en)
        COUNTRY="GB"
        ;;
    *)
        COUNTRY="$(echo $COUNTRY | tr a-z A-Z)"
        ;;
esac
LANCODE="${LANGUAGE}-${COUNTRY}"

# language-specfic cache:
#
CACHE=${TTS_GOOGLE}/Cache
if [[ ! -d "${CACHE}/$LANCODE" ]] ; then
    mkdir "${CACHE}/$LANCODE"
fi
CACHE="${CACHE}/${LANCODE}"

TTS_SERVICE=${TTS_GOOGLE}/src/ttsREST.sh

CACHED_NAME=$(echo $TEXT | tr '/' '_' | sed 's/[^(0-9a-zA-Z)]/_/g').wav
LEN=$(echo $CACHED_NAME | wc -c)

# use caching for strings smaller then 256
if [[ $LEN -lt 64 ]] ; then

    if [[ -e ${CACHE}/${CACHED_NAME} ]] ; then
        cp ${CACHE}/${CACHED_NAME} $AUDIO_NAME
    else
        ${TTS_SERVICE} ${AUDIO_NAME} ${LANCODE} "${TEXT}"
        if [[ -s ${AUDIO_NAME} ]]; then
            cp ${AUDIO_NAME} ${CACHE}/${CACHED_NAME}
        fi
    fi
else
    ${TTS_SERVICE} ${AUDIO_NAME} ${LANCODE} "${TEXT}"
fi