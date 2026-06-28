# 贡献指南 · Contributing Guide

> 欢迎为 Ackem 贡献！本文档涵盖开发环境、构建、测试与代码规范。

---

## 欢迎的贡献

- Bug 修复与回归测试
- 文档（README、架构、memory-format、扩展协议）
- 官方扩展：经 OpenForU `u/` 本机验证后，PR 到 `ackem/` 内置目录
- 国际化（i18n）与无障碍改进
- 性能与安全修复

## 暂不接收

- 未在 Issue 中讨论的大型架构重写
- 含 API Key、`.env`、私人 `data/` 的 PR
- 试图启用已关闭的 `community/` 市场流水线（v1.0.0 政策见扩展协议）

---

## 1. 开发环境要求

| 工具 | 版本要求 | 说明 |
|------|----------|------|
| **Node.js** | >= 20.x | 推荐 v22 LTS |
| **npm** | >= 10.x | 随 Node.js 分发 |
| **Git** | >= 2.40 | 版本管理 |
| **OS** | Windows 10+ | 当前仅支持 Windows 桌面 |

> 注意：Ackem 当前为 Windows 原生应用，macOS/Linux 构建尚未验证。

### 可选依赖

| 工具 | 用途 | 安装方式 |
|------|------|----------|
| **ONNX Runtime** | Embedding 模型推理 | npm 自动安装 `onnxruntime-node` |
| **Python 3.10+** | 语音服务（TTS/STT） | 系统安装，需在设置中配置路径 |

---

## 2. 搭建开发环境

### 克隆与安装

```bash
git clone https://github.com/JasonLiu0826/Ackem.git
cd Ackem
npm ci
```

### 配置 LLM

Ackem 需要用户自备 LLM API Key。在应用设置界面配置，或编辑 `data/ackem-app-settings.json`：

```json
{
  "openaiBaseUrl": "http://localhost:11434/v1",
  "openaiKey": "ollama",
  "openaiModel": "qwen2.5:7b",
  "embeddingBaseUrl": "http://localhost:11434/v1",
  "embeddingApiKey": "ollama",
  "embeddingModel": "bge-m3"
}
```

### 启动开发模式

```bash
npm run dev
```

这将：
1. 启动 electron-vite dev server（主进程 + 渲染进程 + preload）
2. 自动打开 Electron 窗口
3. 文件变更时自动重载

首次启动会自动创建 `data/` 目录结构并初始化 SQLite 数据库。

> 渲染进程依赖 preload 注入的 `window.ackem` API，必须在 Electron 环境中运行，无法独立在浏览器中打开。

---

## 3. 项目结构

```
ackem/
├── src/
│   ├── main/              # 主进程（Node.js）
│   │   ├── index.ts       #   入口：窗口创建 + IPC 注册
│   │   ├── engine/        #   脑 + 心 + 时间系统
│   │   ├── memory/        #   L4 记忆系统
│   │   ├── prompt/        #   嘴系统（Prompt 模板）
│   │   ├── extensions/    #   扩展系统
│   │   ├── db/            #   数据层（SQLite + Repository）
│   │   ├── ipc/           #   IPC handler 实现
│   │   ├── companion/     #   陪伴模式
│   │   ├── canon/         #   人设系统
│   │   ├── embedding/     #   嵌入就绪态管理
│   │   └── context.ts     #   运行时上下文组装
│   ├── renderer/          # 渲染进程（React）
│   ├── preload/           # preload 桥
│   └── shared/            # 类型共享
├── data/                  # 运行数据目录（gitignored）
├── dist/                  # 构建输出（gitignored）
├── release/               # 打包输出
├── resources/             # 应用资源（图标、模型）
├── docs/                  # 文档
└── package.json           # 依赖与脚本
```

详细目录地图见 [docs/developer/architecture/00-overall-system.md](./docs/developer/architecture/00-overall-system.md)。

---

## 4. 开发工作流

### 主进程开发（引擎/数据层/IPC）

源码：`src/main/{engine,memory,db,ipc,...}`

- 修改引擎逻辑后重启 Electron 窗口即可生效
- 使用 `logger.ts` 输出结构化日志
- 使用 `engine/tracer.ts` 进行单轮决策追踪

### 渲染进程开发（UI）

源码：`src/renderer/`

- 渲染进程热重载（HMR），修改即生效
- 通过 `window.ackem.*` 调用主进程 API

### 扩展开发

- [扩展开发协议](./docs/developer/DEVELOPER-EXTENSION-PROTOCOL.md)
- Skill：在 `extensions/skills/` 下实现 `ExtensionSkill`
- Plugin：实现 `ExtensionPlugin`，UI 使用 Surface 窗口
- OpenForU：用户级扩展，在 `data/openforu/` 中用 `u/` 命名空间开发，稳定后 PR 到内置目录

---

## 5. 构建

### 开发构建

```bash
npm run build
```

编译主进程 + 渲染进程 + preload 到 `dist/`。

### 生产打包

```bash
npm run build:win
```

使用 electron-builder + NSIS 打包为 Windows 安装程序。输出位置：`release/Ackem-{version}-win-x64/`

### 构建注意事项

| 问题 | 解决 |
|------|------|
| 构建内存不足 | `NODE_OPTIONS=--max-old-space-size=8192` |
| `better-sqlite3` 原生模块 | electron-vite 自动处理重编译 |
| `onnxruntime-node` 可选 | 缺失不影响构建，仅 Embedding 降级 |
| 杀软误报 | 绿色版可绕过 NSIS 误报 |

---

## 6. 测试

| 命令 | 用途 |
|------|------|
| `npm test` | 主进程单元测试（LLM mock，离线） |
| `npm run test:renderer` | 渲染进程关键路径 |
| `npm run typecheck` | TypeScript 类型检查 |
| `npm run lint` | ESLint 检查 |

### 测试策略

| 层 | 方式 | 覆盖内容 |
|----|------|----------|
| 引擎核心 | 单元测试 (Vitest) | L0/L1/L2 逻辑、参数计算 |
| 记忆系统 | 单元测试 | 检索评分、衰减、合并去重 |
| 数据层 | 集成测试（SQLite 内存） | Repository CRUD、事务、迁移 |
| 扩展 | 集成测试（mock IPC） | 协议验证、snapshot 构建 |

实机 LLM E2E 需 API Key，日常 PR 不强制全量 LLM 套件。

---

## 7. 代码规范

### TypeScript

- 严格模式：`strict: true`，`noUncheckedIndexedAccess: true`
- 禁止 `any`，优先 `unknown`
- 禁止 `require()`，使用 ESM `import`
- 文件名：小写驼峰

### 命名

| 类型 | 风格 | 示例 |
|------|------|------|
| 文件/目录 | 小写驼峰 | `emotion.ts`、`factStore.ts` |
| 函数 | 小写驼峰 | `emotionStep()`、`getDatabase()` |
| 类型/接口 | PascalCase | `FullState`、`MemoryFact` |
| 常量 | 大写蛇形 | `TIER_B_CHAR_BUDGET` |
| Repository | 自由函数 | `loadFactsFromDb()`、`insertFact()` |

### 原则

- **无类**：优先模块内自由函数和纯数据接口
- **无基类/继承**：组合优于继承
- **副作用函数**：`dataRoot` 作为首参
- **注释**：只在 WHY 非显而易见时写
- **错误处理**：只验证系统边界输入
- **小步 PR，一事一 PR**

### 提交消息

```
<type>: <简短描述>

<可选：详细说明>
```

类型：`feat:` / `fix:` / `docs:` / `refactor:` / `perf:` / `test:` / `chore:`

---

## 8. PR 流程

1. Fork 仓库（或作为协作者直接开分支）
2. 从 `main` 创建特性分支：`fix/...`、`docs/...`、`feat/...`
3. 确保 `npm test` 全部通过
4. 提交 PR 到 `main`，说明：动机、变更范围、如何验证
5. 合并前须同意 [CLA.md](./CLA.md)

### PR 审查要点

| 检查项 | 说明 |
|--------|------|
| 类型安全 | 无 `any`、无类型断言绕过 |
| 错误处理 | 系统边界有校验，内部无冗余 try-catch |
| 性能 | 主路径无阻塞操作，SQLite 查询使用事务 |
| 兼容性 | schema 变更必须通过迁移版本（V11+） |
| 文档 | 架构变更同步更新 `docs/developer/architecture/` |

---

## 9. 许可证

提交并被合并的代码以 **AGPL-3.0** 发布；您同时授予维护者在 CLA 中描述的多许可权利。

---

## 联系

- 安全问题：[SECURITY.md](./SECURITY.md)
- 一般讨论：GitHub Issues / Discussions

---

## 相关资源

| 资源 | 链接 |
|------|------|
| 系统架构 | [docs/developer/architecture/](./docs/developer/architecture/) |
| 扩展协议 | [docs/developer/DEVELOPER-EXTENSION-PROTOCOL.md](./docs/developer/DEVELOPER-EXTENSION-PROTOCOL.md) |
| 数据目录格式 | [docs/memory-format.md](./docs/memory-format.md) |
| AI 检索策略 | [docs/ai-context-and-retrieval-policy.md](./docs/ai-context-and-retrieval-policy.md) |

---

*Ackem v1.0.0 · 贡献指南*
