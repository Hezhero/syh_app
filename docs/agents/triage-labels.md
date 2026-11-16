# 分诊标签

各技能以五个规范分诊角色来表述。本文件把这些角色映射到本仓库 issue 追踪器中实际使用的标签字符串。

| mattpocock/skills 中的标签 | 本追踪器中的标签 | 含义 |
| --- | --- | --- |
| `needs-triage` | `needs-triage` | 维护者需评估该 issue |
| `needs-info` | `needs-info` | 等待报告者补充信息 |
| `ready-for-agent` | `ready-for-agent` | 已完整描述，可交给 AFK 智能体 |
| `ready-for-human` | `ready-for-human` | 需人工实现 |
| `wontfix` | `wontfix` | 不予处理 |

当技能提到某个角色（例如“打上 AFK 就绪的分诊标签”），使用本表中对应的标签字符串。

本仓库使用本地 markdown 追踪器，标签以 issue 文件中的 `Status:` 行体现，无需在 GitHub 上创建标签。后续如需更换标签体系，直接修改“本追踪器中的标签”一列即可。
