curl https://github.com/web-flow.gpg | gpg --import
gpg --edit-key noreply@github.com trust quit
gpg --lsign-key
gpg --lsign-key noreply@github.com
