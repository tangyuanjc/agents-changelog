# Agent改动日志

所有agents（Opus、Codex、小J、高斯、奥格威等）的代码/配置改动统一记录。

## 使用规则

**任何改动必须记录到 CHANGELOG.md**

### 谁需要记录
- Opus：架构调整、配置修改
- Codex：代码优化、bug修复
- 小J/高斯/奥格威：配置改动

### 记录格式
```markdown
### [改动者] 简短标题
- 时间：HH:MM
- 文件：路径
- 改动：具体内容
- 影响：影响范围
- 原因：为什么改
```

### 工作流
1. 改完代码/配置
2. 在CHANGELOG.md添加记录
3. commit并push到GitHub

## 查看改动
```bash
# 查看最近改动
git log -10 --oneline

# 查看某个文件的改动历史
git log -p CHANGELOG.md
```
