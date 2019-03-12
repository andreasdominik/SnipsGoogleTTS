# !/bin/bash -xv
#
# interface to TTS services: say a sentence with Snips
# usage:
#
# $ say filename language text as many words as necessary
#
# languages: any language, such as de, en, etc.
#            for de-DE and en-GB the voices "de-DE-Wavenet-C" and
#            "en-GB-Wavenet-A" are pre-selected.
#
# The resulting wav is stored played and stored as "filename" in the
# work dir.
#
# (c) Andreas Dominik
# THM University of Applied Sciences
# Gießen, DE
#
# License: GPL3
#
AUDIO_NAME=$1
shift
LANGUAGE=$1
shift
TEXT="$@"

# get installation dir:
#
LOCAL_SCRIPT="$(readlink -f "$0")"
export GOOGLE_TTS_DIR="$(dirname $LOCAL_SCRIPT)"

# get wav from Google and play:
#
cd /tmp
${GOOGLE_TTS_DIR}/src/ttsWcache.sh $AUDIO_NAME $LANGUAGE $TEXT
