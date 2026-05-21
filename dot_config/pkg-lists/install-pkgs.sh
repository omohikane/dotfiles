#!/usr/bin/env bash
# ============================================================
# install-pkgs.sh — Modular Arch Linux package installer
#
# Reads pkglist-*.txt files from the script's directory.
# Official packages → pacman, AUR packages → yay.
# Supports interactive selection, dry-run, and diff modes.
# ============================================================
set -euo pipefail

# --------------------------------------------------------
# Constants
# --------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGDIR="${HOME}/.local/log"
LOGFILE="${LOGDIR}/pkg-install-$(date +%Y-%m-%d_%H%M%S).log"

# Lists that require explicit opt-in (excluded from "all")
OPTIN=("laptop" "vm")

# --------------------------------------------------------
# Colors
# --------------------------------------------------------
if [[ -t 1 ]]; then
    C_RED='\033[0;31m'
    C_GREEN='\033[0;32m'
    C_YELLOW='\033[0;33m'
    C_BLUE='\033[0;34m'
    C_CYAN='\033[0;36m'
    C_BOLD='\033[1m'
    C_RESET='\033[0m'
else
    C_RED='' C_GREEN='' C_YELLOW='' C_BLUE='' C_CYAN='' C_BOLD='' C_RESET=''
fi

# --------------------------------------------------------
# Logging helpers
# --------------------------------------------------------
log()  { echo -e "$1" | tee -a "$LOGFILE"; }
info() { log "${C_BLUE}[INFO]${C_RESET}  $1"; }
ok()   { log "${C_GREEN}[OK]${C_RESET}    $1"; }
warn() { log "${C_YELLOW}[WARN]${C_RESET}  $1"; }
err()  { log "${C_RED}[ERROR]${C_RESET} $1"; }

# --------------------------------------------------------
# Parse a pkglist file → two arrays (official / aur)
# --------------------------------------------------------
parse_pkglist() {
    local file="$1"
    _parsed_official=()
    _parsed_aur=()

    while IFS= read -r line; do
        # Trim whitespace
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"

        # Skip empty lines
        [[ -z "$line" ]] && continue

        # AUR package: "# (AUR) package-name"
        if [[ "$line" =~ ^#\ \(AUR\)\ (.+)$ ]]; then
            _parsed_aur+=("${BASH_REMATCH[1]}")
        # Skip other comments / section headers
        elif [[ "$line" =~ ^# ]]; then
            continue
        # Official package
        else
            _parsed_official+=("$line")
        fi
    done < "$file"
}

# --------------------------------------------------------
# Discover available lists
# --------------------------------------------------------
discover_lists() {
    local -a found=()
    for f in "$SCRIPT_DIR"/pkglist-*.txt; do
        [[ -f "$f" ]] || continue
        local name
        name="$(basename "$f")"
        name="${name#pkglist-}"
        name="${name%.txt}"
        found+=("$name")
    done
    echo "${found[@]}"
}

# --------------------------------------------------------
# Check if a list is opt-in
# --------------------------------------------------------
is_optin() {
    local name="$1"
    for o in "${OPTIN[@]}"; do
        [[ "$name" == "$o" ]] && return 0
    done
    return 1
}

# --------------------------------------------------------
# Count packages in a list file (for display)
# --------------------------------------------------------
count_pkgs() {
    local file="$1"
    parse_pkglist "$file"
    local n_off=${#_parsed_official[@]}
    local n_aur=${#_parsed_aur[@]}
    local label="${n_off}"
    ((n_aur > 0)) && label="${label} + ${n_aur} AUR"
    echo "$label"
}

# --------------------------------------------------------
# Interactive menu
# --------------------------------------------------------
interactive_menu() {
    local -a available=( $1 )
    local -a optin_mark

    echo ""
    log "${C_BOLD}利用可能なリスト:${C_RESET}"
    echo ""

    local i=1
    for name in "${available[@]}"; do
        local file="${SCRIPT_DIR}/pkglist-${name}.txt"
        local counts
        counts="$(count_pkgs "$file")"
        local mark=""
        if is_optin "$name"; then
            mark=" ${C_YELLOW}(opt-in)${C_RESET}"
        fi
        printf "  ${C_CYAN}%2d${C_RESET}) %-16s [%s]%b\n" "$i" "$name" "$counts" "$mark"
        ((i++))
    done

    echo ""
    log "${C_BOLD}選択してください:${C_RESET}"
    echo "  番号をスペース区切りで入力 (例: 1 2 3)"
    echo "  all  → opt-in 以外すべて"
    echo "  all+ → opt-in 含めすべて"
    echo "  q    → 終了"
    echo ""
    read -rp "> " selection

    [[ "$selection" == "q" ]] && exit 0

    local -a selected=()

    if [[ "$selection" == "all+" ]]; then
        selected=("${available[@]}")
    elif [[ "$selection" == "all" ]]; then
        for name in "${available[@]}"; do
            is_optin "$name" || selected+=("$name")
        done
    else
        for num in $selection; do
            if [[ "$num" =~ ^[0-9]+$ ]] && ((num >= 1 && num <= ${#available[@]})); then
                selected+=("${available[$((num - 1))]}")
            else
                warn "無効な選択: $num (スキップ)"
            fi
        done
    fi

    echo "${selected[@]}"
}

# --------------------------------------------------------
# Resolve "all" keyword in arguments
# --------------------------------------------------------
resolve_lists() {
    local -a available=( $1 )
    shift
    local -a raw_args=("$@")
    local -a resolved=()
    local has_all=false
    local has_all_plus=false
    local -a extras=()

    for arg in "${raw_args[@]}"; do
        if [[ "$arg" == "all+" ]]; then
            has_all_plus=true
        elif [[ "$arg" == "all" ]]; then
            has_all=true
        else
            extras+=("$arg")
        fi
    done

    if $has_all_plus; then
        resolved=("${available[@]}")
    elif $has_all; then
        for name in "${available[@]}"; do
            is_optin "$name" || resolved+=("$name")
        done
        # Allow explicit opt-in additions alongside "all"
        for e in "${extras[@]}"; do
            local found=false
            for r in "${resolved[@]}"; do
                [[ "$r" == "$e" ]] && found=true && break
            done
            $found || resolved+=("$e")
        done
    else
        resolved=("${extras[@]}")
    fi

    echo "${resolved[@]}"
}

# --------------------------------------------------------
# Mode: diff — show missing packages
# --------------------------------------------------------
mode_diff() {
    local -a lists=("$@")

    local -a all_official=()
    local -a all_aur=()

    for name in "${lists[@]}"; do
        local file="${SCRIPT_DIR}/pkglist-${name}.txt"
        if [[ ! -f "$file" ]]; then
            warn "リストが見つかりません: ${name} (スキップ)"
            continue
        fi
        parse_pkglist "$file"
        all_official+=("${_parsed_official[@]}")
        all_aur+=("${_parsed_aur[@]}")
    done

    local missing_off=0
    local missing_aur=0
    local installed_off=0
    local installed_aur=0

    echo ""
    log "${C_BOLD}=== 公式パッケージの差分 ===${C_RESET}"
    for pkg in "${all_official[@]}"; do
        if pacman -Qi "$pkg" &>/dev/null; then
            ((installed_off++))
        else
            log "  ${C_RED}未インストール:${C_RESET} $pkg"
            ((missing_off++))
        fi
    done

    echo ""
    log "${C_BOLD}=== AUR パッケージの差分 ===${C_RESET}"
    for pkg in "${all_aur[@]}"; do
        if pacman -Qi "$pkg" &>/dev/null; then
            ((installed_aur++))
        else
            log "  ${C_RED}未インストール:${C_RESET} $pkg"
            ((missing_aur++))
        fi
    done

    echo ""
    log "${C_BOLD}=== サマリ ===${C_RESET}"
    log "  公式: ${C_GREEN}${installed_off}個 インストール済み${C_RESET} / ${C_RED}${missing_off}個 未インストール${C_RESET}"
    log "  AUR:  ${C_GREEN}${installed_aur}個 インストール済み${C_RESET} / ${C_RED}${missing_aur}個 未インストール${C_RESET}"
}

# --------------------------------------------------------
# Mode: dry-run — show what would be installed
# --------------------------------------------------------
mode_dry_run() {
    local -a lists=("$@")

    local -a all_official=()
    local -a all_aur=()

    for name in "${lists[@]}"; do
        local file="${SCRIPT_DIR}/pkglist-${name}.txt"
        if [[ ! -f "$file" ]]; then
            warn "リストが見つかりません: ${name} (スキップ)"
            continue
        fi
        parse_pkglist "$file"
        all_official+=("${_parsed_official[@]}")
        all_aur+=("${_parsed_aur[@]}")
    done

    echo ""
    log "${C_BOLD}=== ドライラン: 以下をインストールします ===${C_RESET}"
    echo ""

    if ((${#all_official[@]} > 0)); then
        log "${C_CYAN}[pacman]${C_RESET} (${#all_official[@]}個):"
        printf '  %s\n' "${all_official[@]}" | tee -a "$LOGFILE"
    fi

    echo ""

    if ((${#all_aur[@]} > 0)); then
        log "${C_CYAN}[yay]${C_RESET} (${#all_aur[@]}個):"
        printf '  %s\n' "${all_aur[@]}" | tee -a "$LOGFILE"
    fi

    echo ""
    log "合計: 公式 ${#all_official[@]}個 + AUR ${#all_aur[@]}個 = $((${#all_official[@]} + ${#all_aur[@]}))個"
}

# --------------------------------------------------------
# Mode: install
# --------------------------------------------------------
mode_install() {
    local -a lists=("$@")
    local has_yay=true
    command -v yay &>/dev/null || has_yay=false

    local -a all_official=()
    local -a all_aur=()
    local -a selected_names=()

    for name in "${lists[@]}"; do
        local file="${SCRIPT_DIR}/pkglist-${name}.txt"
        if [[ ! -f "$file" ]]; then
            warn "リストが見つかりません: ${name} (スキップ)"
            continue
        fi
        selected_names+=("$name")
        parse_pkglist "$file"
        all_official+=("${_parsed_official[@]}")
        all_aur+=("${_parsed_aur[@]}")
    done

    if ((${#all_official[@]} == 0 && ${#all_aur[@]} == 0)); then
        warn "インストールするパッケージがありません"
        return 1
    fi

    echo ""
    log "${C_BOLD}=== インストール対象 ===${C_RESET}"
    log "  リスト: ${selected_names[*]}"
    log "  公式: ${#all_official[@]}個  AUR: ${#all_aur[@]}個"
    echo ""

    read -rp "実行しますか？ [y/N] " confirm
    [[ "$confirm" =~ ^[yY]$ ]] || { info "キャンセルしました"; return 0; }

    # --- Pass 1: Official packages via pacman ---
    if ((${#all_official[@]} > 0)); then
        info "公式パッケージをインストール中... (${#all_official[@]}個)"
        if sudo pacman -S --needed --noconfirm "${all_official[@]}" 2>&1 | tee -a "$LOGFILE"; then
            ok "公式パッケージ完了"
        else
            err "pacman でエラーが発生しました（ログ: ${LOGFILE}）"
        fi
    fi

    # --- Pass 2: AUR packages via yay ---
    if ((${#all_aur[@]} > 0)); then
        if $has_yay; then
            info "AUR パッケージをインストール中... (${#all_aur[@]}個)"
            if yay -S --needed --noconfirm "${all_aur[@]}" 2>&1 | tee -a "$LOGFILE"; then
                ok "AUR パッケージ完了"
            else
                err "yay でエラーが発生しました（ログ: ${LOGFILE}）"
            fi
        else
            warn "yay が見つかりません。以下の AUR パッケージはスキップされました:"
            printf '  %s\n' "${all_aur[@]}" | tee -a "$LOGFILE"
            warn "yay をインストールしてから再実行してください"
        fi
    fi

    echo ""
    ok "完了 — ログ: ${LOGFILE}"
}

# --------------------------------------------------------
# Usage
# --------------------------------------------------------
usage() {
    cat <<EOF

${C_BOLD}使い方:${C_RESET}
  $(basename "$0") [オプション] [リスト名...]

${C_BOLD}オプション:${C_RESET}
  --install     インストール実行 (デフォルト)
  --dry-run     インストールせず内容を表示
  --diff        現在のシステムとの差分を表示
  -h, --help    このヘルプを表示

${C_BOLD}リスト指定:${C_RESET}
  引数なし      対話メニューで選択
  リスト名      スペース区切りで直接指定 (例: core dev ai)
  all           opt-in 以外すべて
  all+          すべて（opt-in 含む）
  all laptop    all + 個別追加

${C_BOLD}例:${C_RESET}
  $(basename "$0")                        # 対話メニュー
  $(basename "$0") core dev ai            # 直接指定してインストール
  $(basename "$0") --dry-run all          # 全体をドライラン
  $(basename "$0") --diff core dev        # 差分確認
  $(basename "$0") all laptop             # laptop 込みで全部

EOF
}

# ============================================================
# Main
# ============================================================
main() {
    # Ensure log directory exists
    mkdir -p "$LOGDIR"

    # Parse mode flag
    local mode="install"
    local -a args=()

    for arg in "$@"; do
        case "$arg" in
            --install)  mode="install" ;;
            --dry-run)  mode="dry-run" ;;
            --diff)     mode="diff" ;;
            -h|--help)  usage; exit 0 ;;
            *)          args+=("$arg") ;;
        esac
    done

    # Discover available lists
    local available
    available="$(discover_lists)"

    if [[ -z "$available" ]]; then
        err "pkglist-*.txt が見つかりません (検索先: ${SCRIPT_DIR})"
        exit 1
    fi

    # Resolve list selection
    local -a selected=()

    if ((${#args[@]} == 0)); then
        # Interactive mode
        local chosen
        chosen="$(interactive_menu "$available")"
        [[ -z "$chosen" ]] && { warn "何も選択されませんでした"; exit 0; }
        selected=( $chosen )
    else
        local resolved
        resolved="$(resolve_lists "$available" "${args[@]}")"
        selected=( $resolved )
    fi

    if ((${#selected[@]} == 0)); then
        warn "何も選択されませんでした"
        exit 0
    fi

    info "モード: ${mode}"
    info "選択リスト: ${selected[*]}"
    log "---"

    # Dispatch
    case "$mode" in
        install) mode_install "${selected[@]}" ;;
        dry-run) mode_dry_run "${selected[@]}" ;;
        diff)    mode_diff "${selected[@]}" ;;
    esac
}

main "$@"
