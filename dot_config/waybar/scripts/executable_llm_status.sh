#!/bin/bash
# llama-server (11435) + Strata (8080) の状態をwaybar表示。
# 両方表示。停止中は off。
set -u

llama_name() {
    local health model
    health="$(curl -s -m 2 "http://localhost:11435/health" 2>/dev/null)"
    [ -z "${health:-}" ] && { echo "off"; return; }
    model="$(curl -s -m 2 "http://localhost:11435/v1/models" 2>/dev/null | python3 -c 'import json,sys,os
try:
    d = json.load(sys.stdin)
    mid = d["data"][0]["id"]
    print(os.path.basename(mid).replace(".gguf", "")[:20])
except Exception:
    print("unknown")')"
    echo "${model:-unknown}"
}

strata_name() {
    local model
    model="$(curl -s -m 2 "http://127.0.0.1:8080/v1/models" 2>/dev/null | python3 -c 'import json,sys
try:
    d = json.load(sys.stdin)
    mid = d["data"][0]["id"]
    s = mid.replace("qwen3.8-flash-next-", "").replace("_", "-")[:14]
    print(s)
except Exception:
    print("")')"
    [ -z "${model:-}" ] && { echo "off"; return; }
    echo "$model"
}

L="$(llama_name)"
S="$(strata_name)"

echo "{\"text\": \" LLM S:${S} L:${L}\", \"tooltip\": \"strata: ${S} (:8080) / llama: ${L} (:11435)\"}"
