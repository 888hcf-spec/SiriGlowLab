# SiriGlowLab 2.0 完整替换包

## 文件
- ContentView.swift：完整首页、设置面板、功能卡片
- RainbowGlowView.swift：全屏彩虹边缘光效
- SiriGlowLabApp.swift：应用入口
- project.yml：XcodeGen 配置
- Assets.xcassets/AppIcon.appiconset：1024×1024 应用图标
- .github/workflows/build.yml：iPhone IPA 自动构建

## 集中替换
1. 用包内同名文件完整替换仓库中的三个 Swift 文件和 project.yml。
2. 将 Assets.xcassets 文件夹上传到仓库根目录（若已有同名目录，合并并替换 AppIcon.appiconset）。
3. 用包内 build.yml 替换 .github/workflows/build.yml。
4. 一次性提交全部文件到 main。
5. 打开 Actions，等待 SiriGlowLab 2.0 构建成功，再下载 SiriGlowLab-2.0-unsigned-IPA。
6. 用全能签签名后安装。

注意：IPA 是未签名包，不能直接安装。App 仅提供自身内部的 Siri 风格彩虹预览，不能替换 iOS 系统 Siri 动画。
