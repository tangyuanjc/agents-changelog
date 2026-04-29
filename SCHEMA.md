# Agents Changelog Schema

## 三类内容

### (a) ORG_CHANGE 组织变更
- 改 `~/.org/AGENTS.md` (宪法变更)
- 黑板架构升级 (v2.x patch)
- C-level 重构 / 派单协议变更
- 字段标准变更 (12 字段升级)
- 必由 Opus-CSO 写

### (b) DISPATCH 派单流转
- Agent 派 Agent 工单
- Paperclip issue 创建/状态变更
- `assigneeAgentId` 变更
- 任一 C-level 可写

### (c) DAILY_WRAP 日常工作
- 各 agent daily report
- 业务运营记录
- skill 使用 / 工作流执行
- 各 agent 自己写

## 写入格式 (强制 frontmatter)

每条 entry 必须含:

```markdown
## [YYYY-MM-DD HH:MM:SS] [author] [type:a|b|c] title
```

例:

```markdown
## [2026-04-30 03:00:00] [Opus-CSO] [type:a] v3.0 MVP 派单
## [2026-04-30 09:00:00] [Codex] [type:b] v3.0 MVP delivery
## [2026-04-30 21:00:00] [小J] [type:c] daily wrap
```

## 历史 entry 处理

2026-04-30 之前的 entry 不强制改格式 (历史归档, 不动). 之后所有新 entry 走 schema.

## 查询机制

```bash
# 查所有组织变更
grep "\[type:a\]" ~/agents-changelog/CHANGELOG.md

# 查所有派单流转
grep "\[type:b\]" ~/agents-changelog/CHANGELOG.md

# 查所有日常工作
grep "\[type:c\]" ~/agents-changelog/CHANGELOG.md

# 查最近 7 天派单 (macOS/BSD date)
for d in $(seq 0 6); do date -v-${d}d +%Y-%m-%d; done | while read day; do grep "\[type:b\].*$day\|$day.*\[type:b\]" ~/agents-changelog/CHANGELOG.md; done
```

## 写入约束

- 新 entry 必须标记 `[type:a]`、`[type:b]` 或 `[type:c]`。
- `CHANGELOG.md` 保持单文件，不拆历史。
- 历史 entry 只作归档，不批量重写，避免破坏审计链。
- 结构性规则更新先改本文件，再在 `CHANGELOG.md` 写一条 `[type:a]` 记录。
