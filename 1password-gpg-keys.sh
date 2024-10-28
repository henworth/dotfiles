#!/usr/bin/env bash
key_signature=$1

if ! command -v op >/dev/null 2>&1; then
    wget -O /tmp/op.zip https://cache.agilebits.com/dist/1P/op/pkg/v1.12.4/op_linux_arm64_v1.12.4.zip
    unzip /tmp/op.zip -d /tmp
    mv /tmp/op ~/bin/
fi

gpg --list-key "$key_signature" >/dev/null 2>&1
test $? -eq 0 && exit

eval "$(op signin personal)"
op document get "Personal GPG Public Key" --output ~/.gnupg/gpg-personal-public.gpg
op document get "Personal GPG Private Key" --output ~/.gnupg/gpg-personal-private.gpg

gpg --import ~/.gnupg/gpg-personal-public.gpg
gpg --import --allow-secret-key-import ~/.gnupg/gpg-personal-private.gpg
gpg --edit-key "$key_signature" trust quit
