# Issue #4 回复话术（已发布 macOS v3）

> 复制下方正文到 https://github.com/JasonLiu0826/ackem/issues/4#issuecomment

---

@deufe 感谢你的持续贡献与耐心！🌹

**macOS 社区构建 v3 已审核并挂到官方 Release 说明**，README 与 [CONTRIBUTORS.md](https://github.com/JasonLiu0826/ackem/blob/main/CONTRIBUTORS.zh.md) 也已更新，你已进入贡献者名单。

### 下载入口

- **Release 说明（含 v3 下载链接与 SHA256）：** https://github.com/JasonLiu0826/ackem/releases/tag/v1.0.0  
- **README macOS 章节：** https://github.com/JasonLiu0826/ackem#macos-community-build-unofficial  

请向 Mac 用户推荐 **仅使用 v3**（arm64 / x64 两个 DMG），勿再分发 v1 zip 或 v2。

### 说明

- 当前标注为 **community / unofficial**，因尚未将 Mac 适配 PR 合并进 `main`，维护者侧也未在实机完整复测。  
- 若用户遇到 Gatekeeper，请引导：`xattr -cr /Applications/Ackem.app` 后 **右键 → 打开**。  
- 问题请继续在本 Issue 反馈，或邮件联系你留下的邮箱。

### 后续（可选，非常欢迎）

若方便，欢迎把 v3 中的 Mac 适配（`modelManager` 路径、`voice-service` Python 兼容、`entitlements.mac.plist` 等）整理成 PR 到 `main`，便于后续官方 CI 构建 Mac 版。

再次感谢！💪
