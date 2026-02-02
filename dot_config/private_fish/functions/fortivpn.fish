function fortivpn
    set -l prof $argv[1]
    set -l dir /etc/openfortivpn/profiles.d

    set -l profiles (sudo /usr/bin/find $dir -maxdepth 1 -type f -name '*.conf' -printf '%f\n' 2>/dev/null \
        | sed 's/\.conf$//' | sort)

    if test (count $profiles) -eq 0
        echo "no profiles found in $dir"
        echo "hint: sudo ls -l $dir"
        return 1
    end

    if test -z "$prof"
        echo "usage: fortivpn <profile>"
        echo "available:"
        printf "%s\n" $profiles
        return 1
    end

    if not contains -- $prof $profiles
        echo "profile not found: $prof"
        echo "available:"
        printf "%s\n" $profiles
        return 1
    end

    set -l conf "$dir/$prof.conf"
    sudo /usr/bin/openfortivpn -c $conf
end

