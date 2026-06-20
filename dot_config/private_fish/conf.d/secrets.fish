# Load API keys from ~/.config/secrets/api-keys.env if exists
set -l secrets_file ~/.config/secrets/api-keys.env

if test -f $secrets_file
    for line in (string match -rv '^\s*(#|$)' < $secrets_file)
        set -l kv (string split -m 1 = $line)
        if test (count $kv) -eq 2
            set -gx $kv[1] $kv[2]
        end
    end
else if status is-interactive
    echo "secrets.fish: $secrets_file not found"
    echo "  cp ~/.config/secrets/api-keys.env.sample ~/.config/secrets/api-keys.env"
end
