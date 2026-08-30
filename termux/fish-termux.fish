# fish-termux.fish - sourced only inside Termux (installed as ~/.config/fish/conf.d/termux-phone.fish)
# This file is symlinked by termux/setup.sh

if test -n "$TERMUX_VERSION"
  # --- Termux detection ---
  set -g TERMUX_PHONE 1

  # Home server via NetBird - adjust user/host if different
  set -gx HOME_SSH_TARGET "r1ppl3@endeavour-desktop-ryzen.netbird.cloud"
  set -gx FUCHU_SSH_TARGET "r1ppl3@fuchu-llm-server.netbird.cloud"

  # Short aliases for phone: less typing with Clicks
  abbr -a hs "ssh -t $HOME_SSH_TARGET 'zellij attach -c main'"
  abbr -a hsp "ssh -t $HOME_SSH_TARGET 'zellij --layout phone attach -c phone'"
  abbr -a hs-mosh "mosh $HOME_SSH_TARGET -- zellij attach -c main"
  abbr -a fs "ssh -t $FUCHU_SSH_TARGET 'zellij attach -c main'"

  # Direct ssh without zellij
  abbr -a hssh "ssh $HOME_SSH_TARGET"
  abbr -a fssh "ssh $FUCHU_SSH_TARGET"

  # On Termux, default to fish already; ensure zellij not auto-attached locally
  # (auto-attach is for home server side)

  # Optional: show hint on new shell
  if status is-interactive
    echo "(Termux phone mode) hs=home+zellij, hsp=phone layout, hssh=ssh only"
  end
end
