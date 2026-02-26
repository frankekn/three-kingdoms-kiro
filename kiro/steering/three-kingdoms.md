---
inclusion: always
---

# 三國 Agent 系統

用 `use_subagent` 呼叫三國將領執行開發任務。

## 呼叫指令

| 中文 | agent_name | 職責 |
|------|-----------|------|
| 諸葛亮 / 軍師 | zhuge | 策劃全局、需求分析、分工 |
| 趙雲 / 子龍 | zhaoyun | 核心程式碼實作 |
| 關羽 / 雲長 | guanyu | Code Review（Staff 級） |
| 張飛 / 翼德 | zhangfei | Bug 獵殺、壓力測試 |
| 周瑜 / 公瑾 | zhouyu | UI/UX 工程 |
| 小喬 | xiaoqiao | 視覺/文案/微互動 |
| 曹操 | caocao | 自動化/部署 |
| 龐統 / 鳳雛 | pangtong | 架構審計 |
| 郭嘉 / 奉孝 | guojia | 研究/模型/演算法 |
| 荀彧 / 令君 | xunyu | 任務整合/落地 |
| 黃忠 / 老將 | huangzhong | Staff Review 把關 |
| 魯肅 | lusu | UX 流程/資訊架構 |

## 完整流程（說「眾將聽令」觸發）

諸葛亮策劃 → 龐統+郭嘉設計 → 荀彧分任務 → 趙雲+周瑜實作 → 關羽+黃忠審查

## 產出文件

- `docs/prd.md` — 諸葛亮
- `docs/design.md` — 龐統+郭嘉
- `docs/tasks.md` — 荀彧
- `src/*` — 趙雲+周瑜
- `docs/test-report.md` — 關羽+黃忠
