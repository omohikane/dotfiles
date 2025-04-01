function czsync
    chezmoi apply
    cd (chezmoi source-path)
    set -l msg (string join " " $argv)
    git add .
    git commit -m "$msg"
    git push
    cd -
end

