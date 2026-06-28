# Ackem · Windows 分发说明

> **产品版本**：Ackem **v1.0.0**  
> **绿色版路径**：`Ackem-v0.0.0\dist\release\Ackem-1.0.0-win-x64\`

---

## 安装包里有什么、没有什么

### 包含

| 内容 | 说明 |
|------|------|
| `Ackem.exe` | Electron 主程序 |
| `resources/app.asar` | 编译后应用代码 |
| `resources/models/` | Embedding 等（若随包分发） |
| `resources/voice-service/` | 语音服务运行时（可选启用） |
| `resources/docs/` | 开发者文档副本 |

### 绝不包含

| 内容 | 说明 |
|------|------|
| 用户 `data/` | 记忆、聊天、导入、OpenForU |
| API Key | 首次运行后在设置中填写 |
| `.env` / 开发密钥 | 构建已排除 |

---

## 使用步骤（绿色版）

1. 从 GitHub **Releases** 下载 `Ackem-v1.0.0-win-x64.zip`（或当前构建 zip）  
2. **完整解压** 到 SSD 目录（勿在 zip 内直接运行）  
3. 双击 `Ackem.exe` 或 `启动 Ackem.bat`  
4. 首次启动 10–30 秒（embedding 初始化）  
5. **设置** 中配置 Base URL、API Key、模型 ID  
6. 数据保存在 `./data/`（便携模式）

详见同目录 `START.txt`。

---

## 数据目录

| 模式 | 路径 |
|------|------|
| 便携 | `.\data\` |
| 用户目录 | `%LOCALAPPDATA%\Ackem\` |

结构见 [memory-format.md](./memory-format.md)。

---

## 卸载

- 便携版：删除文件夹；或运行 `Uninstall Ackem.bat`  
- 卸载 **不会** 上传你的数据；删除 `data/` 才会清除本地记忆  

---

## 源码 vs 发行包

| | 源码仓库 | 绿色版 |
|---|----------|--------|
| 路径 | `Ackem-v0.0.0/`（GitHub） | `dist/release/Ackem-1.0.0-win-x64/` |
| 内容 | `src/` TypeScript | `app.asar` 编译产物 |
| 需要 Node | 是（开发） | 否（用户） |

路径总览：[CODEBASE-PATHS.md](./CODEBASE-PATHS.md)

*distribution-windows · Ackem v1.0.0*
