### [Opus] AGENTS.md 补充爱马仕为 Team Agent + 双生CEO架构说明
- 时间：04:05
- 文件：/Users/tangyuanjc/.openclaw/workspace/AGENTS.md
- 改动：Team Agent 表新增爱马仕行（进化CEO / ~/.hermes/ / 自进化任务+AI信息监控+技能创建+小J备份）；新增"双生CEO架构"段落说明小J与爱马仕的平级共治关系；将小J角色描述从"总调度"更新为"稳态CEO + 总调度"
- 影响：小J在每次 session 启动读取 AGENTS.md 时，能看到爱马仕的存在和双方分工定位，避免职责冲突或重复派单；Codex复核AGENTS.md时也能看到完整团队拓扑
- 原因：爱马仕双生CEO体系已初始化完成（SOUL.md/USER.md/config/fallback），但小J的workspace规则文件尚未反映这一架构变更

### [Opus] 配置爱马仕双层 Fallback 链路
- 时间：03:45
- 文件：/Users/tangyuanjc/.hermes/config.yaml、/Users/tangyuanjc/.hermes/.env
- 改动：将 config.yaml 的 fallback_model（单一 opencode-zen/gpt-5.4）升级为 fallback_providers 列表（opencode-zen/gpt-5.4 → minimax/MiniMax-M2.7-highspeed）；在 .env 中新增 MINIMAX_API_KEY（月度4500次/5hr套餐，04/27到期）和 OPENCODE_ZEN 备用通道凭证；重启 gateway 验证飞书已重连
- 影响：爱马仕主链路 api.655147.xyz/gpt-5.4 故障时，自动切换到 bao-api.655147.xyz/gpt-5.4（同模型不同通道）；若仍失败则降级到 MiniMax M2.7 极速版兜底。三层保障确保飞书会话不中断
- 原因：owner 提供 bao-api 和 MiniMax 备用 key，要求配置可靠 fallback 链

### [Opus] 初始化爱马仕（Hermes Agent）双生CEO体系
- 时间：04:30
- 文件：/Users/tangyuanjc/.hermes/SOUL.md、/Users/tangyuanjc/.hermes/memories/USER.md
- 改动：为Hermes Agent写入完整SOUL.md（双生CEO人格定位、与小J分工互补关系、jc老大协作画像、团队Agent速查、绝对模式、红线规则）；更新USER.md用户画像（从1行扩充为完整profile）
- 影响：爱马仕从空白状态获得完整身份认知——知道自己是谁（进化CEO）、和谁共治（小J/稳态CEO）、服务谁（jc老大）、管理谁（团队Agent速查）、怎么做事（绝对模式+红线）。下次飞书对话将以双生CEO身份响应而非通用助手
- 原因：owner决定采用"双生CEO"架构（而非替代小J），Hermes的自进化能力补小J的记忆碎片人短板；本次为Phase 1种子文件初始化，后续通过Hermes自进化机制积累业务知识

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

### [Codex] 新增一键恢复Claude bypass命令
- 时间：02:26
- 文件：/Users/tangyuanjc/.local/bin/claude-bypass, /Users/tangyuanjc/.claude/settings.json
- 改动：新增全局命令 claude-bypass，一键将 ~/.claude/settings.json 的 permissions.defaultMode 改为 bypassPermissions；并立即执行一次，把当前账号切换后回退的 acceptEdits 修回 bypass
- 影响：用户切换 Claude 账号后可用单命令快速恢复 bypassPermissions，无需手动改配置
- 原因：账号切换流程会把默认权限模式回退到 acceptEdits，需要一个稳定、低摩擦的一键修复入口

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

### [Codex] 重排小J与轻量链模型路由到可用提供商
- 时间：03:37
- 文件：/Users/tangyuanjc/.openclaw/openclaw.json
- 改动：新增 `bao655-openai` 提供商（`https://bao-api.655147.xyz/v1`），把 `main / gauss / ogilvy / brand-agent` 主模型统一切到 `bao655-openai/gpt-5.4`；清出主链中已失效的 `juncc/JUNCC`、`codexkey`、`kimi-coding` 路径；主 fallback 重排为 `api655-openai/gpt-5.4 -> souimagery/gpt-5.4 -> api655/claude-opus-4-6 -> api655/claude-sonnet-4-6 -> bao655-openai/gpt-5.3-codex -> bao655-openai/gpt-5.2-codex -> minimax/MiniMax-M2.7-highspeed -> minimax/MiniMax-M2.7`；把 `easyclaw-heartbeat`、`light-cron` 与 `brand-agent` heartbeat 模型升级到 `minimax/MiniMax-M2.7-highspeed`；同步把 Feishu 默认模型切到 `bao655-openai/gpt-5.4`，然后重启 gateway 并做 smoke test。
- 影响：小J当前默认主链恢复到可用的 GPT-5.4 / 1.05M 上下文；轻量 cron 改走已验证可用的 MiniMax M2.7 highspeed；其余活跃数字员工不再继续踩 `juncc/JUNCC` 失效链路。
- 原因：owner 要求直接切到当前可用的 655 GPT 链路，并把 MiniMax 作为轻量兜底，优先保证小J和 cron 的稳定可用性。

### [Codex] 将小J与活跃数字员工切到 B 档免审批 exec 策略
- 时间：04:22
- 文件：/Users/tangyuanjc/.openclaw/openclaw.json
- 改动：把 `main / easyclaw-heartbeat / light-cron / gauss / ogilvy / brand-agent` 的 `tools.exec` 统一改为 `security=full`、`ask=off`、`strictInlineEval=true`；保留 inline eval 最后一层护栏，不再使用主会话原来的 `allowlist + on-miss` 中间态；重启 gateway，并用 `system_health_check.py` 做 main 与 easyclaw-heartbeat 的 exec 烟测，确认已直接执行且不再触发 approval-pending。
- 影响：小J和活跃 cron/数字员工的常规 shell / python / gh / tail / ls 等 exec 调用不再频繁要求 `/approve ...`；但最危险的 inline eval 仍保留拦截，避免完全裸奔。
- 原因：owner 明确要求按 B 方案处理——尽量消灭权限打断，同时保留最后一道安全护栏，不再让小J总被审批流程卡住。

### [Codex] 清理 OpenClaw 历史审批残留与旧 allowlist 垃圾
- 时间：04:33
- 文件：/Users/tangyuanjc/.openclaw/exec-approvals.json、/Users/tangyuanjc/.openclaw/workspace/approvals/pending.jsonl
- 改动：备份旧 `exec-approvals.json` 后，清空其中历史遗留的 `main` allowlist（ls/git/python3/gh/rg/tail 等 12 条旧白名单），将 approvals 状态重置为 `defaults={}`、`agents={}`；同时把 `workspace/approvals/pending.jsonl` 归零为空文件；随后重启 gateway 并再次用 `system_health_check.py` 做 exec 烟测，确认新 B 档策略下不依赖旧 allowlist 也能直接执行且无 `approval-pending`。
- 影响：审批系统回到干净基线，不会再被旧白名单/旧 pending 状态误导；当前真正生效的只剩 `openclaw.json` 里的 B 档 exec 策略（security=full, ask=off, strictInlineEval=true）。
- 原因：owner 同意继续做权限收尾，希望把历史 approval 残留和旧 allowlist 垃圾扫平，但不改动刚刚定下来的新权限策略。
