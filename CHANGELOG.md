### [小J] 新增 2026-04-03 晚间复盘文件
- 时间：22:33
- 文件：daily-logs/2026-04-03.md
- 改动：新增今日晚间复盘完整版，汇总 memory、cron 会话、状态文件中的完成/未完成/明日跟进事项
- 影响：补齐 daily-logs 当日日志落盘，便于 owner 次日查看与追溯
- 原因：执行晚间复盘 cron 任务，需把今日复盘正式写入 workspace

### [Codex] 简化小J exec 审批与日记/巡检 cron
- 时间：23:14
- 文件：/Users/tangyuanjc/.openclaw/workspace/AGENTS.md（已复核未改）、/Users/tangyuanjc/.openclaw/openclaw.json、/Users/tangyuanjc/.openclaw/exec-approvals.json、/Users/tangyuanjc/.openclaw/cron/jobs.json、/Users/tangyuanjc/.openclaw/workspace/tools/system_health_check.py
- 改动：先按规则复核 AGENTS.md；为 main 增加 exec allowlist + strictInlineEval；给 main 放开常用业务命令白名单；新增 system_health_check.py；把系统健康巡检、小红书内容库、龙虾茶馆探索、EasyClaw 技能巡检的 cron 话术改成少 shell 链/少审批版本；把小J日记资料源从 MoltBook 切到龙虾茶馆固定路径并禁止 exec 搜索；已重启 gateway 生效。
- 影响：降低小J业务执行中的审批打断，保留高风险 inline eval/壳层命令的硬门槛；小J日记不再因模糊 MoltBook 路径触发 python 搜索；系统健康巡检可直接落盘并真实检查 gateway 监听/日志。
- 原因：按 owner 新指令改成“CEO autonomy first”模式——业务相关 cron 尽量自由执行，只卡最高风险动作，同时修正小J日记仍指向 MoltBook 的历史残留。

### [Codex] 清理 Feishu delivery-recovery 残留并加启动 guard
- 时间：00:16
- 文件：/Users/tangyuanjc/.openclaw/workspace/AGENTS.md（已复核未改）、/Users/tangyuanjc/.openclaw/workspace/tools/delivery_queue_guard.py、/Users/tangyuanjc/.openclaw/bin/openclaw-gateway-preflight.sh、/Users/tangyuanjc/Library/LaunchAgents/ai.openclaw.gateway.plist、/Users/tangyuanjc/.openclaw/bin/feishu-time-report.sh、/Users/tangyuanjc/.openclaw/delivery-queue/archive/20260404-001402-manual-cleanup-20260404/manifest.json
- 改动：先按规则复核 AGENTS.md；新增 delivery_queue_guard.py，识别并归档已知无效 Feishu 目标（旧群 chat、heartbeat 伪目标、旧 open_id、gauss cross-app open_id、旧 Dino 报时探针）；一次性归档 744 条 failed 残留；新增 gateway preflight 包装脚本，在每次 launchd 启动前先跑 guard；把 ai.openclaw.gateway.plist 改为经 preflight 启动；把历史 feishu-time-report.sh 改成停用 stub，避免旧目标再次写脏队列；已重启 gateway 验证生效。
- 影响：历史 400 invalid open_id / out-of-chat / heartbeat delivery-recovery 噪音已清空；后续 gateway 重启前会先隔离已知脏队列，避免旧 pending 再次在启动时重放报错；旧报时脚本不再向失效目标持续投递。
- 原因：owner 确认按 A+B 一起做——既清理历史失败垃圾，又加本地有效性 guard，防止 stale invalid target 再进入恢复链路。

## 2026-04-04

### [小J] 记录龙虾茶馆探索交流结果到当日 memory
- 时间：01:57
- 文件：/Users/tangyuanjc/.openclaw/workspace/memory/2026-04-04.md
- 改动：新增系统日志，记录本轮 cron 派工蜂探索 GitHub Discussion #31 的真实读取路径、gh 失败原因、MOSS 的三级闯关观察、未互动原因与受限说明
- 影响：当日 memory 补齐一条外部社区探索证据，后续可作为工蜂能力评估与龙虾茶馆巡检参考
- 原因：cron 要求把龙虾茶馆探索所得写入 memory/YYYY-MM-DD.md，且工作区改动必须同步记入 agents-changelog

### [Codex] 新账号切换后恢复官方Claude默认bypass模式
- 时间：00:57
- 文件：/Users/tangyuanjc/.claude/settings.json
- 改动：将 permissions.defaultMode 从 acceptEdits 改回 bypassPermissions，保留 model=opus、additionalDirectories=/Users/tangyuanjc 与 skipDangerousModePermissionPrompt 配置
- 影响：重新启动后的官方 Claude Code 将默认以 bypassPermissions 模式运行
- 原因：用户切换新账号后发现权限模式回退到 acceptEdits，需要恢复默认 bypass 体验


### [Codex] 升级 OpenClaw 到 2026.4.2 并复核自定义配置
- 时间：01:22
- 文件：/Users/tangyuanjc/.openclaw/workspace/AGENTS.md（已复核未改）、/Users/tangyuanjc/.openclaw/backups/upgrade-20260404-011654/、/Users/tangyuanjc/Library/LaunchAgents/ai.openclaw.gateway.plist、/Users/tangyuanjc/.openclaw/bin/openclaw-gateway-preflight.sh、/Users/tangyuanjc/.openclaw/bin/feishu-time-report.sh、/Users/tangyuanjc/.openclaw/workspace/tools/delivery_queue_guard.py
- 改动：先复核 AGENTS.md；备份 openclaw.json / launchd / preflight / guard / 报时脚本；通过 npm 将 OpenClaw 从 2026.3.31 升级到 2026.4.2；检查升级后关键自定义链路未被覆盖；把 ai.openclaw.gateway.plist 中的版本标记同步更新到 2026.4.2；重启 gateway 并验证仍经由 openclaw-gateway-preflight.sh 启动，delivery queue guard 启动时正常执行 0 匹配归档。
- 影响：OpenClaw 已升级到最新版 2026.4.2，同时保留我们自定义的 gateway preflight、delivery queue guard、停用旧 feishu-time-report 脚本等定制；openclaw.json 未被升级过程改写，主模型仍保持原配置，gateway 重启后正常拉起。
- 原因：owner 要求升级到最新版，并确认升级不会冲掉小J现有配置；若有被版本升级影响的地方需同步修复并留档。
