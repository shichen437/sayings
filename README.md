# Sayings

A lightweight Flutter library providing categorized quotes/sayings, supporting random retrieval by type and language.

[中文版](README_zh.md) | English

## ✨ Features

- 📅 **Weekly Quotes** - Automatically displays corresponding weekday quotes
- 🌟 **Multiple Categories** - Life, work, music themed quotes
- 🌍 **Multilingual Support** - Chinese and English quotes
- 🎲 **Random Retrieval** - Supports getting random quotes of any type
- ⚡ **High Performance** - Built-in caching mechanism for fast loading
- 📦 **Zero Dependencies** - Pure Dart implementation

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  sayings: ^0.0.5
```

Then run:

```bash
flutter pub get
```

## Usage

### Import

```dart
import 'package:sayings/sayings.dart';
```

### Initialize

```dart
final sayingsPlugin = Sayings();
```

### Get Random Saying

```dart
// Get random quote of any type
Saying randomSaying = sayingsPlugin.getRandomSaying(
  type: SayingType.work,
  language: Language.zh
);

// Get specific type of quote
Saying lifeSaying = sayingsPlugin.getRandomSaying(SayingType.life);

// Get quote content directly
String content = sayingsPlugin.getRandomSayingContent(SayingType.music);
```
## Types

Supported quote types:

- `SayingType.week` - Weekday related quotes
- `SayingType.life` - Life related quotes
- `SayingType.work` - Work related quotes
- `SayingType.music` - Music related quotes

## License

MIT License - See [LICENSE](LICENSE) file.
