#!/bin/bash
UTILITIES=(imgcat imgls it2api it2attention it2check it2copy it2dl it2getvar it2git it2setcolor it2setkeylabel it2ul it2universion)
DOTDIR="${HOME}/.iterm2/bin"

for U in "${UTILITIES[@]}"; do
    if [ ! -e "${DOTDIR}/${U}" ]; then
        echo "Downloading $U..."
        curl -SsL "https://iterm2.com/utilities/${U}" > "${DOTDIR}/${U}" && chmod +x "${DOTDIR}/${U}"
    fi
done
