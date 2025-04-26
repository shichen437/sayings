# Sayings

一个轻量级的Flutter格言库，提供多种分类的格言数据，支持按类型和语言获取随机格言。

[English](README.md) | 中文版

## ✨ 功能特性

- 📅 **按星期获取** - 每天自动显示对应的星期格言
- 🌟 **多种分类** - 生活、工作、音乐等主题格言
- 🌍 **多语言支持** - 中英文双语格言
- 🎲 **随机获取** - 支持随机获取任意类型的格言
- ⚡ **高性能** - 内置缓存机制，加载快速
- 📦 **零依赖** - 纯Dart实现，无额外依赖

## 📦 安装

在`pubspec.yaml`中添加依赖：

```yaml
dependencies:
  sayings: ^0.0.1
```

然后运行：

```bash
flutter pub get
```

## 使用方法

### 导入包

```dart
import 'package:sayings/sayings.dart';
```

### 初始化

```dart
final sayingsPlugin = Sayings();
```

### 获取随机格言

```dart
// 获取任意类型的随机格言
Saying randomSaying = sayingsPlugin.getRandomSaying(
  type: SayingType.work,
  language: Language.zh
);

// 获取特定类型的随机格言
Saying lifeSaying = sayingsPlugin.getRandomSaying(SayingType.life);

// 直接获取随机格言内容
String content = sayingsPlugin.getRandomSayingContent(SayingType.music);
```
## 格言类型

插件支持以下格言类型：

- `SayingType.week` - 与星期相关的格言
- `SayingType.life` - 与生活相关的格言
- `SayingType.work` - 与工作相关的格言
- `SayingType.music` - 与音乐相关的格言

## 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。
