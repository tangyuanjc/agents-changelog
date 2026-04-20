# Hermes PR #13115 Weekly Checklist

- Repo: `NousResearch/hermes-agent`
- PR: `#13115` `fix(feishu): include parent media context for replies`
- URL: https://github.com/NousResearch/hermes-agent/pull/13115
- Cadence: every week until merged or explicitly abandoned

## Check Steps
- Run `gh pr view 13115 --repo NousResearch/hermes-agent --json state,mergeable,statusCheckRollup,reviewRequests,reviews,url`
- If upstream has review comments, address them on branch `fix/feishu-reply-image-context`
- If upstream main changed around `gateway/platforms/feishu.py` or `tests/gateway/test_feishu.py`, rebase fork branch and rerun `pytest -o addopts='' tests/gateway/test_feishu.py`
- If PR is still untouched, keep it alive in fork and recheck next week
- If upstream closes/replaces it, record outcome in `CHANGELOG.md`
