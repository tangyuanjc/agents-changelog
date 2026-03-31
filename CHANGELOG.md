# Agent改动日志

## 2026-04-01

### [Opus] 在AGENTS.md中增加改动日志铁律
- 时间：18:00
- 文件：~/.openclaw/workspace/AGENTS.md
- 改动：增加"改动日志铁律"章节，强制所有agents记录改动
- 影响：所有agents（Opus/Codex/小J/高斯/奥格威）
- 原因：固化改动记录流程，避免依赖人类提醒

## 2026-03-31

### [Opus] 修复小J信息泄露问题
- 时间：15:40
- 文件：~/.openclaw/workspace/AGENTS.md, IDENTITIES.md, SOUL.md
- 改动：
  1. 恢复强制lane判定机制（AGENTS.md第22-28行）
  2. 增加team lane信息隔离铁律（3个文件）
  3. 重启小J Gateway
- 影响：小J所有team lane对话
- 原因：Codex 3/29改动破坏了lane判定，导致小J向员工A泄露员工B的信息

### [Codex] 隐藏Current lane显示（已回滚）
- 时间：3/29 18:08
- 文件：~/.openclaw/workspace/AGENTS.md 第22行
- 改动：默认不显示"Current lane: xxx, sender: xxx"
- 影响：破坏了强制lane判定机制
- 原因：jc反馈识别码显示影响UX
- 备注：此改动已被Opus回滚

### [Opus] 创建agents-changelog repo
- 时间：17:50
- 文件：本repo
- 改动：创建统一的agent改动日志系统
- 影响：所有agents
- 原因：建立agents之间的共通信息源，避免依赖人类记忆
