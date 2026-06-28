# Ackem 代码库与产物路径说明

> **产品版本**：Ackem **v1.0.0**  
> **更新**：2026-07-01  
> **仓库**：https://github.com/JasonLiu0826/Ackem

---

## 1. 三个位置，不要混淆

| 角色 | 本机路径（Windows） | 用途 |
|------|---------------------|------|
| **A. GitHub 源码仓库** | `C:\Users\JasonLiu\Desktop\Github-open\Ackem-v0.0.0\` | `git push` 的目录：`src/`、`docs/`、`package.json` |
| **B. 开发同步副本（可选）** | `C:\Users\JasonLiu\Desktop\Github-open\Ackem\` | 日常开发；变更需同步到 **A** 再发布 |
| **C. Windows 绿色发行包** | `...\Ackem-v0.0.0\dist\release\Ackem-1.0.0-win-x64\` | 最终用户双击 `Ackem.exe`；**不含**完整 TypeScript 源码 |

```
Github-open/
├── Ackem/                    ← B 开发副本（可选）
└── Ackem-v0.0.0/             ← A 开源仓库根（推 GitHub）
    ├── src/                  ← 主进程 + 渲染进程源码
    ├── docs/                 ← 对外文档（含架构七系统 + 数据层 + IPC）
    ├── dist/                 ← 构建产物 + 协议副本（勿整库 push）
    │   ├── LICENSE.txt …     ← 协议模板/副本
    │   └── release/
    │       └── Ackem-1.0.0-win-x64/   ← C 绿色版（文件夹名保留构建号）
    └── package.json
```

> **说明**：发行目录名仍为 `Ackem-1.0.0-win-x64`（electron-builder 构建号），**产品对外版本号为 v1.0.0**。文档、GitHub Release Tag 使用 **v1.0.0**。

---

## 2. 源码关键目录（仓库 A）

| 路径 | 内容 |
|------|------|
| `src/main/engine/` | 脑+心核心：`orchestrator.ts`、`interpreter.ts`、`relationship.ts`、`emotion.ts`、`psyche.ts` |
| `src/main/memory/` | L4 记忆、embedding、导入 |
| `src/main/prompt/` | 嘴系统 Prompt |
| `src/main/extensions/` | 扩展系统：coordinator、dispatch、openforu |
| `src/main/ipc/` | 渲染进程 API |
| `src/renderer/` | React UI |
| `src/shared/` | 主/渲染共享类型与开关 |
| `electron-builder.yml` | Windows 打包配置 |
| `voice-service/` | 可选 TTS 服务（GPT-SoVits 等） |

编译输出：`npm run build` → `out/`（打进 `app.asar`）。

---

## 3. 绿色版目录（产物 C）

| 路径 | 内容 |
|------|------|
| `Ackem.exe` | 主程序 |
| `resources/app.asar` | 编译后 JS（**非** TypeScript 源码） |
| `resources/docs/` | 随包分发的开发者文档 |
| `resources/models/` | Embedding 等模型（若有） |
| `resources/voice-service/` | 语音服务运行时 |
| `data/` | **用户数据**（备份用；分享 zip 时勿含私人 data） |
| `docs/` | 本发行包附带的文档副本（与 `resources/docs` 同步） |
| `LICENSE.txt` | AGPL 摘要（若已放置） |

用户 `data/` 由 `src/main/layout.ts` → `ensureDataLayout()` 初始化，结构见 [memory-format.md](./memory-format.md)。

---

## 4. `dist/` 目录（勿直接 push 到 Git）

| 路径 | 内容 |
|------|------|
| `dist/GitHub仓库信息.md` | 仓库元数据、GitHub + Gitee 双推 checklist |
| `dist/开源文档索引.md` | dist 层协议与文档索引 |
| `dist/LICENSE.txt` | AGPL 摘要（复制到仓库根 `LICENSE`） |
| `dist/CLA.md` | 贡献者协议 |
| `dist/fresh-build/` | electron-builder 中间输出 |
| `dist/release/` | 对外绿色版 |

**.gitignore** 应排除：`dist/`（或至少 `dist/release/`、`dist/fresh-build/`）、`node_modules/`、`data/`、`.env`。

大文件（绿色版 ~GB 级）通过 **GitHub Releases** 发布，不进入 Git 历史。

---

## 5. 文档读哪里

| 读者 | 入口 |
|------|------|
| GitHub 访客 | 仓库根 [README.md](../README.md) |
| 开发者架构 | [docs/developer/architecture/README.md](./developer/architecture/README.md) |
| 扩展协议 | [docs/developer/DEVELOPER-EXTENSION-PROTOCOL.md](./developer/DEVELOPER-EXTENSION-PROTOCOL.md) |
| 文档总地图 | [docs/OPEN-SOURCE-DOC-MAP.md](./OPEN-SOURCE-DOC-MAP.md) |
| 绿色版用户（离线） | `Ackem-1.0.0-win-x64/docs/README.md` |
| 协议/legal | 仓库根 `LICENSE`、`CLA.md`；`dist/` 内为副本 |

---

## 6. 版本号约定

| 字段 | v1.0.0 取值 |
|------|-------------|
| 产品 / Git Tag | `v1.0.0` |
| `manifest.engineVersion`（扩展） | `>=1.0.0 <2.0.0`（新扩展建议） |
| 扩展引擎 API `engineApiVersion` | `^1.0.0` |
| electron-builder 目录名 | 可能仍为 `Ackem-1.0.0-win-x64`（构建配置） |

*路径说明 · Ackem v1.0.0 · 2026-06*
