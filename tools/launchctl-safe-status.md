# Bounded launchd diagnostics

Never return a complete `launchctl print` result to an agent, issue, chat, or
tool receipt. A job can inherit credentials from its launchd domain even when
its plist and executable do not use them.

Use the installed helper instead:

```sh
launchctl-safe-status com.user.multica-agent-runtime-daemon
```

The helper accepts one launchd label and emits only validated top-level values
for `state`, `runs`, `pid`, and `last exit code`. It suppresses raw stderr and
rejects every other section, including `environment`, `inherited environment`,
arguments, endpoints, paths, and credential-like keys.

For a new parser fixture, pipe it through the non-live test interface:

```sh
printf '%s\n' "$fixture" | tools/launchctl-safe-status --filter-stdin
```

Run the regression before changing the filter:

```sh
tools/test-launchctl-safe-status.sh
```

Do not widen the allowlist to make an ad-hoc investigation easier. Add a
separate bounded probe that returns only a boolean or count, and test that fake
sensitive values cannot escape.
