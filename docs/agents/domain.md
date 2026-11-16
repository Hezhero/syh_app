# 领域文档

说明开发技能在探索代码库时应如何消费本仓库的领域文档。

## 探索前先读这些

- 仓库根目录的 **`GLOSSARY.md`**，或
- 若存在仓库根目录的 **`GLOSSARY-MAP.md`**：它指向每个上下文各自的 `GLOSSARY.md`，读取与当前主题相关的那些。
- **`docs/adr/`**：阅读涉及你即将改动领域的 ADR。多上下文仓库中，还要检查 `src/<context>/docs/adr/` 中的上下文级决策。

如果这些文件不存在，**静默继续**。不要指出其缺失，也不要主动建议创建。`/domain-modeling` 技能会在术语或决策真正确定时按需创建它们。

## 文件结构

单上下文仓库（多数仓库）：

```
/
├── GLOSSARY.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

多上下文仓库（根目录存在 `GLOSSARY-MAP.md`）：

```
/
├── GLOSSARY-MAP.md
├── docs/adr/                          ← 系统级决策
└── src/
    ├── ordering/
    │   ├── GLOSSARY.md
    │   └── docs/adr/                  ← 上下文级决策
    └── billing/
        ├── GLOSSARY.md
        └── docs/adr/
```

## 使用术语表中的词汇

当输出中出现领域概念（issue 标题、重构提案、假设、测试名称）时，使用 `GLOSSARY.md` 中定义的术语，不要滑向术语表明确避开的同义词。

如果需要用到的概念尚未进入术语表，这是一个信号：要么你在发明项目未使用的语言（需重新考虑），要么确实存在缺口（记录下来交给 `/domain-modeling`）。

## 标记 ADR 冲突

如果你的输出与现有 ADR 矛盾，明确指出来，而不是悄悄覆盖：

> _与 ADR-0007（事件溯源订单）冲突，但值得重新讨论，因为…_
