# Agent改动日志

## 2026-04-01

### [Codex] 切换官方Claude Code默认权限为bypass
- 时间：20:46
- 文件：/Users/tangyuanjc/.claude/settings.json
- 改动：将 permissions.defaultMode 从 acceptEdits 改为 bypassPermissions，保留 /Users/tangyuanjc 目录访问与 skipDangerousModePermissionPrompt 配置
- 影响：新启动的官方 Claude Code 会默认进入 bypassPermissions 模式
- 原因：用户切回官方版本后，希望恢复 bypass 模式，减少手动切换

### [Codex] 将剩余Kimi cron切换到MiniMax M2.7
- 时间：10:55
- 文件：/Users/tangyuanjc/.openclaw/cron/jobs.json
- 改动：把 `系统健康巡检`、`内容生产线-每日10:30`、`EasyClaw-每日技能巡检复刻` 三条仍使用 `kimi-coding/k2p5` 的 cron 统一切换为 `minimax/MiniMax-M2.7`，并重启 OpenClaw Gateway 使配置生效
- 影响：Kimi 会员失效后，这三条低成本 cron 将继续可运行；`EasyClaw-每日技能巡检复刻` 保持启用状态
- 原因：2026-04-01 上午 Kimi membership 校验失效，cron 连续报 402，需要切到已验证可用的 MiniMax M2.7

### [Codex] 明确README中的规则源与记录源分工
- 时间：02:17
- 文件：/Users/tangyuanjc/agents-changelog/README.md
- 改动：补充“AGENTS.md 是唯一权威规则源，CHANGELOG.md 是唯一改动记录源”的说明，明确规则与记录分层
- 影响：所有agents查看 agents-changelog README 时都能快速理解职责边界
- 原因：避免把 README 误当规则源，统一以 AGENTS.md 为准

### [Codex] 优化Feishu-Claude桥接器稳定性与交互
- 时间：01:55
- 文件：/Users/tangyuanjc/opus-tasks/feishu_claude_bridge.py, /Users/tangyuanjc/opus-tasks/install-feishu-claude-bridge-agent.sh, /Users/tangyuanjc/opus-tasks/README.md, /Users/tangyuanjc/opus-tasks/bridge.env.example, /Users/tangyuanjc/opus-tasks/docs/plans/2026-03-31-feishu-bridge-ux-stability-design.md
- 改动：新增延迟ACK机制（快回复不再先发“处理中”）、补充 /ping /model /cwd /logs 命令、增强 /status、修复 LaunchAgent reload 时 bootstrap failed: 5、补充状态字段回填与说明文档
- 影响：Feishu ↔ Claude CLI 双向桥接、后台常驻稳定性、桥接器运维可观测性
- 原因：降低聊天噪音，修复 LaunchAgent 重载不稳定问题，并让后续排查更容易

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

### [Opus] 修复小J农场和冥想机制cron配置缺失
- 时间：22:30
- 文件：系统crontab
- 改动：添加3个缺失的cron任务
  - meditation.sh: 每天02:30
  - daydream.sh: 每天10:00和15:00
  - farm.sh decay: 每天06:00
- 影响：小J的农场机制和冥想机制现在可以真正运行
- 原因：3月28日架构设计时只写了STATE.md文档，但没有实际配置到系统cron中

### [Opus] 添加4个时间敏感的cron任务
- 时间：23:15
- 文件：系统crontab
- 改动：添加4个独立cron任务确保准时执行
  - 小J日记：每天20:30
  - 业务待办提醒：每天13:00
  - 核心记忆维护：每天01:00
  - 团队记忆维护：每天01:10
- 影响：这些任务不再依赖heartbeat碰巧在正确时间运行
- 原因：之前依赖heartbeat内部时间检查不可靠，容易错过时间点

### [Opus] 废弃业务待办提醒cron任务
- 时间：23:20
- 文件：系统crontab
- 改动：移除业务待办提醒（每天13:00）
- 影响：减少与PRIORITY.md唯一真相源的冲突
- 原因：3月28日建立PRIORITY.md后，业务待办提醒机制已过时，小J heartbeat已监控P0任务
