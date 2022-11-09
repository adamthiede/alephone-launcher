#!/usr/bin/bash
[ ! -d "${HOME}/.local/share/marathon/" ] && mkdir -p "${HOME}/.local/share/marathon"

RELEASE='20220115'

#m1
[ ! -f "${HOME}/.local/share/marathon/Marathon1.zip" ] && wget -q "https://github.com/Aleph-One-Marathon/alephone/releases/download/release-${RELEASE}/Marathon-${RELEASE}-Data.zip" -O "${HOME}/.local/share/marathon/Marathon1.zip"
#m2
[ ! -f "${HOME}/.local/share/marathon/Marathon2.zip" ] && wget -q "https://github.com/Aleph-One-Marathon/alephone/releases/download/release-${RELEASE}/Marathon2-${RELEASE}-Data.zip" -O "${HOME}/.local/share/marathon/Marathon2.zip"
#m3
[ ! -f "${HOME}/.local/share/marathon/Marathon3.zip" ] && wget -q "https://github.com/Aleph-One-Marathon/alephone/releases/download/release-${RELEASE}/MarathonInfinity-${RELEASE}-Data.zip" -O "${HOME}/.local/share/marathon/Marathon3.zip"


cd "${HOME}/.local/share/marathon" || exit 1
[ ! -d "${HOME}/.local/share/marathon/Marathon" ] && unzip -q -o Marathon1.zip
[ ! -d "${HOME}/.local/share/marathon/Marathon2" ] && unzip -q -o Marathon2.zip && mv 'Marathon 2' Marathon2
[ ! -d "${HOME}/.local/share/marathon/MarathonInfinity" ] && unzip -q -o Marathon3.zip && mv 'Marathon Infinity' MarathonInfinity

