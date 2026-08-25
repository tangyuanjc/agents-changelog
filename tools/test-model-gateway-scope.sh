#!/bin/zsh
set -euo pipefail

script_dir="${0:A:h}"
grok_wrapper="/Users/tangyuanjc/.local/bin/multica-grok-acp"

shell_probe="$(env -u OPENAI_API_KEY -u OPENAI_BASE_URL -u XAI_API_KEY -u GROK_MODELS_BASE_URL /bin/zsh -lc '
  if [[ -n "${OPENAI_API_KEY:-}" || -n "${XAI_API_KEY:-}" ]]; then
    print present
  else
    print absent
  fi
')"
[[ "$shell_probe" == "absent" ]] || {
  print -u2 -- "FAIL: shell initialization exported a model credential"
  exit 1
}

scoped_probe="$(
  env -u OPENAI_API_KEY -u OPENAI_BASE_URL -u XAI_API_KEY -u GROK_MODELS_BASE_URL \
    GROK_BIN="$script_dir/model-gateway-env-probe" \
    "$grok_wrapper"
)"
[[ "$scoped_probe" == $'scoped_key_match=true\nxai_alias_match=true' ]] || {
  print -u2 -- "FAIL: Grok did not load the scoped credential aliases"
  exit 1
}

gui_value="$(/bin/launchctl getenv OPENAI_API_KEY 2>/dev/null || true)"
[[ -z "$gui_value" ]] || {
  print -u2 -- "FAIL: GUI launchd still publishes the model credential"
  exit 1
}

[[ "$(/usr/bin/stat -f '%Lp' "$HOME/.codex/auth.json")" == "600" ]] || {
  print -u2 -- "FAIL: Codex auth config mode is not 0600"
  exit 1
}
[[ "$(/usr/bin/stat -f '%Lp' "$HOME/.hermes/profiles/coo/.env")" == "600" ]] || {
  print -u2 -- "FAIL: Hermes profile credential mode is not 0600"
  exit 1
}

print -r -- "PASS: model credentials are consumer-scoped and private"
