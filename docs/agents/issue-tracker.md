# 问题追踪：本地 Markdown

本仓库的 issue 与规格文档以 markdown 文件形式存放在 `.scratch/` 目录下。

## 约定

- 每个功能一个目录：`.scratch/<feature-slug>/`
- 规格文件为 `.scratch/<feature-slug>/spec.md`
- 实现阶段的 issue 每个工单一文件，位于 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 开始编号，禁止写成单个汇总文件
- 分诊状态记录在 issue 文件顶部附近的 `Status:` 行（角色字符串见 `triage-labels.md`）
- 评论与讨论历史追加到文件底部的 `## Comments` 标题下

## 当技能要求“发布到 issue 追踪器”

在 `.scratch/<feature-slug>/` 下新建文件（目录不存在则先创建）。

## 当技能要求“获取相关工单”

读取对应路径的文件。用户通常会直接给出路径或 issue 编号。

## 寻路（Wayfinding）操作

供 `/wayfinder` 使用。**地图**是一个文件，每个工单对应一个**子文件**。

- **地图**：`.scratch/<effort>/map.md`（承载 Notes / Decisions-so-far / Fog 正文）。
- **子工单**：`.scratch/<effort>/issues/NN-<slug>.md`，从 `01` 开始编号，正文写明问题。`Type:` 行记录工单类型（`research`/`prototype`/`grilling`/`task`）；`Status:` 行记录 `claimed`/`resolved`。
- **阻塞**：顶部附近的 `Blocked by: NN, NN` 行。当它列出的每个文件都为 `resolved` 时，该工单解除阻塞。
- **前沿（Frontier）**：扫描 `.scratch/<effort>/issues/`，找出未结、未阻塞、未认领的文件；编号最小者优先。
- **认领**：先写 `Status: claimed` 并保存，然后才开始工作。
- **解决**：在 `## Answer` 标题下追加答案，将 `Status` 设为 `resolved`，再把上下文指针（要点 + 链接）追加到 `map.md` 的 Decisions-so-far。
