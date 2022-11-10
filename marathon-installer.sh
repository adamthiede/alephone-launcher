#!/bin/sh
RELEASE='20220115'

[ ! -d "${HOME}/.local/share/AlephOne/" ] && mkdir -p "${HOME}/.local/share/AlephOne"
cd "${HOME}/.local/share/AlephOne" || exit 1

[ ! -d "${HOME}/.local/share/AlephOne/Marathon" ] && curl "https://github.com/Aleph-One-Marathon/alephone/releases/download/release-${RELEASE}/Marathon-${RELEASE}-Data.zip" -o "${HOME}/.local/share/AlephOne/Marathon1.zip" && unzip -q -o Marathon1.zip
[ ! -d "${HOME}/.local/share/AlephOne/Marathon 2" ] && curl "https://github.com/Aleph-One-Marathon/alephone/releases/download/release-${RELEASE}/Marathon2-${RELEASE}-Data.zip" -o "${HOME}/.local/share/AlephOne/Marathon2.zip" && unzip -q -o Marathon2.zip
[ ! -d "${HOME}/.local/share/AlephOne/Marathon Infinity" ] && curl "https://github.com/Aleph-One-Marathon/alephone/releases/download/release-${RELEASE}/MarathonInfinity-${RELEASE}-Data.zip" -o "${HOME}/.local/share/AlephOne/Marathon3.zip" && unzip -q -o Marathon3.zip

