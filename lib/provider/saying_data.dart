import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '../enums/saying_type.dart';
import '../enums/language.dart';
import '../models/saying_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class SayingsData {
  // 修改缓存键的结构，同时包含类型和语言
  static final Map<String, List<Saying>> _cache = {};

  static String _getCacheKey(SayingType type, Language language) {
    return '${type.name}_${language.name}';
  }

  static Future<List<Saying>> getSayingsByType(
    SayingType type,
    Language language,
  ) async {
    final sayings = await _loadSayings(type, language);
    final filteredByLanguage = sayings.where((s) => s.language == language);

    if (type == SayingType.week) {
      final currentWeekday = DateTime.now().weekday;
      return filteredByLanguage
          .where((s) => s.weekday == currentWeekday)
          .toList();
    }

    return filteredByLanguage.toList();
  }

  static Future<Saying> getRandomSaying({
    SayingType? type,
    Language? language,
  }) async {
    final sayingType = type ?? _getRandomType();
    final currentLanguage = language ?? _getCurrentLanguage();
    final sayings = await getSayingsByType(sayingType, currentLanguage);
    if (sayings.isEmpty) {
      throw Exception('No Found Sayings');
    }
    final random = Random();
    return sayings[random.nextInt(sayings.length)];
  }

  static Future<List<Saying>> _loadSayings(
    SayingType type,
    Language language,
  ) async {
    final cacheKey = _getCacheKey(type, language);
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    final indexContent = await rootBundle.loadString(
      'packages/sayings/lib/data/index.json',
    );
    final indexData = jsonDecode(indexContent);
    final fileName = indexData['files'][language.name][type.name];

    final content = await rootBundle.loadString(
      'packages/sayings/lib/data/$fileName',
    );
    final data = jsonDecode(content);
    final sayings =
        (data['sayings'] as List)
            .map((s) => Saying.fromJson(s, language))
            .toList();

    _cache[cacheKey] = sayings;
    return sayings;
  }

  static SayingType _getRandomType() {
    final types = SayingType.values.toList();
    final random = Random();
    return types[random.nextInt(types.length)];
  }

  static Language _getCurrentLanguage() {
    final String systemLanguage = Platform.localeName.toLowerCase();
    if (systemLanguage.contains('zh') || systemLanguage.contains('cn')) {
      return Language.zh;
    }
    return Language.en;
  }
}
