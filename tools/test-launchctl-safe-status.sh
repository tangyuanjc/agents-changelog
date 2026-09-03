#!/bin/zsh
set -euo pipefail

script_dir="${0:A:h}"
subject="$script_dir/launchctl-safe-status"

fixture="$({
  print -r -- 'gui/501/com.example.safe = {'
  printf '\tstate = running\n'
  printf '\truns = 7\n'
  printf '\tpid = 4242\n'
  printf '\tlast exit code = 0\n'
  printf '\tinherited environment = {\n'
  printf '\t\tOPENAI_API_KEY => fake-secret-must-never-escape\n'
  printf '\t\tOPENAI_BASE_URL => https://secret.invalid/v1\n'
  printf '\t}\n'
  printf '\tenvironment = {\n'
  printf '\t\tANOTHER_SECRET => hidden\n'
  printf '\t}\n'
  printf '\t\tstate = active\n'
  print -r -- '}'
})"

actual="$(print -r -- "$fixture" | "$subject" --filter-stdin)"
expected="$({
  print -r -- 'state = running'
  print -r -- 'runs = 7'
  print -r -- 'pid = 4242'
  print -r -- 'last exit code = 0'
})"

[[ "$actual" == "$expected" ]] || {
  print -u2 -- "FAIL: allowlisted output mismatch"
  exit 1
}

if print -r -- "$actual" | /usr/bin/grep -Eiq 'secret|credential|token|api[_-]?key|base_url|environment|fake-secret|https?://'; then
  print -u2 -- "FAIL: sensitive fixture content escaped"
  exit 1
fi

malformed="$({
  printf '\tstate = running credential-value\n'
  printf '\truns = seven\n'
  printf '\tpid = 42 token-value\n'
  printf '\tlast exit code = secret-value\n'
})"
if print -r -- "$malformed" | "$subject" --filter-stdin >/dev/null 2>&1; then
  print -u2 -- "FAIL: malformed status values were accepted"
  exit 1
fi

if "$subject" '../bad-label' >/dev/null 2>&1; then
  print -u2 -- "FAIL: invalid label was accepted"
  exit 1
fi

print -r -- "PASS: launchctl status output is allowlisted and sensitive keys are rejected"
